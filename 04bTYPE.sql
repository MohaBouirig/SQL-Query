SET SERVEROUTPUT ON;
SET VERIFY OFF;
/*******************/    
/* ATRIBUT %TYPE  */
/*******************/
-- L'atribut %TYPE permet declarar variables amb el mateix tipus
-- de dades que una columna d'una taula.


/* Exemple: Programa que demana una identitat d'empleat
per teclat i mostra el seu nom, cognoms, salari, ofici i departament_id
Si l'empleat no existeix mostra el missatge "Empleat inexistent" */


DECLARE
    -- v_empleat_id tiene el mismo tipo de dato que la columna EMPLEAT.EMPLEAT_ID
	v_empleat_id empleat.empleat_id%TYPE := &introdueix_id;
    v_nom empleat.nom%TYPE;
    v_cognom1 empleat.cognom1%TYPE; 
    v_cognom2 empleat.cognom2%TYPE;  
	v_salari empleat.salari%TYPE;     	
	v_ofici empleat.ofici%TYPE;
	v_departament_id empleat.departament_id%TYPE;


BEGIN

	SELECT nom, cognom1, cognom2, salari, ofici, departament_id
    INTO v_nom, v_cognom1, v_cognom2, v_salari, v_ofici, v_departament_id
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
	DBMS_OUTPUT.PUT_LINE ('Ofici: ' || v_ofici);
    DBMS_OUTPUT.PUT_LINE ('Departament_id: ' || v_departament_id);
    
EXCEPTION

	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('No existeix un empleat amb identitat ' || v_empleat_id);

	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE ('Molts empleats amb aquest codi');

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');

END;







