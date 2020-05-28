-- change view
CREATE OR REPLACE VIEW streams_popularity AS
    SELECT
        tracks.track,
        tracks.artist,
        popularity.streams,
        popularity.date_viewed,
        popularity.region
    FROM
             popularity
        JOIN tracks ON tracks.track_url = popularity.track_url
    ORDER BY
        tracks.track,
        tracks.artist,
        popularity.date_viewed;
/

CREATE OR REPLACE TYPE total_streams IS OBJECT (
    artist_total_streams   VARCHAR(256),
    track_total_streams    VARCHAR(256),
    streams_total_streams  INTEGER,
    region_total_streams   VARCHAR(256)
);
/

CREATE OR REPLACE TYPE total_streams_table IS
    TABLE OF total_streams;
                  
-- function : shows how much a song was streamed in all regions 
    
/

CREATE OR REPLACE FUNCTION total_streams_by_track (
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