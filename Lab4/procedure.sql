SET SERVEROUTPUT ON;

BEGIN
    dbms_output.enable;
END;

--Change procedure: insert popularity stats in some region for some date
--Exception: Track not found

/

CREATE OR REPLACE PROCEDURE add_track (
    track_url_par       IN  popularity.track_url%TYPE,
    region_par          IN  popularity.region%TYPE,
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
        streams_par
    );

    dbms_output.put_line('success');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('no_data_found error');
END;