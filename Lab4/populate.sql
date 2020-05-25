INSERT INTO regions ( region ) VALUES ( 'ec' );
INSERT INTO regions ( region ) VALUES ( 'fr' );
INSERT INTO regions ( region ) VALUES ( 'us' );

INSERT INTO artists VALUES ( 'Shakira' );
INSERT INTO artists VALUES ( 'CNCO' );
INSERT INTO artists VALUES ( 'Zion and Lennox' );

INSERT INTO tracks (
    track_url,
    track,
    artist
) VALUES (
    'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg',
    'Chantaje',
    'Shakira'
);
INSERT INTO tracks (
    track_url,
    track,
    artist
) VALUES (
    'https://open.spotify.com/track/3AEZUABDXNtecAOSC1qTfo',
    'Reggaet??n Lento (Bailemos)',
    'CNCO'
);
INSERT INTO tracks (
    track_url,
    track,
    artist
) VALUES (
    'https://open.spotify.com/track/3QwBODjSEzelZyVjxPOHdq',
    'Otra Vez (feat. J Balvin)',
    'Zion and Lennox'
);

INSERT INTO popularity (
    track_url,
    date_viewed,
    region,
    chart_position,
    streams
) VALUES (
    'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg',
    TO_DATE('1/1/2017', 'MM/DD/YYYY'),
    'ec',
    2,
    19270
);
INSERT INTO popularity (
    track_url,
    date_viewed,
    region,
    chart_position,
    streams
) VALUES (
    'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg',
    TO_DATE('1/2/2017', 'MM/DD/YYYY'),
    'ec',
    2,
    15594
);
INSERT INTO popularity (
    track_url,
    date_viewed,
    region,
    chart_position,
    streams
) VALUES (
    'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg',
    TO_DATE('1/3/2017', 'MM/DD/YYYY'),
    'ec',
    2,
    16614
);
