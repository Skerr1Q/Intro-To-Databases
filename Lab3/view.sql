CREATE OR REPLACE VIEW streams_popularity AS
    SELECT
        tracks.track,
        tracks.artist,
        tracks.track_url,
        popularity.streams,
        popularity.chart_position,
        popularity.date_viewed,
        popularity.region
    FROM popularity
    JOIN tracks     
    ON tracks.track_url = popularity.track_url;