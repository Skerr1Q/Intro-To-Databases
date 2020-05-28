CREATE OR REPLACE TRIGGER streams_decrease_trigger BEFORE
    UPDATE ON popularity
    FOR EACH ROW 
    WHEN ( new.streams < old.streams )
BEGIN 	
    RAISE_APPLICATION_ERROR(-20101, 'Cannot update streams to lesser value');
    ROLLBACK;
END;