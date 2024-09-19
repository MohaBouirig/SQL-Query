SET SERVEROUTPUT ON;
SET VERIFY OFF;
/*************************/
/* ATRIBUTO %ROWTYPE (I) */
/*************************/

-- L'atribut %ROWTYPE permet declarar variables amb el mateix tipus
-- de dades que una fila d'una taula (inclou totes les columnes.

/* Exemple: Programa que demana una identitat d'empleat
per teclat i mostra el seu nom, cognoms, salari, ofici i departament_id
Si l'empleat no existeix mostra el missatge "Empleat inexistent" */

DECLARE
	v_empleat_id empleat.empleat_id%TYPE := &introudeix_id;
    
	-- r_registre permite guardar totes les columnes d'una fila 
    -- de la taula empleat
	r_registre empleat%ROWTYPE;

BEGIN
    --Quan guardem el resultat en una variable registre, en general és per que
    --es demanen totes les columnes (*)
	SELECT *
	INTO r_registre
	FROM empleat
	WHERE empleat_id = v_empleat_id;

	DBMS_OUTPUT.PUT_LINE ('Empleat_id:' || r_registre.empleat_id);
    DBMS_OUTPUT.PUT_LINE ('Nom: ' || r_registre.nom);
    DBMS_OUTPUT.PUT_LINE ('Cognom1: ' || r_registre.cognom1);
    DBMS_OUTPUT.PUT_LINE ('Cognom2: ' || r_registre.cognom2);
	DBMS_OUTPUT.PUT_LINE ('Salari: ' || r_registre.salari);
	DBMS_OUTPUT.PUT_LINE ('Ofici: ' || r_registre.ofici);
    DBMS_OUTPUT.PUT_LINE ('Departament_id: ' || r_registre.departament_id);
    

EXCEPTION

	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('No existeix un empleat amb identitat ' || v_empleat_id);

	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE ('Molts empleats amb aquest codi');

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');

END;






