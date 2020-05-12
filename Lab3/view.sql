CREATE OR REPLACE VIEW streams_popularity AS
    SELECT
        tracks.track,
        tracks.artist,
        tracks.track_url,
        popularity.streams,
        popularity.chart_position,
        popularity.date_viewed,
        popularity.region
    FROM
             popularity
        JOIN tracks ON tracks.track_url = popularity.track_url
    WHERE
        ( popularity.chart_position <= 5
          AND popularity.date_viewed = '01 - jan - 17' )
        AND ( popularity.chart_position <= 20
              AND popularity.date_viewed = '01 - jan - 17'
              AND popularity.region = 'ec' )
        AND ( popularity.chart_position <= 5
              AND ( popularity.date_viewed BETWEEN '01 - jan - 17' AND '07 - jan - 17' )
              AND popularity.region = 'ec' );