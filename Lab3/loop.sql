DECLARE
    TYPE arr_track_url IS
        VARRAY(3) OF VARCHAR2(100 CHAR);
    TYPE arr_track IS
        VARRAY(3) OF VARCHAR2(100 CHAR);
    TYPE arr_artist IS
        VARRAY(3) OF VARCHAR2(100 CHAR);
    track_urls_test  arr_track_url := arr_track_url('https://open.spotify.com/track/3AEZUABDXNtecAOSC1qTfo', 'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg',
    'https://open.spotify.com/track/3QwBODjSEzelZyVjxPOHdq');
    tracks_test      arr_track := arr_track('Reggaetón Lento (Bailemos)', 'Chantaje', 'Otra Vez (feat. J Balvin)');
    artist_test      arr_artist := arr_artist('CNCO	', 'Shakira', 'Zion Lennox');
    items_count      INTEGER := 3;
BEGIN
    FOR i IN 1..items_count LOOP
        INSERT INTO artists ( artist ) VALUES ( artist_test(i) );

        INSERT INTO tracks (
            track_url,
            track,
            artist
        ) VALUES (
            track_urls_test(i),
            tracks_test(i),
            artist_test(i)
        );

    END LOOP;
END;