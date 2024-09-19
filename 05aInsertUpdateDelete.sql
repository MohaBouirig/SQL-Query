SET SERVEROUTPUT ON;
SET VERIFY OFF;
/**************/
/* INSERT, UPDATE, DELETE  */
/**************/

-- 1. Si fem canvis a la base de dades, hem de fer un COMMIT
-- si tot va bé. Si hi ha algun problema, hauriem de fer
-- un ROLLBACK.

-- 2. Si inserim amb un codi que ja es troba a la base de dades, es produirà
-- l'excepció DUP_VAL_ON_INDEX.

-- 3. Un UPDATE o un DELETE amb un WHERE on 
-- no es cumpleix la condició a cap fila, NO genera
-- l'excepció NO_DATA_FOUND, simplement no fa res
-- i el programa continua.

-- 4. Conseqüencia de l'anterior: abans de modificar 
-- o esborrar un element, s'hauria de comprovar amb un SELECT
-- que aquest element existeix.


-- EJEMPLO
-- Executem un INSERT, UPDATE i DELETE
DECLARE

    v_nom EMPLEAT.NOM%TYPE;
    v_cognom1 EMPLEAT.COGNOM1%TYPE;
    v_cognom2 EMPLEAT.COGNOM2%TYPE;
    v_DNI EMPLEAT.DNI%TYPE := '&introdueix_DNI';
    v_salari EMPLEAT.SALARI%TYPE;

    
BEGIN
   
	--v_DNI := '12345678A'; Donarà error
    --v_DNI := '87654321A';
   
    -- INSERT:
    -- Inserim un empleat
	--Si inserim un valor a una columna clau principal o una columna que te
    --la restricció UNIQUE ja es troba a la base de dades, es produirà
	--l'excepció DUP_VAL_ON_INDEX.
    --Comprovar amb DNI 12345678A,que ja existeix
    v_salari := 2000;
    INSERT INTO empleat (nom, cognom1, cognom2, DNI, salari) 
    VALUES ('Eduard', 'Laffite', 'Martínez', v_DNI, v_salari);   
  

    -- UPDATE:
    -- Augmentem un 10% el salari de l'empleat inserit
    UPDATE empleat
    SET salari = salari * 1.1
    WHERE DNI = v_DNI;

	--Com no coneixem el nou salari, fem una consulta
	--per mostrar-lo
    SELECT salari INTO v_salari
    FROM empleat
    WHERE DNI = v_DNI;
    DBMS_OUTPUT.PUT_LINE ('Nou salari: '|| v_salari);

    -- DELETE:
    -- Finalment s'elimina aquest empleat   
    DELETE FROM empleat 
    WHERE DNI = v_DNI;
	
	--Si fem canvis, s'ha de fer un COMMIT.
	--(encara que en aquest exemple no faria falta per que 
	--al final la BD es queda com estava inicialment)
    COMMIT;
	
EXCEPTION

	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE ('DNI duplicat: '|| v_DNI);
	WHEN OTHERS THEN
		ROLLBACK;

END;