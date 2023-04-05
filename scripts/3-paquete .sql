CREATE OR REPLACE PACKAGE STEVEN."PKG_BOOKS" AS 

PROCEDURE SP_GET_BOOKS (cjsoninput IN CLOB, cjsonoutput OUT CLOB);
PROCEDURE SP_SAVE_BOOK (cjsoninput IN CLOB, cjsonoutput OUT CLOB);
PROCEDURE SP_DELETE_BOOK (cjsoninput IN CLOB, cjsonoutput OUT CLOB);

END PKG_BOOKS;

CREATE OR REPLACE PACKAGE BODY STEVEN."PKG_BOOKS" AS
    CBNAME_PACKAGE CONSTANT VARCHAR2(25) := 'PKG_BOOKS';
    
----------------------------------------
-- GET BOOKS
----------------------------------------
PROCEDURE SP_GET_BOOKS (cjsoninput IN CLOB, cjsonoutput OUT CLOB) IS
	idBook NUMBER;
BEGIN
	idBook := JSON_VALUE(cjsoninput, '$.id');
    BEGIN 
	    IF idBook > 0 THEN
	        SELECT JSON_ARRAYAGG (JSON_OBJECT(
	        		'id' VALUE b.ID, 
	        		'name' VALUE b.NAME,
	        		'authors' VALUE (SELECT JSON_ARRAYAGG ( JSON_OBJECT ('id' VALUE a.ID, 'name' VALUE a.NAME) )
	        						FROM BOOKS_AUTHORS ba2
	        						INNER JOIN AUTHORS a ON a.ID = ba2.ID_AUTHOR
	        						WHERE ba2.ID_BOOK = b.ID
	        						)
	        )) INTO cjsonoutput
	       	FROM BOOKS b
	       	WHERE b.ID = idBook;
	    ELSE
	    	SELECT JSON_ARRAYAGG (JSON_OBJECT(
	        		'id' VALUE ID, 
	        		'name' VALUE NAME
	        )) INTO cjsonoutput
	       	FROM BOOKS b ;
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
END SP_GET_BOOKS;


----------------------------------------
-- SAVE BOOK (EDIT/CREATE)
----------------------------------------
PROCEDURE SP_SAVE_BOOK (cjsoninput IN CLOB, cjsonoutput OUT CLOB) IS
	idBook NUMBER;
	nameBook VARCHAR2(128);
BEGIN
	idBook := JSON_VALUE(cjsoninput, '$.id');
	nameBook := JSON_VALUE(cjsoninput, '$.name');

    IF idBook > 0 THEN
        UPDATE BOOKS SET NAME = nameBook WHERE ID = idBook;
       	cjsonoutput := '{"message":"Book updated."}';
    ELSE
    	INSERT INTO BOOKS (NAME) VALUES (nameBook)
    	RETURNING ID INTO idBook;
    	cjsonoutput := '{"message":"Book created."}';
   	END IF;
   
   DELETE FROM BOOKS_AUTHORS  WHERE ID_BOOK = idBook;
  
  FOR author IN (
  				SELECT  id 
  				FROM JSON_TABLE( cjsoninput, '$.authors[*]'
                COLUMNS (  id NUMBER PATH '$.id' ))
   ) LOOP
     INSERT INTO BOOKS_AUTHORS (ID_BOOK, ID_AUTHOR) VALUES (idBook, author.id);
   END LOOP;
       
EXCEPTION 
WHEN OTHERS THEN           
      ROLLBACK;
      cjsonoutput := '{"error":-1001,"message":"Error desconocido en..."}';
END SP_SAVE_BOOK;

----------------------------------------
-- DELETE BOOK
----------------------------------------
PROCEDURE SP_DELETE_BOOK (cjsoninput IN CLOB, cjsonoutput OUT CLOB) IS
	idBook NUMBER;
BEGIN
	idBook := JSON_VALUE(cjsoninput, '$.id');

    IF idBook > 0 THEN
    	DELETE FROM BOOKS_AUTHORS WHERE ID_BOOK = idBook;
        DELETE FROM BOOKS WHERE ID = idBook;
   	END IF;
   
   	cjsonoutput := '{"message":"Book deleted."}';
       
EXCEPTION 
WHEN OTHERS THEN           
      ROLLBACK;
      cjsonoutput := '{"message":-1001,"mensaje":"Error desconocido en..."}';
END SP_DELETE_BOOK;

   
   
END PKG_BOOKS;
