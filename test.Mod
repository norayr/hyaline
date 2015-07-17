MODULE test;

IMPORT stdin, Texts, Oberon, Console;

PROCEDURE getstdin;
VAR ch: CHAR;
l : LONGINT;

BEGIN
l := 0;
   REPEAT
      l := stdin.read(ch);
	  IF l # 0 THEN Console.Char(ch) END;
   UNTIL l = 0;

END getstdin;

PROCEDURE args;
VAR s : Texts.Scanner;
ch: CHAR;
i : INTEGER;
BEGIN
   NEW(s);
   Texts.OpenScanner(s, Oberon.Par.text, Oberon.Par.pos);
   Texts.Scan(s);
   IF (s.class = Texts.Char)(* & (s.c = Oberon.OptionChar)*) THEN
	  ch := s.nextCh;
	  Console.Char(ch);
   ELSIF s.class = Texts.String THEN
      Console.String("string: "); Console.Ln;
   ELSIF s.class = Texts.Int THEN
      Console.String("int: "); Console.Ln;
   END;

(*Texts.Scan(s);

IF s.class = Texts.Int THEN
   Console.String("integer: "); Console.Int(s.i, 0); Console.Ln;
END;
*)

END args;


BEGIN

args;

(*getstdin;*)



END test.
