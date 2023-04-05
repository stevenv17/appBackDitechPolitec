CREATE OR REPLACE PACKAGE STEVEN."PKG_AUTHORS" AS 

PROCEDURE SP_GET_AUTHORS (cjsoninput IN CLOB, cjsonoutput OUT CLOB);
PROCEDURE SP_SAVE_AUTHOR (cjsoninput IN CLOB, cjsonoutput OUT CLOB);
PROCEDURE SP_DELETE_AUTHOR (cjsoninput IN CLOB, cjsonoutput OUT CLOB);

END PKG_AUTHORS;

CREATE OR REPLACE PACKAGE BODY STEVEN."PKG_AUTHORS" AS
    CBNAME_PACKAGE CONSTANT VARCHAR2(25) := 'PKG_AUTHORS';
    
----------------------------------------
-- GET AUTHORS
----------------------------------------
PROCEDURE SP_GET_AUTHORS (cjsoninput IN CLOB, cjsonoutput OUT CLOB) IS
	idAuthor NUMBER;
BEGIN
	idAuthor := JSON_VALUE(cjsoninput, '$.id');
    BEGIN 
	    IF idAuthor > 0 THEN
	        SELECT JSON_ARRAYAGG (JSON_OBJECT(
	        		'id' VALUE a.ID, 
	        		'name' VALUE a.NAME,
	        		'books' VALUE (SELECT JSON_ARRAYAGG ( JSON_OBJECT ('id' VALUE b.ID, 'name' VALUE b.NAME) )
	        						FROM BOOKS_AUTHORS ba2
	        						INNER JOIN BOOKS b ON b.ID = ba2.ID_BOOK
	        						WHERE ba2.ID_AUTHOR = a.ID
	        						)
	        )) INTO cjsonoutput
	       	FROM AUTHORS a
	       	WHERE a.ID = idAuthor;
	    ELSE
	    	SELECT JSON_ARRAYAGG (JSON_OBJECT(
	        		'id' VALUE ID, 
	        		'name' VALUE NAME
	        )) INTO cjsonoutput
	       	FROM AUTHORS a;
       	END IF;
       
       
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        cjsonoutput := '{"error":-1001,"message":"NOT FOUND"}';
        return;
    END;

EXCEPTION 
WHEN OTHERS THEN           
      ROLLBACK;
      cjsonoutput := '{"error":-1001,"message":"Error desconocido en..."}';
END SP_GET_AUTHORS;


----------------------------------------
-- SAVE AUTHOR (EDIT/CREATE)
----------------------------------------
PROCEDURE SP_SAVE_AUTHOR (cjsoninput IN CLOB, cjsonoutput OUT CLOB) IS
	idAuthor NUMBER;
	nameAuthor VARCHAR2(128);
BEGIN
	idAuthor := JSON_VALUE(cjsoninput, '$.id');
	nameAuthor := JSON_VALUE(cjsoninput, '$.name');

    IF idAuthor > 0 THEN
        UPDATE AUTHORS SET NAME = nameAuthor WHERE ID = idAuthor;
       	cjsonoutput := '{"message":"AUTHOR updated."}';
    ELSE
    	INSERT INTO AUTHORS (NAME) VALUES (nameAuthor);
    	cjsonoutput := '{"message":"AUTHOR created."}';
   	END IF;
       
EXCEPTION 
WHEN OTHERS THEN           
      ROLLBACK;
      cjsonoutput := '{"error":-1001,"message":"Error desconocido en..."}';
END SP_SAVE_AUTHOR;

----------------------------------------
-- DELETE AUTHOR
----------------------------------------
PROCEDURE SP_DELETE_AUTHOR (cjsoninput IN CLOB, cjsonoutput OUT CLOB) IS
	idAuthor NUMBER;
BEGIN
	idAuthor := JSON_VALUE(cjsoninput, '$.id');

    IF idAuthor > 0 THEN
    	DELETE FROM BOOKS_AUTHORS WHERE ID_AUTHOR = idAuthor;
        DELETE FROM AUTHORS WHERE ID = idAuthor;
   	END IF;
   
   	cjsonoutput := '{"message":"AUTHOR deleted."}';
       
EXCEPTION 
WHEN OTHERS THEN           
      ROLLBACK;
      cjsonoutput := '{"message":-1001,"mensaje":"Error desconocido en..."}';
END SP_DELETE_AUTHOR;

   
   
END PKG_AUTHORS;
