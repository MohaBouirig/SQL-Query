SET SERVEROUTPUT ON;
SET VERIFY OFF;

/******************/
/*BLOCS ANIDATS  */
/******************/


/* EXEMPLE: Programa que demana dos numeros i fa la seva divisi�
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
        --v_result2 �s una variable del bloc intern, es declara
        v_result2 NUMBER;
    BEGIN
        --v_num1 i v_num2 s�n variables del bloc extern, no es declaren
        v_num1 := &sv_num1;
        v_num2 := &sv_num2;
        v_result2 := v_num1 / v_num2;
        DBMS_OUTPUT.PUT_LINE ('v_result2: '||v_result2);
            
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
             DBMS_OUTPUT.PUT_LINE ('ERROR BLOC INTERN: Divisi� per zero');
        WHEN OTHERS THEN
             DBMS_OUTPUT.PUT_LINE ('ERROR BLOC INTERN: Error diferent a qualsevol dels anteriors');
    END;
    --------------------------
    --FI DEL BLOC PLSQL INTERN
    ---------------------------
    DBMS_OUTPUT.PUT_LINE ('F� del programa');
EXCEPTION
	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE ('ERROR BLOC EXTERN: Divisi� per zero');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('ERROR BLOC EXTERN: Error diferent a qualsevol dels anteriors');
END;


