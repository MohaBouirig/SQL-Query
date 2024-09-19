SET SERVEROUTPUT ON;
SET VERIFY OFF;
/**************/
/* CASE WHEN  */
/**************/

/* SINTAXI

    CASE expressió
        WHEN valor1 THEN
            ordres_SQL
        WHEN valor2 THEN
            ordres_SQL
        ...
        ELSE
            ordres_SQL
    END CASE;
*/

/*Exemple: programa que demana un DNI (per exemple el 12345678A)
i actualitza la seva comissió depenent de la següent taula:

Departament_id	    Comissio
10	                0
20 	                15
30	                10
40                  5

Si l'empleat pertany a un altre departament, 
s'ha d'indicar amb el missatge 
'No hi ha comissio predefinida per aquest departament'
*/

DECLARE
    v_DNI empleat.DNI%TYPE := '&demana_DNI';
	v_comissio empleat.COMISSIO%TYPE;
	v_departament_id empleat.departament_id%TYPE;

BEGIN

	SELECT departament_id INTO v_departament_id
    FROM empleat
	WHERE DNI = v_DNI;

    DBMS_OUTPUT.PUT_LINE ('Departament_id: '||v_departament_id);
	CASE v_departament_id
		WHEN 10 THEN v_comissio:= 0;
		WHEN 20 THEN v_comissio:= 15;
		WHEN 30 THEN v_comissio:= 10;
		WHEN 40 THEN v_comissio:= 5;
		ELSE DBMS_OUTPUT.PUT_LINE ('No hi ha comissio predefinida per aquest departament');
	END CASE;


	IF v_comissio IS NOT NULL THEN
		UPDATE empleat SET comissio = v_comissio 
        WHERE DNI = v_DNI;
		COMMIT;
	END IF;

EXCEPTION

	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('Aquest empleat no existeix');
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END; 