MODULE replace;

IMPORT stdin, In := argsIn, chararr, Out := Console, Strings;

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

PROCEDURE feelbuf(VAR str: ARRAY OF CHAR);
VAR
  i: INTEGER;
  l: LONGINT;
  ch : CHAR;
BEGIN
 l := 0; i := 0;
 REPEAT
   l := stdin.read(ch);
   str[i] := ch;
   INC(i);
 UNTIL (l > 1) OR (i = LEN(str));
END feelbuf;

PROCEDURE replace(VAR old, new: string);
VAR
  ch: CHAR;
  l:  LONGINT;
  oldlen : INTEGER;
  buf : POINTER TO ARRAY OF CHAR;
  res : chararr.CompareResults;
BEGIN
   oldlen := Strings.Length(old);
   NEW(buf, oldlen);
   feelbuf(buf^);
   (*Out.Char(buf^[0]); Out.Char(buf^[1]); Out.Char(buf^[2]); Out.Ln;*)
   res := chararr.Compare(buf^, old);
   IF res = chararr.equal THEN
     Out.String("equal"); Out.Ln
   ELSE
     Out.String("not equal"); Out.Ln
   END;
   l := 0;
  
   (*
   REPEAT
     l := stdin.read(ch);
	 IF l # 0 THEN
     
	 END;
   UNTIL l # 0;
   *)
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
