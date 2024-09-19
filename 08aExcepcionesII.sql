SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*******************/
/*EXCEPCIONS (II): ERRORS DEFINITS PER L'USUARI  */
/*******************/
--A part de les predefinides, podem crear excepcions pròpies
--   - A la secció DECLARE indiquem la nostra excepció
--   - Al cos del programa (BEGIN), quan detectem l'error, disparem l'excepció
--     amb la clausula RAISE
--     RAISE també es pot fer servir dins de la secció EXCEPTION

/* EXEMPLE: Programa que demana un numero
Si no és positiu, ens mostra un missatge avisant-nos. */
DECLARE
    v_num1 INTEGER := &demanar_num1;
    --indiquem la nostra excepció
    e_mi_excepcion EXCEPTION;
BEGIN
    IF (v_num1 < 0) THEN
        --quan detectem l'error, disparem l'excepció
        RAISE e_mi_excepcion;
    END IF;
    DBMS_OUTPUT.PUT_LINE ('v_num1: '||v_num1);
    
EXCEPTION
	WHEN e_mi_excepcion THEN
		DBMS_OUTPUT.PUT_LINE ('El valor ha de ser positiu');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;

/* EXEMPLE: Programa que demana un NIF de client i un nom de producte
i indica si aquest client ha comprat aquest producte o no

PROBLEMA: Com podem diferenciar quan el client no existeix de
quan el producte no existeix: tots dos casos generen la
mateixa excepció NO_DATA_FOUND*/

DECLARE
    --Podem provar amb aquests valors:
    --NIF client: 000022222B
    --Producte:  CARRITO OFICINA o ARMARIO NOGAL DOS PUERTAS
    v_client_id client.client_id%TYPE;
    v_client_nif client.client_nif%TYPE := '&demanar_nif';
    
    v_producte_id producte.producte_id%TYPE;
    v_producte_nom producte.nom%TYPE := '&demanar_nom';
    
    v_total INTEGER;
    --indiquem les nostres excepcions
    e_client_no_trobat EXCEPTION;
    e_producte_no_trobat EXCEPTION;
    e_altres_errors EXCEPTION;
BEGIN
    --Un bloc intern per client
    BEGIN
        SELECT client_id INTO v_client_id
        FROM client
        WHERE client_nif = v_client_nif;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --Generem una excepció pròpia per client no trobat
            RAISE e_client_no_trobat;
        WHEN OTHERS THEN
            RAISE e_altres_errors;
    END;

    --Un bloc intern per producte
    BEGIN
        SELECT producte_id INTO v_producte_id
        FROM producte
        WHERE UPPER(nom) = UPPER(v_producte_nom);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --Generem una excepció pròpia per producte no trobat
            RAISE e_producte_no_trobat;
        WHEN OTHERS THEN
            RAISE e_altres_errors;
    END;  
    
    SELECT COUNT(*) INTO v_total
    FROM linia_factura lf
    JOIN factura f ON lf.codi_factura = f.codi_factura
    JOIN client c ON f.client_id = c.client_id
    JOIN producte p ON (lf.producte_id = p.producte_id)
    WHERE UPPER(p.nom) = UPPER(v_producte_nom) AND c.client_nif = v_client_nif;
    
    IF (v_total > 0)
    THEN
        DBMS_OUTPUT.PUT_LINE ('El client ha comprat aquest producte');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('El client NO ha comprat aquest producte');
    END IF;
    
EXCEPTION
	WHEN e_client_no_trobat THEN
		DBMS_OUTPUT.PUT_LINE ('Client no existent');
    WHEN e_producte_no_trobat THEN
		DBMS_OUTPUT.PUT_LINE ('Producte no existent');
	WHEN e_altres_errors THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent al buscar client o producte');
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Error diferent a qualsevol dels anteriors');
END;

