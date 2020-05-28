CREATE OR REPLACE PACKAGE streams_popularity_package IS
    PROCEDURE add_track (
        track_url_par       IN  popularity.track_url%TYPE,
        region_par          IN  popularity.region%TYPE,
        chart_position_par  IN  popularity.chart_position%TYPE,
        date_viewed_par     IN  popularity.date_viewed%TYPE,
        streams_par         IN  popularity.streams%TYPE
    );

    FUNCTION total_streams_by_track (
        track_par   tracks.track%TYPE,
        artist_par  tracks.artist%TYPE
    ) RETURN total_streams_table
        PIPELINED;

END streams_popularity_package;
/

CREATE OR REPLACE PACKAGE BODY streams_popularity_package IS

    PROCEDURE add_track (
        track_url_par       IN  popularity.track_url%TYPE,
        region_par          IN  popularity.region%TYPE,
        chart_position_par  IN  popularity.chart_position%TYPE,
        date_viewed_par     IN  popularity.date_viewed%TYPE,
        streams_par         IN  popularity.streams%TYPE
    ) IS

        track_url_var  tracks.track_url%TYPE;
        track_var      tracks.track%TYPE;
        artist_var     tracks.artist%TYPE;
    BEGIN
        SELECT
            artist,
            track,
            track_url
        INTO
            artist_var,
            track_var,
            track_url_var
        FROM
            tracks
        WHERE
            tracks.track_url = track_url_par;

        INSERT INTO popularity VALUES (
            track_url_par,
            date_viewed_par,
            region_par,
            chart_position_par,
            streams_par
        );

        dbms_output.put_line('success');
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('no_data_found error');
    END;

    FUNCTION total_streams_by_track (
        track_par   tracks.track%TYPE,
        artist_par  tracks.artist%TYPE
    ) RETURN total_streams_table
        PIPELINED
    IS
-- create variables

        artist_var         tracks.track%TYPE;
        track_var          artists.artist%TYPE;
        region_var         regions.region%TYPE;
        total_streams_var  popularity.streams%TYPE;
        CURSOR total_streams_cur IS
        SELECT
            artist           AS artist,
            track            AS track,
            region           AS region,
            SUM(streams)     AS total_streams
        FROM
            streams_popularity
        GROUP BY
            track,
            artist,
            region
        HAVING artist = artist_par
               AND track = track_par
        ORDER BY
            track,
            artist,
            region;

    BEGIN
        OPEN total_streams_cur;
        LOOP
            FETCH total_streams_cur INTO
                artist_var,
                track_var,
                region_var,
                total_streams_var;
            EXIT WHEN total_streams_cur%notfound;
            PIPE ROW ( total_streams(artist_var, track_var, total_streams_var, region_var) );
        END LOOP;

    END;

END streams_popularity_package;