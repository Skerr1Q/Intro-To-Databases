CREATE TABLE artists (
    artist VARCHAR(256) NOT NULL
);

ALTER TABLE artists ADD CONSTRAINT artist_pk PRIMARY KEY ( artist );

CREATE TABLE regions (
    region VARCHAR(256) NOT NULL
);

ALTER TABLE regions ADD CONSTRAINT region_pk PRIMARY KEY ( region );

CREATE TABLE tracks (
    track_url  VARCHAR(256) NOT NULL,
    track      VARCHAR(256) NOT NULL,
    artist     VARCHAR(256) NOT NULL
);

ALTER TABLE tracks ADD CONSTRAINT track_url_pk PRIMARY KEY ( track_url );

ALTER TABLE tracks
    ADD CONSTRAINT artist_fk FOREIGN KEY ( artist )
        REFERENCES artists ( artist );

CREATE TABLE popularity

(
    track_url       VARCHAR(256) NOT NULL,
    date_viewed     DATE NOT NULL,
    region          VARCHAR(256) NOT NULL,
    streams         INTEGER NOT NULL );
ALTER TABLE popularity
    ADD CONSTRAINT popularity_pk PRIMARY KEY ( track_url,
                                               date_viewed,
                                               region );

ALTER TABLE popularity
    ADD CONSTRAINT track_url_fk FOREIGN KEY ( track_url )
        REFERENCES tracks ( track_url );

ALTER TABLE popularity
    ADD CONSTRAINT region_fk FOREIGN KEY ( region )
        REFERENCES regions ( region );