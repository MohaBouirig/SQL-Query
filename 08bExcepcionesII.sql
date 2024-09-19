SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*******************/
/*EXCEPCIONS (II): ERRORS DEFINITS PER L'USUARI */
/*******************/

--RAISE_APPLICATION_ERROR
--Permet crear una excepci� definida per l'usuario a la qual
--es pot assignar un codi num�ric i un missatge.
--Aquesta �s l'avantatge respecte RAISE -> que podem assignar un missatge directamente.

--Al cos del programa (BEGIN), quan detectem l'error, disparem l'excepci�
--amb RAISE_APPLICATION_ERROR
--RAISE_APPLICATION_ERROR tamb� es pot fer servir dins de la secci� EXCEPTION


-- RAISE_APPLICATION_ERROR( error_number, message [, {TRUE | FALSE}]);
--     error_number: �s un n�mero enter negatiu dins l�interval entre -20999 i -20000.
--     message: �s una cadena de car�cters que representa el missatge d'error. 
--       La seva longitud �s de fins a 2048 bytes.
--     Tercer par�metre:
--      - Si �s FALS, l�error substitueix tots els errors anteriors.
--      - Si �s VERITAT, s�afegeix l�error a la pila d�errors anteriors.
--
-- Com l�excepci� generada per RAISE_APPLICATION_ERROR no t� nom, no es pot 
-- gestionar amb un nom espec�fic a la secci� EXCEPTION del programa,
-- s'ha de gestionar dins OTHERS.


/* EXEMPLE: Programa que demana un numero
Si no �s positiu, ens mostra un missatge avisant-nos. */
DECLARE
    v_num1 INTEGER := &sv_num1;
BEGIN
    IF (v_num1 < 0) THEN
        --quan detectem l'error, disparem l'excepci�
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
