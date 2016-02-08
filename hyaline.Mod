MODULE hyaline;

IMPORT Out := Console, Strings, stdin, chararr;

PROCEDURE feelbuf(VAR str: ARRAY OF CHAR);
VAR
  i, j, k, l: LONGINT;
  ch : CHAR;
BEGIN
 l := 0; i := 0;
 k := LEN(str);
 REPEAT
   l := stdin.read(ch);
   str[i] := ch;
   INC(i);
 UNTIL (l # 1) OR (i = k);
 IF l # 1 THEN 
   j := i-1;
   REPEAT
   str[j] := 0X;
   INC(j)
   UNTIL j = k;
 END
END feelbuf;

PROCEDURE WriteLn(VAR str : ARRAY OF CHAR; last: INTEGER);
VAR
  i : INTEGER;
  k : LONGINT;
BEGIN
  i := 0;
  k := Strings.Length(str);
  IF i < k THEN
    REPEAT
      Out.Char(str[i]);
	  INC(i)
    UNTIL (i = last) OR (i = k)
  END
END WriteLn;

PROCEDURE replace*(VAR old, new: ARRAY OF CHAR);
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
   l := 0;
   REPEAT
	 res := chararr.Compare(buf^, old);
	 IF res = chararr.equal THEN
	   (*Out.String("equal"); Out.Ln*)
	   WriteLn(new, Strings.Length(new));
	   feelbuf(buf^);
	 ELSE
	   (*Out.String("not equal"); Out.Ln*)
	   Out.Char(buf^[0]);
	   chararr.ShiftLeft(buf^); 
	   l := stdin.read(ch);
	   IF l = 1 THEN
		 buf^[oldlen-1] := ch;
	   END;
	 END;
   UNTIL l # 1; 
   WriteLn(buf^, oldlen-1);
   (*Out.Char(0AX);*)
   (*Out.Flush;*)
END replace;

END hyaline.
