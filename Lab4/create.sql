-- Generated by Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   at:        2020-05-25 05:52:02 EEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE artists (
    artist VARCHAR2(256) NOT NULL
);

ALTER TABLE artists ADD CONSTRAINT artists_pk PRIMARY KEY ( artist );

CREATE TABLE popularity (
    track_url       VARCHAR2(256) NOT NULL,
    date_viewed     DATE NOT NULL,
    region          CHAR(2) NOT NULL,
    chart_position  INTEGER NOT NULL,
    streams         INTEGER NOT NULL
);

ALTER TABLE popularity
    ADD CONSTRAINT popularity_pk PRIMARY KEY ( date_viewed,
                                               region,
                                               track_url );

CREATE TABLE regions (
    region CHAR(2) NOT NULL
);

ALTER TABLE regions ADD CONSTRAINT regions_pk PRIMARY KEY ( region );

CREATE TABLE tracks (
    track_url  VARCHAR2(256) NOT NULL,
    artist     VARCHAR2(256) NOT NULL
);

ALTER TABLE tracks ADD CONSTRAINT tracks_pk PRIMARY KEY ( track_url );

ALTER TABLE tracks
    ADD CONSTRAINT artists_fk FOREIGN KEY ( artist )
        REFERENCES artists ( artist );

ALTER TABLE popularity
    ADD CONSTRAINT regions_fk FOREIGN KEY ( region )
        REFERENCES regions ( region );

ALTER TABLE popularity
    ADD CONSTRAINT tracks_fk FOREIGN KEY ( track_url )
        REFERENCES tracks ( track_url );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0