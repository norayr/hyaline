MODULE stringreplace;

CONST

  StaticBufferSize = 16;



TYPE
  IntegerArray = ARRAY 0effffffX OF INTEGER;
  TPosEx = PROCEDURE(VAR SubStr, S: ARRAY OF CHAR; Offset: INTEGER): INTEGER;




PROCEDURE StringReplace(VAR S, OldPattern, NewPattern, Out: ARRAY OF CHAR);

VAR

  SrcLen, OldLen, NewLen, Found, Count, Start, Match, Matches, BufSize,

  Remainder    : INTEGER;

  PosExFunction: TPosEx;

  StaticBuffer : ARRAY StaticBufferSize-1 OF INTEGER;

  Buffer       : PIntegerArray;

  P, PSrc, PRes: PChar;

  Ch           : Char;

begin

  SrcLen := Length(S);

  OldLen := Length(OldPattern);

  NewLen := Length(NewPattern);                     

  if (OldLen = 0) or (SrcLen < OldLen) then

    begin

      if SrcLen = 0 then                   

        Result := '' {Needed for Non-Nil Zero Length Strings}

      else

        Result := S

    end

  else

    begin

      if rfIgnoreCase in Flags then

        begin

          PosExFunction := AnsiPosExIC;

          if GetACP <> srCodePage then {Check CodePage}

            InitialiseAnsiUpcase; {CodePage Changed - Update Lookup Table}

        end

      else

        PosExFunction := PosEx;

      if rfReplaceAll in Flags then

        begin

          if (OldLen = 1) and (NewLen = 1) then

            begin {Single Character Replacement}

              Remainder := SrcLen;

              SetLength(Result, Remainder);

              P := Pointer(Result);

              Move(Pointer(S)^, P^, Remainder);

              if rfIgnoreCase in Flags then

                begin

                  Ch := AnsiUpcase[OldPattern[1]];

                  repeat

                    Dec(Remainder);

                    if AnsiUpcase[P[Remainder]] = Ch then

                      P[Remainder] := NewPattern[1];

                  until Remainder = 0;

                end

              else

                begin

                  repeat

                    Dec(Remainder);

                    if P[Remainder] = OldPattern[1] then

                      P[Remainder] := NewPattern[1];

                  until Remainder = 0;

                end;

              Exit;

            end;

          Found := PosExFunction(OldPattern, S, 1);

          if Found <> 0 then

            begin

              Buffer    := @StaticBuffer;

              BufSize   := StaticBufferSize;

              Matches   := 1;

              Buffer[0] := Found;

              repeat

                Inc(Found, OldLen);

                Found := PosExFunction(OldPattern, S, Found);

                if Found > 0 then

                  begin

                    if Matches = BufSize then

                      begin {Create or Expand Dynamic Buffer}

                        BufSize := BufSize + (BufSize shr 1); {Grow by 50%}

                        if Buffer = @StaticBuffer then

                          begin {Create Dynamic Buffer}

                            GetMem(Buffer, BufSize * SizeOf(Integer));

                            Move(StaticBuffer, Buffer^, SizeOf(StaticBuffer));

                          end

                        else {Expand Dynamic Buffer}

                          ReallocMem(Buffer, BufSize * SizeOf(Integer));

                      end;

                    Buffer[Matches] := Found;

                    Inc(Matches);

                  end

              until Found = 0;

              SetLength(Result, SrcLen + (Matches * (NewLen - OldLen)));

              PSrc := Pointer(S);

              PRes := Pointer(Result);

              Start := 1;

              Match := 0;

              repeat

                Found := Buffer[Match];

                Count := Found - Start;

                Start := Found + OldLen;

                if Count > 0 then

                  begin

                    Move(PSrc^, PRes^, Count);

                    Inc(PRes, Count);

                  end;

                Inc(PSrc, Count + OldLen);

                Move(Pointer(NewPattern)^, PRes^, NewLen);

                Inc(PRes, NewLen);

                Inc(Match);

              until Match = Matches;

              Remainder := SrcLen - Start;

              if Remainder >= 0 then

                Move(PSrc^, PRes^, Remainder + 1);

              if BufSize <> StaticBufferSize then

                FreeMem(Buffer); {Free Dynamic Buffer if Created}

            end

          else {No Matches Found}

            Result := S

        end {ReplaceAll}

      else

        begin {Replace First Occurance Only}

          Found := PosExFunction(OldPattern, S, 1);

          if Found <> 0 then

            begin {Match Found}

              SetLength(Result, SrcLen - OldLen + NewLen);

              Dec(Found);

              PSrc := Pointer(S);

              PRes := Pointer(Result);

              if NewLen = OldLen then

                begin

                  Move(PSrc^, PRes^, SrcLen);

                  Inc(PRes, Found);

                  Move(Pointer(NewPattern)^, PRes^, NewLen);

                end

              else

                begin

                  if Found > 0 then                        

                begin

                  Move(PSrc^, PRes^, Found);

                  Inc(PRes, Found);

                end;

                  Inc(PSrc, Found + OldLen);

                  Move(Pointer(NewPattern)^, PRes^, NewLen);

                  Inc(PRes, NewLen);

                  Move(PSrc^, PRes^, SrcLen - Found - OldLen);

                end;

            end

          else {No Matches Found}

            Result := S

        end;

    end;

end;


END stringreplace.
