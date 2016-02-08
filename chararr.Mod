MODULE chararr;

TYPE
  CompareResults* = SHORTINT;

CONST
  (* values returned by `Compare' *)
  less* = -1;
  equal* = 0;
  greater* = 1;

PROCEDURE Compare* (stringVal1, stringVal2: ARRAY OF CHAR): CompareResults;
  (* assumes that lengths of strings are equal *)
  VAR
    i: INTEGER;
  BEGIN
    i := 0;
    WHILE (i < LEN(stringVal1)-1) & (stringVal1[i] = stringVal2[i]) DO
      INC (i)
    END;
    IF (stringVal1[i] < stringVal2[i]) THEN
      RETURN less
    ELSIF (stringVal1[i] > stringVal2[i]) THEN
      RETURN greater
    ELSE
      RETURN equal
    END
  END Compare;



END chararr.
