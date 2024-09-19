SET SERVEROUTPUT ON;
SET VERIFY OFF;
/***********/
/* IF-ELSE */
/***********/

/*SINTAXI:

    IF condició 
    THEN
        ...
    ELSE
        ...
    END IF;
*/

/*Exemple: programa que demana un DNI (per exemple el 12345678A)
per teclat i mostra les dades del seu departament */

DECLARE
    -- %ROWTYPE indica que aquesta variable guardarà el contingut d'una fila
	r_departament departament%ROWTYPE;
	v_DNI empleat.DNI%TYPE := '&demana_DNI';
	v_existeix NUMBER;

BEGIN
    --Aquesta es una forma de comprovar si existeix el que necessitem
    --sense que es generi l'excepció NOT_FOUND
	SELECT COUNT(empleat_id) INTO v_existeix
	FROM empleat
	WHERE DNI = v_DNI;

	IF (v_existeix = 1)
	THEN
        -- Totes les columnes de la fila es guarden a r_departament, 
        -- que havia estat definida com %ROWTYPE
		SELECT d.* INTO r_departament
		FROM departament d
        INNER JOIN empleat e ON e.departament_id = d.departament_id
		WHERE  e.DNI = v_DNI;

		DBMS_OUTPUT.PUT_LINE ('Departament de l''empleat amb DNI: '|| v_DNI);
		DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT_ID : ' || r_departament.departament_id);
		DBMS_OUTPUT.PUT_LINE ('NOM : ' || r_departament.nom);
		DBMS_OUTPUT.PUT_LINE ('LOCALITAT : ' || r_departament.localitat);
	ELSE
		DBMS_OUTPUT.PUT_LINE ('Aquest empleat no existeix!');
	END IF;

EXCEPTION

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;



