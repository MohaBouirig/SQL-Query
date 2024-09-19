SET SERVEROUTPUT ON;
SET VERIFY OFF;
/*********************/
/*  SELECT ... INTO  */
/*********************/

/* 
Dins de PL-SQL es poden fer consultes SELECT
El resultat s'ha de guardar a variables especificades dins la clàusula INTO
Per això ens referirem com SELECT..INTO

SELECT INTO només funciona si retorna una SOLA FILA,
- Si retorna 0 filas da error NO_DATA_FOUND, 
- Si retorna >1 da el error TOO_MANY_ROOWS */


/* Ejemplo: Programa que demana una identitat d'empleat
per teclat i mostra el seu nom, cognoms i salari
Si el treballador no existeix, ens mostra un missatge avisant-nos. */

DECLARE
    v_nom VARCHAR2(30);-- El tipus de dada ha de ser igual al de la columna
    v_cognom1 VARCHAR2(50);  
    v_cognom2 VARCHAR2(50);  
	v_salari NUMBER;          
    --Demanem un valor d'identitat d'empleat
	v_empleat_id NUMBER := &identitat_empleat; 

BEGIN

	SELECT nom, cognom1, cognom2, salari 
    INTO v_nom, v_cognom1, v_cognom2, v_salari
	FROM empleat
	WHERE empleat_id = v_empleat_id; 
		/* Un SELECT INTO només funciona correctament si retorna 1 FILA,
		Si retorna 0 filas dona l'error NO_DATA_FOUND, 
		Si devuelve > 1 fila dona l'error TOO_MANY_ROOWS */

	DBMS_OUTPUT.PUT_LINE ('L''empleat amb identitat ' || v_empleat_id || ' te aquestes dades: ');
    DBMS_OUTPUT.PUT_LINE ('Nom: ' || v_nom);
    DBMS_OUTPUT.PUT_LINE ('Cognom1: ' || v_cognom1);
    DBMS_OUTPUT.PUT_LINE ('Cognom2: ' || v_cognom2);
	DBMS_OUTPUT.PUT_LINE ('Salari: ' || v_salari);

EXCEPTION

	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('No existeix un empleat amb identitat ' || v_empleat_id);

	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE ('Molts empleats amb aquest codi');

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');

END;


DECLARE
    v_nom VARCHAR2(30);-- El tipus de dada ha de ser igual al de la columna
    v_cognom1 VARCHAR2(50);  
    v_cognom2 VARCHAR2(50);  
	v_salari NUMBER;          
    --Demanem un valor d'identitat d'empleat
	v_empleat_id NUMBER := &identitat_empleat; 
    v_existeix NUMBER := 0;

BEGIN
	SELECT COUNT(*) 
    INTO v_existeix
	FROM empleat
	WHERE empleat_id = v_empleat_id;
 
    IF v_existeix = 0
    THEN
        DBMS_OUTPUT.PUT_LINE ('Count(*): No existeix un empleat amb identitat ' || v_empleat_id);
    ELSE
        SELECT nom, cognom1, cognom2, salari 
        INTO v_nom, v_cognom1, v_cognom2, v_salari
        FROM empleat
        WHERE empleat_id = v_empleat_id; 
            /* Un SELECT INTO només funciona correctament si retorna 1 FILA,
            Si retorna 0 filas dona l'error NO_DATA_FOUND, 
            Si devuelve > 1 fila dona l'error TOO_MANY_ROOWS */
    
        DBMS_OUTPUT.PUT_LINE ('L''empleat amb identitat ' || v_empleat_id || ' te aquestes dades: ');
        DBMS_OUTPUT.PUT_LINE ('Nom: ' || v_nom);
        DBMS_OUTPUT.PUT_LINE ('Cognom1: ' || v_cognom1);
        DBMS_OUTPUT.PUT_LINE ('Cognom2: ' || v_cognom2);
        DBMS_OUTPUT.PUT_LINE ('Salari: ' || v_salari);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE ('El programa continua');
    
EXCEPTION

	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('No existeix un empleat amb identitat ' || v_empleat_id);

	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE ('Molts empleats amb aquest codi');

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');

END;

DECLARE
    v_nom VARCHAR2(30);-- El tipus de dada ha de ser igual al de la columna
    v_cognom1 VARCHAR2(50);  
    v_cognom2 VARCHAR2(50);  
	v_salari NUMBER;          
    --Demanem un valor d'identitat d'empleat
	v_empleat_id NUMBER := &identitat_empleat; 

BEGIN

    BEGIN
        SELECT nom, cognom1, cognom2, salari 
        INTO v_nom, v_cognom1, v_cognom2, v_salari
        FROM empleat
        WHERE empleat_id = v_empleat_id; 
            /* Un SELECT INTO només funciona correctament si retorna 1 FILA,
            Si retorna 0 filas dona l'error NO_DATA_FOUND, 
            Si devuelve > 1 fila dona l'error TOO_MANY_ROOWS */
    
        DBMS_OUTPUT.PUT_LINE ('L''empleat amb identitat ' || v_empleat_id || ' te aquestes dades: ');
        DBMS_OUTPUT.PUT_LINE ('Nom: ' || v_nom);
        DBMS_OUTPUT.PUT_LINE ('Cognom1: ' || v_cognom1);
        DBMS_OUTPUT.PUT_LINE ('Cognom2: ' || v_cognom2);
        DBMS_OUTPUT.PUT_LINE ('Salari: ' || v_salari);
    
    EXCEPTION
    
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE ('Bloc intern: no existeix un empleat amb identitat ' || v_empleat_id);
    
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE ('Molts empleats amb aquest codi');
    
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
    END;
    
    DBMS_OUTPUT.PUT_LINE ('El programa continua');
END;
