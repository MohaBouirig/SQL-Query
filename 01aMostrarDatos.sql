/************/
/*  PL-SQL  */
/************/

/* PL-SQL: Extensió del SQL de Oracle a llenguatge de programació.

PL-SQL (Procedural Language, Structured Query Language)
https://docs.oracle.com/en/database/oracle/oracle-database/18/lnpls/index.html
Un programa PL-SQL pot incloure:
- Variables, intruccions condicionals, bucles, etc.
- Ordres SQL (totes les que hem vist), funcions SQL (UPPER, MIN, ...), etc.

Existeixen 3 tipus de programes que podem desenvolupar:

a) Blocs anònims: 
- Script, programa que no te un nom associat.
- No s'emmagatzema a la base de dades.

b) Procediments i funcions: 
- "Programes" que tenen un nom
- S'emmagatzemen a la base de dades
- S'executen quan cridem al nom del programa 

c) Disparadors (Triggers): 
- "Programes" que tenen un nom
- S'emmagatzemen a la base de dades
- S'executen quan es produeix un event a la base de dades: una inserció, una modificació, etc 

*/

/*******************/
/*  BLOCS ANONIMS  */
/*******************/

/*  
Els blocs anónims de PL-SQL tenen 3 seccions: 
- una secció declarativa (OPCIONAL): on es declaren variables, tipus de dades, objectes...
- una secció executable (OBLIGATORIA): on es desenvolupa l'algorisme
- una secció d'excepcions (OPCIONAL): on es tracten els errors que es poden produir durant l'execució
*/

/*  SINTAXI:

    [DECLARE]
    -- Secció declarativa
    
    BEGIN
    -- Secció executable
    
    [EXCEPTION]
    -- Secció d'excepcions
    
    END;
*/
/*
PL/SQL no distingeix entre majúscules i minúscules a nivell de codi (si a nivell de dades).
Per llegibilitat s'adopten els següents convenis:
1) Les paraules reservades (DECLARE, BEGIN, END, IF, THEN, CONSTANT, FOR, WHILE ..)
s'escriuen sempre en majúscules.
2) Els noms dels identificadors (variables i constants) s'escriuen en minúscules.
*/


--***********************
--* Exemple: Hola Mundo *
--***********************

-----------------------------------------------------------------
-- IMPORTANT: Cal activar la sortida de missatges del servidor
------------------------------------------------------------------
SET SERVEROUTPUT ON;

-----------------------------------------------------------------
-- MOLT IMPORTANT: Per executar un bloc PLSQL:
--   - Si al fitxer només hi ha un, fem clic al icon per executar scripts
--     (triangle verd petit)
--   - Si hi ha més un bloc, seleccionem el bloc amb el ratolí i fem clic
--     al icon per executar ordres (triangle verd gran)
------------------------------------------------------------------

-----------------------------------------------------------------
-- MOLT IMPORTANT: Per entendre els errors:
-- Quan surt un error, el número de línia indicat no és el número de línia 
-- del fitxer.
-- S'indica el número de línia a partir de l'inici del bloc (el DECLARE o 
-- si no hi ha, el BEGIN) .()
------------------------------------------------------------------

/* L'equivalent a System.out.print(...) es la funció DBMS_OUTPUT.PUT(...); */
/* L'equivalent a System.out.println(...) es la funció DBMS_OUTPUT.PUT_LINE(...); */
BEGIN
    -- PUT() NO inclou salt de línia
    --Va acumulant el text a mostrar, però no ho mostrarà fins que no afegim un salt de línia
    --Nota:per canviar el color amb el que es veu DBMS_OUTPUT escrit, s'ha d'anar
    --Herramientas -> Preferencias -> Editor de código 
    --  -> Colores de sintaxis PL/SQL --> PLSQLLogger (lúltim) i canviar el 
    --color de primer plà a negre, per exemple
    DBMS_OUTPUT.PUT ('Hola Món 1. ');
    DBMS_OUTPUT.PUT ('Aquest és el meu primer programa en PL-SQL');
    DBMS_OUTPUT.NEW_LINE;

    -- PUT_LINE() SÍ inclou salt de línia
	DBMS_OUTPUT.PUT_LINE ('Hola Món 2. Aquest és el meu primer programa en PL-SQL');

END;

--******************************************************
/* Exemple: Hola Mundo amb declaració de variables */
--******************************************************

/* Les variables es poden inicialitzar a la secció declarativa o dins el cos
del bloc*/
DECLARE
    -- v_frase sense inicialitar val NULL, s'inicialitza més tard dins BEGIN
	v_frase VARCHAR2(200);
    --IMPORTANT: PER ASSIGNAR VALORS S'UTILITZA := 
	v_sentencia VARCHAR2(200) := 'Esta variable se inicializa en la sección declarativa';
    --En PL/SQL existeix el tipus BOOLEAN
    v_actiu BOOLEAN := FALSE;
BEGIN
	v_frase := 'Hola Mundo 2. Este es mi segundo programa en PL-SQL';
	DBMS_OUTPUT.PUT_LINE (v_frase);
	DBMS_OUTPUT.PUT_LINE (v_sentencia);
    --ATENCIÓ: les variables de tipus BOOLEA no es poden mostrar amb PUT_LINE()
    --DBMS_OUTPUT.PUT_LINE (v_actiu);
END;