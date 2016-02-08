MODULE replace;

IMPORT stdin, In := argsIn, Out := Console, Strings;

TYPE string = ARRAY 1024 OF CHAR;

PROCEDURE showhelp;
BEGIN

Out.String("= replace ="); Out.Ln;
Out.String("  takes stream from stdin and replaces <oldpattern> with <newpattern>"); Out.Ln;
Out.Ln;
Out.String("== usage =="); Out.Ln;
Out.String("  cat test.txt | replace <oldpattern> <newpattern>"); Out.Ln;
Out.Ln;
Out.String("== example =="); Out.Ln;
Out.String('  cat test.txt | replace "hello world" "hey you"'); Out.Ln;
Out.Ln;
HALT(0);
END showhelp;

PROCEDURE replace(VAR old, new: string);
VAR
  ch: CHAR;
  l:  LONGINT;
  oldlen : INTEGER;
  tm
BEGIN
   oldlen := Strings.Length(old);
   l := 0;
   REPEAT
     l := stdin.read(ch);
	 IF l # 0 THEN
     
	 END;
   UNTIL l # 0;
END replace;

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

PROCEDURE checkend;
BEGIN
  IF ~In.Done THEN showhelp END
END checkend;

PROCEDURE args(VAR old, new: string);
BEGIN
 In.Open;
   In.Name(old);
   checkend;
   In.Name(new);
   checkend;
END args;

PROCEDURE main;
VAR
  old, new: string;
BEGIN
  args(old, new);

  replace(old, new);
END main;

BEGIN
main;

(*getstdin;*)

END replace.
