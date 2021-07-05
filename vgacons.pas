Unit vgacons;

Interface

Var
  VideoBuf : PChar; // = PChar($b8000);
  ScreenWidth, ScreenHeight : LongInt;
  CursorPos : Word;
  CursorPosX, CursorPosY : Integer;


Procedure ClearScreen;
Procedure GetCursorPos;
Procedure SetCursorPos(X, Y : LongInt);
Procedure WriteTTY(c : Char);
Procedure WriteString(Const s : String);
Procedure NewLine;

Implementation

{$ASMMODE intel}
{$I sysfpcos.pp}
{$ASMMODE att}

procedure ClearScreen; [public, alias: 'ClearScreen'];
var
        i: Integer;
begin
	outportb($3C8, 0); {Paint the screen green on start ;-) }
	outportb($3C9, 0);
	outportb($3C9, 63);
	outportb($3C9, 0);

//        for i := 0 to 3999 do
//                VideoBuf[i] := #0;

	CursorPosX := 0;
	CursorPosY := 0;
end;

Procedure GetCursorPos; [public, alias: 'GetCursorPos'];

Begin
  outportb($3D4, $F);
  CursorPos := inportb($3D5);
  outportb($3D4, $E);
  CursorPos := CursorPos Or (inportb($3D5) Shl 8);
  CursorPosX := CursorPos Mod ScreenWidth;
  CursorPosY := CursorPos Div ScreenWidth;
End;

Procedure SetCursorPos(X, Y : LongInt); [public, alias: 'SetCursorPos'];

Begin
  CursorPosX := X;
  CursorPosY := Y;
  CursorPos := Y*ScreenWidth + X;
  outportb($3D4, $F);
  outportb($3D5, CursorPos And $FF);
  outportb($3D4, $E);
  outportb($3D5, (CursorPos Shr 8) And $FF);
End;

Procedure WriteTTY(c : Char); [public, alias: 'WriteTTY'];

Begin
  Case c Of
    #13 :
    Begin
      CursorPosX := 0;
      Inc(CursorPosY);
      If (CursorPosY >= ScreenHeight) Then
        CursorPosY := ScreenHeight - 1;
      SetCursorPos(CursorPosX, CursorPosY);
    End;
    Else
    Begin
      VideoBuf[CursorPos*2] := c;
      Inc(CursorPosX);
      If CursorPosX >= ScreenWidth Then
      Begin
        CursorPosX := 0;
        Inc(CursorPosY);
        If CursorPosY >= ScreenHeight Then
          CursorPosY := ScreenHeight - 1;
      End;
      SetCursorPos(CursorPosX, CursorPosY);
    End;
  End;
End;

Procedure WriteString(Const s : String); [public, alias: 'WriteString'];

Var
  I : Integer;

Begin
  For I := 1 To Length(s) Do
    WriteTTY(s[I]);
End;

Procedure NewLine; [public, alias: 'NewLine'];

Begin
      CursorPosX := 0;
      Inc(CursorPosY);
      If (CursorPosY >= ScreenHeight) Then
        CursorPosY := ScreenHeight - 1;
      SetCursorPos(CursorPosX, CursorPosY);
End;


Begin
  Pointer(VideoBuf) := Pointer($B8000);
  ScreenWidth := 80;
  ScreenHeight := 25;
  GetCursorPos;
End.
