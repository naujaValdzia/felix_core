DEFINE TEMP-TABLE tt-src   NO-UNDO
   FIELD i1    AS INTEGER

   INDEX i-i1     i1
   .

DEFINE TEMP-TABLE tt-tgt   NO-UNDO
   LIKE tt-src
   .

   /* Procedure Variables           */

DEFINE VARIABLE cur-cnt    AS INTEGER     NO-UNDO.

   /* Procedure Dataset stuff       */

DEFINE DATA-SOURCE ds-1
   FOR tt-src
   .

DEFINE DATASET ds-1
   FOR tt-tgt
   .

   /* Put something in the src TT   */

DO cur-cnt = 1 TO 100:

   CREATE tt-src.

   ASSIGN
      tt-src.i1 = cur-cnt
      .

END.

   /* Attach DS to PDS              */

BUFFER tt-tgt:ATTACH-DATA-SOURCE(DATA-SOURCE ds-1:HANDLE).

   /* "Fill" the ds-1 PDS           */

DATASET ds-1:FILL().

   /* Detact DS                     */

BUFFER tt-tgt:DETACH-DATA-SOURCE().

   /* What do we have?              */

FOR EACH tt-tgt
   NO-LOCK,
   EACH tt-src
      WHERE tt-src.i1 = tt-tgt.i1
      NO-LOCK:

   DISPLAY
         tt-src.i1
         tt-tgt.i1
      WITH DOWN.

END.