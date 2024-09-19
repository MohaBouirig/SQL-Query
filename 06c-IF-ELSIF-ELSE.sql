SET SERVEROUTPUT ON;
SET VERIFY OFF;
/***************/
/* IF-ELSE-IF  */
/***************/

/*SINTAXI:

    IF condició 
    THEN
        ...
    ELSIF condició
    THEN
        ...
    ELSE
        ...
    END IF;
*/


/*Exemple: programa que demana un DNI (per exemple el 12345678A)
per teclat i augmenta el seu salari segons la següent taula.


Salari          	% Augment
<1000	                 3%
>=1000 i <=2000 	     2%
>2000	                 1%

Si no trova el'empleat introduït, ha de sortir un missatge indicant-lo
*/

DECLARE 

v_DNI empleat.DNI%TYPE := '&demana_DNI';
v_salari empleat.salari%TYPE; 
v_percentatge NUMBER := 0; 

BEGIN

    SELECT salari INTO v_salari
    FROM empleat
	WHERE DNI = v_DNI;
    
	IF v_salari < 1000 
	THEN 
		v_percentatge := 3;	
	ELSIF v_salari >= 1000 AND v_salari <= 2000
	THEN
		v_percentatge := 2;
	ELSIF v_salari > 2000
	THEN
		v_percentatge := 1;
	END IF;

	DBMS_OUTPUT.PUT_LINE ('percentatge : ' || v_percentatge);
    
	UPDATE empleat
    SET salari = v_salari + (v_percentatge/100)*v_salari
	WHERE DNI = v_DNI;

    COMMIT;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE ('No existeix aquest empleat');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;