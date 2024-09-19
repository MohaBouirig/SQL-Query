SET SERVEROUTPUT ON;
--Si treiem els comentaris de la l�nia seg�ent no es mostrar� 
--la substituci� de variables
--SET VERIFY OFF;

/****************************/
/* DEMANAR DADES PER TECLAT */
/****************************/
--Variable de substituci�: una cadena de car�cters amb el s�mbol & davant

--Per demanar dades i guardar-les a una variable cal assignar a aquesta
--una variable de substituci�.
--La cadena de car�cters de la variable de substituci� es mostrar� en una finestra, 
--on podrem introdu�r el valor que s'assignar� a la variable principal.
--NOTA: aix� no �s PL-SQL, �s una facilitat pr�pia d'ORACLE.

--Per mostrar com s'han substituit les variables. Comportament per defecte
--SET VERIFY ON;
--Si no volem mostrar com s'han substituit les variables
--SET VERIFY OFF;

/* Exemple: demanar un radi d'una circumfer�ncia per teclat, i 
calcular la seva longitud i la seva superf�cie */

DECLARE
    --Si el valor que demanem es text, hem de fer servir cometes (simples)
    v_nom VARCHAR2(20) := '&introdueix_nom';
    --Si el valor que pedimos es num�rico, no hem de fer servir cometes
	v_radi FLOAT := &introdueix_radi;
	PI CONSTANT FLOAT := 3.1415927;
	v_superficie FLOAT;
	v_perimetro FLOAT;

BEGIN
	-- el per�metro de la circumfer�ncia es 2 * PI * radio
	-- la superf�cie es PI * radio ** 2
	v_perimetro := 2 * PI * v_radi;
	v_superficie := PI * v_radi ** 2;
 
    -- L'operador || afegeix un text a continuaci� d'altre
    -- Si la informaci� no �s un text (per exemple un n�mero), la transforma
    -- a text
    DBMS_OUTPUT.PUT_LINE ('Hola ' || v_nom);
	DBMS_OUTPUT.PUT_LINE ('La circunferencia que tiene por radio: '
                            || v_radi || ' metros');

	DBMS_OUTPUT.PUT_LINE ('Tiene por superf�cie ' || v_superficie || ' metros cuadrados');
	DBMS_OUTPUT.PUT_LINE ('y per�metro ' || v_perimetro || ' metros ');

END;

