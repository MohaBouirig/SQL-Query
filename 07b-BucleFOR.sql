SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*************/
/* BUCLE FOR */
/*************/

/*SINTAXI

    FOR comptador IN [REVERSE] valor_mes_petit .. valor_mes_gran
    LOOP
        ...
    END LOOP;

    comptador: és un valor INTEGER declarat implícitament (no fa falta
    declarar-lo a la secció DECLARE). 
    El seu valor augmenta (o disminueix si s'utilitza la paraula clau REVERSE) 
    en una unitat per cada iteració del bucle entre el rang de valors inicial 
    i final definits en el FOR
*/


-- EJEMPLO: muestra 10 veces una frase 

BEGIN
	FOR v_cont IN 1..10
	LOOP
		DBMS_OUTPUT.PUT_LINE (v_cont || '.Sempre un WHERE al DELETE FROM');
	END LOOP;

END;

BEGIN
	FOR v_cont IN REVERSE 1..10
	LOOP
		DBMS_OUTPUT.PUT_LINE (v_cont || '.Sempre un WHERE al DELETE FROM');
	END LOOP;

END;


-- Els valors més petit i el valor més gran del FOR pot ser també una variable
--o qualsevol expressió sempre que torni un valor enter
--En aquest exemple demanen a l'usuari el número de línies a mostrar
DECLARE
    v_valor_max INTEGER := &demanar_num_lineas;
BEGIN
	FOR v_cont IN 1..v_valor_max
	LOOP
		DBMS_OUTPUT.PUT_LINE (v_cont || '.Sempre un WHERE al DELETE FROM');
	END LOOP;

END;

-- EXEMPLE: Inserir 10 filas més a la taula test_bucles 
BEGIN
 
    FOR v_cont IN 1..10
    LOOP      
        INSERT INTO test_bucles (frase) 
            VALUES ('Frase ' || v_cont);
     
    END LOOP;
	COMMIT;
END;