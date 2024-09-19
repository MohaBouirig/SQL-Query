SET SERVEROUTPUT ON;
SET VERIFY OFF;

/**********/
/* BUCLES */
/**********/
--Hi ha els mateixos tipus de bucle que en java i un addicional,
--el bucle de cursor (ho veurem més endavant, al tema CURSORS)

/**************/
/* BUCLE LOOP */
/**************/
-- equivalent al do while de Java. Bucle infinit amb condició de sortida

/*SINTAXI

    LOOP
        ....
        EXIT WHEN condició;
        ....
    END LOOP;

*/

DECLARE
	v_cont INTEGER := 0;

BEGIN
	LOOP
		v_cont := v_cont + 1;
		DBMS_OUTPUT.PUT_LINE (v_cont || '.Mai faré un DELETE FROM sense WHERE');	
		/* La sentencia exit; equivale a break y abandona el bucle */
		EXIT WHEN (v_cont = 10);
	END LOOP;
END;

--*************************************************
-- EXEMPLE 2: abans es crea una taula i una seqüencia
--*************************************************
DROP TABLE TEST_BUCLES;

CREATE TABLE TEST_BUCLES(
    id NUMBER(5,0) GENERATED ALWAYS AS IDENTITY,
    frase VARCHAR2(20)
    );



-- Utilitzarem un bucle infinit amb condició de sortida 
-- on inserim 5 files a la taula test_bucles.
DECLARE
    v_cont INTEGER:=0;
BEGIN
    LOOP
        v_cont := v_cont + 1;
        INSERT INTO test_bucles (frase) 
        VALUES ('Frase ' || v_cont);
        --El bucle se termina cuando v_cont llega a 5
        EXIT WHEN (v_cont = 5);
    END LOOP;
    COMMIT;
END;
