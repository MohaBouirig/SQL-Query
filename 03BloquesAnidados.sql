SET SERVEROUTPUT ON;
SET VERIFY OFF;

/******************/
/*BLOCS ANIDATS  */
/******************/


/* EXEMPLE: Programa que demana dos numeros i fa la seva divisió
Si es divideix entre 0, ens mostra un missatge avisant-nos. */
DECLARE
    v_num1 INTEGER := &sv_num1;
    v_num2 INTEGER := &sv_num2;
    v_result1 NUMBER;
BEGIN
    v_result1 := v_num1 / v_num2;
    DBMS_OUTPUT.PUT_LINE ('v_result1: '||v_result1);
    -----------------------------    
    --AFEGIM UN BLOC PLSQL INTERN
    ------------------------------
    DECLARE
        --v_result2 és una variable del bloc intern, es declara
        v_result2 NUMBER;
    BEGIN
        --v_num1 i v_num2 són variables del bloc extern, no es declaren
        v_num1 := &sv_num1;
        v_num2 := &sv_num2;
        v_result2 := v_num1 / v_num2;
        DBMS_OUTPUT.PUT_LINE ('v_result2: '||v_result2);
            
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
             DBMS_OUTPUT.PUT_LINE ('ERROR BLOC INTERN: Divisió per zero');
        WHEN OTHERS THEN
             DBMS_OUTPUT.PUT_LINE ('ERROR BLOC INTERN: Error diferent a qualsevol dels anteriors');
    END;
    --------------------------
    --FI DEL BLOC PLSQL INTERN
    ---------------------------
    DBMS_OUTPUT.PUT_LINE ('Fí del programa');
EXCEPTION
	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE ('ERROR BLOC EXTERN: Divisió per zero');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('ERROR BLOC EXTERN: Error diferent a qualsevol dels anteriors');
END;


