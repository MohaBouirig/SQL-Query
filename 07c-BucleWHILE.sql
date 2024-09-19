SET SERVEROUTPUT ON;
SET VERIFY OFF;

/***************/
/* BUCLE WHILE */
/***************/

/*SINTAXI

    WHILE condició 
    LOOP
        ....
    END LOOP;

*/

-- EXEMPLE: mostrar una frase 10 vegades 

DECLARE
	v_cont INTEGER := 0;

BEGIN

	WHILE (v_cont < 10)
	LOOP
		v_cont := v_cont + 1;
		DBMS_OUTPUT.PUT_LINE (v_cont || '.Mai escriuré un DELETE FROM sense el WHERE');
	END LOOP;

END;


-- EXEMPLE: Inserir 10 filas més a la taula TEST_BUCLES, utilitzant el bucle while.


DECLARE
    v_cont INTEGER := 0;
BEGIN

    WHILE (v_cont < 10)
    LOOP

        INSERT INTO test_bucles(frase) 
        VALUES ('Frase ' || v_cont);
        
        v_cont := v_cont + 1;    
    END LOOP;
    COMMIT;
END;