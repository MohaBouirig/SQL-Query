SET SERVEROUTPUT ON;
SET VERIFY OFF;
/******/
/* IF */
/******/

/*SINTAXI:

    IF condició 
    THEN
        ...
    END IF;
*/


/*Exemple: programa que demana un DNI (per exemple el 12345678A)
i una comisió. Amb aquestes dades actualitza aquesta comisió al nou valor. 
Si la comisió anterior era nul·la, feu que escrigui un missatge d'advertència */

DECLARE 

v_DNI empleat.DNI%TYPE := '&demanar_DNI';
-- A v_comissio guardarem la comissio actual a la base de dades
v_comissio empleat.comissio%TYPE; 
-- A v_nova_comissio guardarem la comisio que volem assignar
v_nova_comissio empleat.comissio%TYPE := &p_nova_comissio; 

BEGIN

    SELECT comissio INTO v_comissio
    FROM empleat
    WHERE DNI = v_DNI;
    
    IF v_comissio IS NULL 
    THEN
        DBMS_OUTPUT.PUT_LINE ('Atenció, comissio anterior nula');
    END IF;
    
    UPDATE empleat SET comissio = v_nova_comissio
    WHERE DNI = v_DNI;
    --Es necessari fer un commit final per tancar la transacció i
    --guardar definitivament el canvi fet amb UPDATE 
    COMMIT;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE ('No existeix aquest empleat');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;



