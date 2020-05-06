--drop all tables

SELECT
    'DROP TABLE "'
    || table_name
    || '" CASCADE CONSTRAINTS;'
FROM
    user_tables;

--create table Artists

CREATE TABLE artists (
    artist VARCHAR(256) NOT NULL
);

ALTER TABLE artists ADD CONSTRAINT artist_pk PRIMARY KEY ( artist );

--create table Regions

CREATE TABLE regions (
    region CHAR(2) NOT NULL
);

ALTER TABLE regions ADD CONSTRAINT region_pk PRIMARY KEY ( region );

--create table Tracks

CREATE TABLE tracks (
    track_url  VARCHAR(256) NOT NULL,
    track      VARCHAR(256) NOT NULL,
    artist     VARCHAR(256) NOT NULL
);

ALTER TABLE tracks ADD CONSTRAINT track_url_pk PRIMARY KEY ( track_url );

ALTER TABLE tracks
    ADD CONSTRAINT artist_fk FOREIGN KEY ( artist )
        REFERENCES artists ( artist );

--create table Popularity

CREATE TABLE popularity (
    track_url       VARCHAR(256) NOT NULL,
    date_viewed     DATE NOT NULL,
    region          CHAR(2) NOT NULL,
    chart_position  NUMBER(10) NOT NULL,
    streams         NUMBER(10) NOT NULL
);

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