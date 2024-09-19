SET SERVEROUTPUT ON;
SET VERIFY OFF;

/******************/
/*EXCEPCIONS (I)  */
/******************/
--Els errors s'anomenen excepcions.
--Les excepcions que creiem que es poden donar QUAN S'EXECUTI el nostre codi 
--les hem d'afegir en la secció EXCEPTIONS
--IMPORTANT: si es produeix una excepció, es fa un ROLLBACK de tots els canvis
--fets a la transacció.

/* Aquesta és una llista de les excepcions predefinides a ORACLE
https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnpls/plsql-error-handling.html#GUID-8C327B4A-71FA-4CFB-8BC9-4550A23734D6

ACCESS_INTO_NULL    	ORA-06530
CASE_NOT_FOUND  		ORA-06592
COLLECTION_IS_NULL  	ORA-06531
CURSOR_ALREADY_OPEN 	ORA-06511
DUP_VAL_ON_INDEX    	ORA-00001
INVALID_CURSOR  		ORA-01001
INVALID_NUMBER  		ORA-01722
LOGIN_DENIED    		ORA-01017
NO_DATA_FOUND   		ORA-01403
NOT_LOGGED_ON   		ORA-01012
PROGRAM_ERROR   		ORA-06501
ROWTYPE_MISMATCH    	ORA-06504
SELF_IS_NULL    		ORA-30625
STORAGE_ERROR   		ORA-06500
SUBSCRIPT_BEYOND_COUNT  ORA-06533
SUBSCRIPT_OUTSIDE_LIMIT ORA-06532
SYS_INVALID_ROWID   	ORA-01410
TIMEOUT_ON_RESOURCE 	ORA-00051
TOO_MANY_ROWS   		ORA-01422
VALUE_ERROR 			ORA-06502
ZERO_DIVIDE 			ORA-01476

Als exemples s'aniran veient les més habituals i en quins casos es produeixen

*/

/* Ejemplo: Programa que demana dos numeros i fa la seva divisió
Comprovar que pasa si es divideix entre 0*/
DECLARE
    v_num1 INTEGER := &sv_num1;
    v_num2 INTEGER := &sv_num2;
    v_result NUMBER;
BEGIN
    v_result := v_num1 / v_num2;
    DBMS_OUTPUT.PUT_LINE ('v_result: '||v_result);
END;


/* EXEMPLE: Programa que demana dos numeros i fa la seva divisió
Si es divideix entre 0, ens mostra un missatge avisant-nos. */
DECLARE
    v_num1 INTEGER := &sv_num1;
    v_num2 INTEGER := &sv_num2;
    v_result NUMBER;
BEGIN
    v_result := v_num1 / v_num2;
    DBMS_OUTPUT.PUT_LINE ('v_result: '||v_result);
    
EXCEPTION

	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE ('Divisió per zero');

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;

/* EXEMPLE: Programa que assigna una cadena de caracters amb
una longitud més gran del permés
Ens mostra un missatge avisant-nos. */
DECLARE
    v_test_var CHAR(3) := '123';
BEGIN
    v_test_var := '1234';
    DBMS_OUTPUT.PUT_LINE ('v_test_var: '||v_test_var);
EXCEPTION
    WHEN INVALID_NUMBER OR VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE ('Valor incorrecte');
		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;
