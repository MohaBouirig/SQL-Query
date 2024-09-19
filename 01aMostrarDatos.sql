/************/
/*  PL-SQL  */
/************/

/* PL-SQL: Extensi� del SQL de Oracle a llenguatge de programaci�.

PL-SQL (Procedural Language, Structured Query Language)
https://docs.oracle.com/en/database/oracle/oracle-database/18/lnpls/index.html
Un programa PL-SQL pot incloure:
- Variables, intruccions condicionals, bucles, etc.
- Ordres SQL (totes les que hem vist), funcions SQL (UPPER, MIN, ...), etc.

Existeixen 3 tipus de programes que podem desenvolupar:

a) Blocs an�nims: 
- Script, programa que no te un nom associat.
- No s'emmagatzema a la base de dades.

b) Procediments i funcions: 
- "Programes" que tenen un nom
- S'emmagatzemen a la base de dades
- S'executen quan cridem al nom del programa 

c) Disparadors (Triggers): 
- "Programes" que tenen un nom
- S'emmagatzemen a la base de dades
- S'executen quan es produeix un event a la base de dades: una inserci�, una modificaci�, etc 

*/

/*******************/
/*  BLOCS ANONIMS  */
/*******************/

/*  
Els blocs an�nims de PL-SQL tenen 3 seccions: 
- una secci� declarativa (OPCIONAL): on es declaren variables, tipus de dades, objectes...
- una secci� executable (OBLIGATORIA): on es desenvolupa l'algorisme
- una secci� d'excepcions (OPCIONAL): on es tracten els errors que es poden produir durant l'execuci�
*/

/*  SINTAXI:

    [DECLARE]
    -- Secci� declarativa
    
    BEGIN
    -- Secci� executable
    
    [EXCEPTION]
    -- Secci� d'excepcions
    
    END;
*/
/*
PL/SQL no distingeix entre maj�scules i min�scules a nivell de codi (si a nivell de dades).
Per llegibilitat s'adopten els seg�ents convenis:
1) Les paraules reservades (DECLARE, BEGIN, END, IF, THEN, CONSTANT, FOR, WHILE ..)
s'escriuen sempre en maj�scules.
2) Els noms dels identificadors (variables i constants) s'escriuen en min�scules.
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
--   - Si al fitxer nom�s hi ha un, fem clic al icon per executar scripts
--     (triangle verd petit)
--   - Si hi ha m�s un bloc, seleccionem el bloc amb el ratol� i fem clic
--     al icon per executar ordres (triangle verd gran)
------------------------------------------------------------------

-----------------------------------------------------------------
-- MOLT IMPORTANT: Per entendre els errors:
-- Quan surt un error, el n�mero de l�nia indicat no �s el n�mero de l�nia 
-- del fitxer.
-- S'indica el n�mero de l�nia a partir de l'inici del bloc (el DECLARE o 
-- si no hi ha, el BEGIN) .()
------------------------------------------------------------------

/* L'equivalent a System.out.print(...) es la funci� DBMS_OUTPUT.PUT(...); */
/* L'equivalent a System.out.println(...) es la funci� DBMS_OUTPUT.PUT_LINE(...); */
BEGIN
    -- PUT() NO inclou salt de l�nia
    --Va acumulant el text a mostrar, per� no ho mostrar� fins que no afegim un salt de l�nia
    --Nota:per canviar el color amb el que es veu DBMS_OUTPUT escrit, s'ha d'anar
    --Herramientas -> Preferencias -> Editor de c�digo 
    --  -> Colores de sintaxis PL/SQL --> PLSQLLogger (l�ltim) i canviar el 
    --color de primer pl� a negre, per exemple
    DBMS_OUTPUT.PUT ('Hola M�n 1. ');
    DBMS_OUTPUT.PUT ('Aquest �s el meu primer programa en PL-SQL');
    DBMS_OUTPUT.NEW_LINE;

    -- PUT_LINE() S� inclou salt de l�nia
	DBMS_OUTPUT.PUT_LINE ('Hola M�n 2. Aquest �s el meu primer programa en PL-SQL');

END;

--******************************************************
/* Exemple: Hola Mundo amb declaraci� de variables */
--******************************************************

/* Les variables es poden inicialitzar a la secci� declarativa o dins el cos
del bloc*/
DECLARE
    -- v_frase sense inicialitar val NULL, s'inicialitza m�s tard dins BEGIN
	v_frase VARCHAR2(200);
    --IMPORTANT: PER ASSIGNAR VALORS S'UTILITZA := 
	v_sentencia VARCHAR2(200) := 'Esta variable se inicializa en la secci�n declarativa';
    --En PL/SQL existeix el tipus BOOLEAN
    v_actiu BOOLEAN := FALSE;
BEGIN
	v_frase := 'Hola Mundo 2. Este es mi segundo programa en PL-SQL';
	DBMS_OUTPUT.PUT_LINE (v_frase);
	DBMS_OUTPUT.PUT_LINE (v_sentencia);
    --ATENCI�: les variables de tipus BOOLEA no es poden mostrar amb PUT_LINE()
    --DBMS_OUTPUT.PUT_LINE (v_actiu);
END;