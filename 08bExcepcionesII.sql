SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*******************/
/*EXCEPCIONS (II): ERRORS DEFINITS PER L'USUARI */
/*******************/

--RAISE_APPLICATION_ERROR
--Permet crear una excepció definida per l'usuario a la qual
--es pot assignar un codi numéric i un missatge.
--Aquesta és l'avantatge respecte RAISE -> que podem assignar un missatge directamente.

--Al cos del programa (BEGIN), quan detectem l'error, disparem l'excepció
--amb RAISE_APPLICATION_ERROR
--RAISE_APPLICATION_ERROR també es pot fer servir dins de la secció EXCEPTION


-- RAISE_APPLICATION_ERROR( error_number, message [, {TRUE | FALSE}]);
--     error_number: és un número enter negatiu dins l’interval entre -20999 i -20000.
--     message: és una cadena de caràcters que representa el missatge d'error. 
--       La seva longitud és de fins a 2048 bytes.
--     Tercer paràmetre:
--      - Si és FALS, l’error substitueix tots els errors anteriors.
--      - Si és VERITAT, s’afegeix l’error a la pila d’errors anteriors.
--
-- Com l’excepció generada per RAISE_APPLICATION_ERROR no té nom, no es pot 
-- gestionar amb un nom específic a la secció EXCEPTION del programa,
-- s'ha de gestionar dins OTHERS.


/* EXEMPLE: Programa que demana un numero
Si no és positiu, ens mostra un missatge avisant-nos. */
DECLARE
    v_num1 INTEGER := &sv_num1;
BEGIN
    IF (v_num1 < 0) THEN
        --quan detectem l'error, disparem l'excepció
        RAISE_APPLICATION_ERROR(-20001, 'El valor ha de ser positiu');
    END IF;
    DBMS_OUTPUT.PUT_LINE ('v_num1: '||v_num1);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
        --Visualizamos QLCODE y SQLERRM
        DBMS_OUTPUT.PUT_LINE('CODI ERROR: : '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('MSG ERROR: : '||SQLERRM);
END;
