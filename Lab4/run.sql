BEGIN
    dbms_output.enable;
END;
/

SET SERVEROUTPUT ON;
-- function

DECLARE
    CURSOR cur_function IS
    SELECT
        *
    FROM
        TABLE ( total_streams_by_track('Chantaje', 'Shakira') );

BEGIN
    FOR cur_row IN cur_function LOOP
        dbms_output.put_line(cur_row.artist_total_streams
                             || ' '
                             || cur_row.track_total_streams
                             || ' '
                             || cur_row.streams_total_streams
                             || ' '
                             || cur_row.region_total_streams);
    END LOOP;
END;

-- procedure

/

BEGIN
    add_track('https://open.spotify.com/track/3QwBODjSEzelZyVjxPOHdq', 'fr', 3, '01-JAN-17', 12345);
    add_track('https://open.spotify.com/track/3QwBODjSEzelZyVjxPOHyt', 'ec', 5, '03-JAN-17', 12645);
END;

-- trigger

UPDATE popularity
SET
    streams = 0
WHERE
        track_url = 'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg'
    AND date_viewed = '01-JAN-17'
    AND region = 'ec';