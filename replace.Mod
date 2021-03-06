MODULE replace;

IMPORT hyaline, In := argsIn, Out := Console;

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

  hyaline.replace(old, new);
END main;

BEGIN
main;

END replace.
