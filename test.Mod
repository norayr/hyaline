MODULE test;

IMPORT stdin, Texts, Oberon, Out := Console;

PROCEDURE getstdin;
VAR ch: CHAR;
l : LONGINT;

BEGIN
   l := 0;
   REPEAT
      l := stdin.read(ch);
	  IF l # 0 THEN Out.Char(ch) END;
	  Out.Char(ch);
   UNTIL l # 0;

END getstdin;

PROCEDURE args;
VAR s : Texts.Scanner;
ch: CHAR;
i : INTEGER;
BEGIN
   Texts.OpenScanner(s, Oberon.Par.text, Oberon.Par.pos);
   Texts.Scan(s);
   IF (s.class = Texts.Char)(* & (s.c = Oberon.OptionChar)*) THEN
	  ch := s.nextCh;
	  Out.String("char: "); Out.Char(ch); Out.Ln;
   ELSIF s.class = Texts.String THEN
      Out.String("string: "); Out.Ln;
   ELSIF s.class = Texts.Int THEN
      Out.String("int: "); Out.Ln;
   END;

(*Texts.Scan(s);

IF s.class = Texts.Int THEN
   Out.String("integer: "); Out.Int(s.i, 0); Out.Ln;
END;
*)

END args;


BEGIN

args;

(*getstdin;*)

END test.
