--Query 1
SELECT
    SUM(streams) as total_streams,
    region
FROM
    popularity
WHERE
    chart_position <= 5
GROUP BY
    region
ORDER BY
    SUM(streams);

--Query 2

SELECT
    popularity.streams,
    tracks.artist,
    tracks.track
FROM
         popularity
    INNER JOIN tracks ON tracks.track_url = popularity.track_url
WHERE
        popularity.region = 'ec'
    AND popularity.chart_position <= 20
    AND popularity.date_viewed = '01-JAN-17'
ORDER BY
    popularity.streams DESC;

--Query 3

SELECT
    streams,
    date_viewed
FROM
    popularity
WHERE
    track_url = 'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg';