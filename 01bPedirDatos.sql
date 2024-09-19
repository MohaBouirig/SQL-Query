SET SERVEROUTPUT ON;
--Si treiem els comentaris de la línia següent no es mostrarà 
--la substitució de variables
--SET VERIFY OFF;

/****************************/
/* DEMANAR DADES PER TECLAT */
/****************************/
--Variable de substitució: una cadena de caràcters amb el símbol & davant

--Per demanar dades i guardar-les a una variable cal assignar a aquesta
--una variable de substitució.
--La cadena de caràcters de la variable de substitució es mostrarà en una finestra, 
--on podrem introduïr el valor que s'assignará a la variable principal.
--NOTA: això no és PL-SQL, és una facilitat pròpia d'ORACLE.

--Per mostrar com s'han substituit les variables. Comportament per defecte
--SET VERIFY ON;
--Si no volem mostrar com s'han substituit les variables
--SET VERIFY OFF;

/* Exemple: demanar un radi d'una circumferència per teclat, i 
calcular la seva longitud i la seva superfície */

DECLARE
    --Si el valor que demanem es text, hem de fer servir cometes (simples)
    v_nom VARCHAR2(20) := '&introdueix_nom';
    --Si el valor que pedimos es numérico, no hem de fer servir cometes
	v_radi FLOAT := &introdueix_radi;
	PI CONSTANT FLOAT := 3.1415927;
	v_superficie FLOAT;
	v_perimetro FLOAT;

BEGIN
	-- el perímetro de la circumferència es 2 * PI * radio
	-- la superfície es PI * radio ** 2
	v_perimetro := 2 * PI * v_radi;
	v_superficie := PI * v_radi ** 2;
 
    -- L'operador || afegeix un text a continuació d'altre
    -- Si la informació no és un text (per exemple un número), la transforma
    -- a text
    DBMS_OUTPUT.PUT_LINE ('Hola ' || v_nom);
	DBMS_OUTPUT.PUT_LINE ('La circunferencia que tiene por radio: '
                            || v_radi || ' metros');

	DBMS_OUTPUT.PUT_LINE ('Tiene por superfície ' || v_superficie || ' metros cuadrados');
	DBMS_OUTPUT.PUT_LINE ('y perímetro ' || v_perimetro || ' metros ');

END;

