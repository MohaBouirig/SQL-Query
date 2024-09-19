SET SERVEROUTPUT ON;
SET VERIFY OFF;
/***********************/
/* FOR IN SELECT */
/***********************/

--Encara es pot simplificar m�s: no declarem el cursor
--i utilitzem directament el SELECT al FOR IN
--Internament es crea un cursor impl�cit (creat autom�ticament,
--no per l'usuari).

--T� l'incovenient respecte l'anterior que els SELECTS, enlloc
--d'estar nom�s definits a la zona DECLARE en forma de cursor, 
--poden estar a qualsevol lloc, i per tant el codi �s m�s dif�cil de mantenir.

--******************************************************************
--Exemple: Programa que mostra les columnes nom, cognoms i salari 
--dels empleats amb un salari major que l'introdu�t per teclat
--******************************************************************

DECLARE
    v_salari empleat.salari%TYPE := &demanar_salari;
BEGIN
    /* r_empleat es una variable %ROWTYPE declarada impl�citament (no es 
    declara dins la secci� DECLARE) 
    r_empleat cont� totes les columnes que torni el SELECT
    ATENCI�: La variable r_empleat nom�s existeix al bucle FOR. Fora del bucle no es accesible.*/
    FOR r_empleat IN (SELECT nom, cognom1, cognom2, salari
						FROM empleat
						WHERE salari > v_salari)
    LOOP
		DBMS_OUTPUT.PUT('NOM: ' || r_empleat.nom);
        DBMS_OUTPUT.PUT(' COGNOM1: ' || r_empleat.cognom1);
        DBMS_OUTPUT.PUT(' COGNOM2: ' || r_empleat.cognom2);
		DBMS_OUTPUT.PUT_LINE(' SALARI: ' || r_empleat.salari);
    END LOOP;

EXCEPTION

    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;

--******************************************************************
-- El mateix exemple, utilitzant JOIN, alies de taula i columna
-- IMPORTANT: a m�s a m�s, es tracta el cas que no s'entri al bucle
--******************************************************************

DECLARE
    v_salari empleat.salari%TYPE := &demanar_salari;
    v_bucle boolean := FALSE;
BEGIN
    --IMPORTANT: Si el SELECT del FOR IN no trova cap fila, no es produeix cap excepci�,
    --simplement no s'entra dins el bucle FOR IN. 
    --Controlarem aquest cas amb la variable booleana v_bucle
	FOR r_empleat IN (SELECT e.nom, e.cognom1, e.cognom2, e.salari, d.nom departament
						FROM empleat e
                        JOIN departament d ON (e.departament_id = d.departament_id)
						WHERE e.salari > v_salari)
    LOOP
		DBMS_OUTPUT.PUT('NOM: ' || r_empleat.nom);
        DBMS_OUTPUT.PUT(' COGNOM1: ' || r_empleat.cognom1);
        DBMS_OUTPUT.PUT(' COGNOM2: ' || r_empleat.cognom2);
        DBMS_OUTPUT.PUT(' SALARI: ' || r_empleat.salari);
        --IMPORTANT: Si utilitzem un alies de columna (en aquest cas "departament") 
        --aquest es far� servir com el nom de la columna dins r_empleat
		DBMS_OUTPUT.PUT_LINE(' DEPARTAMENT: ' || r_empleat.departament);

        --Per controlar que s'ha entrat al bucle canviem el valor de v_bucle a TRUE
        v_bucle := TRUE;
        
    END LOOP;
    
    IF v_bucle = FALSE
    THEN
        DBMS_OUTPUT.PUT_LINE('No hi ha cap empleat amb salari superior a ' || v_salari);
    END IF;
END;


