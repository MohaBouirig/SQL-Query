SET SERVEROUTPUT ON;
SET VERIFY OFF;
/**************************/
/* ATRIBUTO %ROWTYPE (II) */
/**************************/
--L'atribut %ROWTYPE també es pot fer servir per guardar columnes
--concretas de la taula
    
/* Exemple: Programa que demana una identitat d'empleat
per teclat i mostra el seu nom i cognoms
Si l'empleat no existeix mostra el missatge "Empleat inexistent" */

DECLARE
	v_empleat_id empleat.empleat_id%TYPE := &introdueix_id;
    
	-- r_registre permite guardar totes les columnes d'una fila 
    -- de la taula empleat
	r_registre empleat%ROWTYPE;

BEGIN
    --L'atribut %ROWTYPE també es pot fer servir per guardar columnes
    --concretas de la taula
    SELECT nom, cognom1, cognom2
	INTO r_registre.nom, r_registre.cognom1, r_registre.cognom2
	FROM empleat
	WHERE empleat_id = v_empleat_id;

	DBMS_OUTPUT.PUT_LINE ('Empleat_id:' || v_empleat_id);
    DBMS_OUTPUT.PUT_LINE ('Nom: ' || r_registre.nom);
    DBMS_OUTPUT.PUT_LINE ('Cognom1: ' || r_registre.cognom1);
    DBMS_OUTPUT.PUT_LINE ('Cognom2: ' || r_registre.cognom2);
    

EXCEPTION

	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('No existeix un empleat amb identitat ' || v_empleat_id);

	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE ('Molts empleats amb aquest codi');

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');

END;






