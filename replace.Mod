MODULE replace;

IMPORT stdin, In := argsIn, Out := Console;

PROCEDURE showhelp;
BEGIN

Out.String("= replace ="); Out.Ln;
Out.String("  takes stream from stdin and replaces <oldpattern> with <newpattern>"); Out.Ln;
Out.Ln;
Out.String("== usage =="); Out.Ln;
Out.String("cat test.txt | replace <oldpattern> <newpattern>"); Out.Ln;
Out.Ln;
Out.String("== example =="); Out.Ln;
Out.String('cat test.txt | replace "hello world" "hey you"'); Out.Ln;
Out.Ln;
HALT(0);
END showhelp;

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
VAR
  str: ARRAY 32 OF CHAR;
BEGIN
 In.Open;
 IF ~In.Done THEN showhelp END;
 REPEAT
   In.Name(str);
   Out.String(str); Out.Ln;
 UNTIL ~In.Done;
END args;

BEGIN

args;

(*getstdin;*)

END replace.
