MODULE test2;
IMPORT Args, Out:= Console;

VAR argnum: INTEGER;
    name : ARRAY 32 OF CHAR;
BEGIN
argnum := 0;

REPEAT
  Args.Get(argnum, name);
  Out.String(name); Out.Ln;
  INC(argnum);
UNTIL argnum = Args.argc;

END test2.
