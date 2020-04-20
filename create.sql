--create table Artists

CREATE TABLE Artists 
(
    artist VARCHAR(256) NOT NULL
);

ALTER TABLE Artists
ADD CONSTRAINT artist_pk PRIMARY KEY (artist);

--create table Regions

CREATE TABLE Regions
(
    region char(2) NOT NULL 
);

ALTER TABLE Regions
ADD CONSTRAINT region_pk PRIMARY KEY (region);

--create table Tracks

CREATE TABLE Tracks
(
    track_url varchar(256) NOT NULL,
    track varchar(256) NOT NULL,
    artist varchar(256) NOT NULL
);

ALTER TABLE Tracks
ADD CONSTRAINT track_url_pk PRIMARY KEY (track_url);

ALTER TABLE Tracks
    ADD CONSTRAINT artist_fk FOREIGN KEY ( artist )
        REFERENCES Artists ( artist );

--create table Popularity

CREATE TABLE Popularity
(
    track_url varchar(256) NOT NULL,
    date_viewed date NOT NULL,
    region char(2) NOT NULL,
    chart_position NUMBER(10) NOT NULL,
    streams NUMBER(10) NOT NULL
);

ALTER TABLE Popularity
    ADD CONSTRAINT popularity_pk PRIMARY KEY ( track_url,
                                               date_viewed,
                                               region );

ALTER TABLE Popularity
    ADD CONSTRAINT track_url_fk FOREIGN KEY ( track_url )
        REFERENCES Tracks ( track_url );

ALTER TABLE Popularity
    ADD CONSTRAINT region_fk FOREIGN KEY ( region )
        REFERENCES Regions ( region );