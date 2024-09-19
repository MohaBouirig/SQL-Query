SET SERVEROUTPUT ON;
SET VERIFY OFF;
/**************/
/* RETURNING  */
/**************/
-- Sovint cal tenir informaci� sobre les files afectades
-- per una instrucci� DML (insert, update, delete) despr�s d'haver la executat.

-- La cl�usula RETURNING es pot afegir al final de qualsevol instrucci� DML
-- i s'utilitza per obtenir informaci� sobre la fila o les files que
-- s'acaben de processar.

--IMPORTANT: En el seg�ent exemple veiem com s'utilitza RETURNING quan
--solamente �s afectada una fila. Si fossin afectades m�s files, s'hauria d'utilitzar
--COLLECTIONS (l'equivalent a un array), tema que no donarem per� que podeu investigar.

-- EXEMPLE
-- Executem INSERT, UPDATE i DELETE, i mitjan�ant la cl�usula RETURNING
-- accedim a informaci� de la �nica fila afectada

DECLARE
    v_empleat_id EMPLEAT.EMPLEAT_ID%TYPE;
    v_nom EMPLEAT.NOM%TYPE;
    v_cognom1 EMPLEAT.COGNOM1%TYPE;
    v_cognom2 EMPLEAT.COGNOM2%TYPE;
    v_DNI EMPLEAT.DNI%TYPE;
    v_salari EMPLEAT.SALARI%TYPE;
    
BEGIN

    -- INSERT:
    -- Inserin un empleat i obtenim el ROWID de la fila creada
    v_DNI := '87654321B';
    v_salari := 2000;
    DBMS_OUTPUT.PUT_LINE ('Inserim un nou empleat amb DNI: '|| v_DNI);
        
    INSERT INTO empleat (nom, cognom1, cognom2, DNI, salari) 
    VALUES ('Eduard', 'Laffite', 'Mart�nez', v_DNI, v_salari)
    RETURNING empleat_id INTO v_empleat_id;
    
    DBMS_OUTPUT.PUT_LINE ('El nou empleat te empleat_id '|| v_empleat_id);
    
    -- UPDATE:
    -- Incrementem un 10% el sou de l'empleat creat
	-- Utilitzem RETURNING per obtenir com ha quedat el nou salari
    UPDATE empleat
    SET salari = salari * 1.1
    WHERE empleat_id = v_empleat_id
    RETURNING salari INTO v_salari;
    
    DBMS_OUTPUT.PUT_LINE ('Nou salari: '|| v_salari);
    

    -- DELETE:
    -- Finalment esborrem l'empleat creat.
	-- Es pot fer identificant la fila pel seu ROWID
	-- Amb returning obtenim el codi de l'empleat i
	-- es pot comprovar que �s el que vam inserir
    DELETE FROM empleat 
    WHERE empleat_id = v_empleat_id
    RETURNING DNI INTO v_DNI;
    
    DBMS_OUTPUT.PUT_LINE ('El empleado esborrat tenia com DNI: '|| v_DNI);
    
    COMMIT;
    
EXCEPTION

	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE ('DNI duplicat: '|| v_DNI);
	WHEN OTHERS THEN
		ROLLBACK;
		
END;