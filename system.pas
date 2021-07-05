{AFREE Prototype : Kernel}
{Version 2010.000}
{Lukas 'lukolve' Veselovsky}
{Under a MIT license WITTHOUT WARRANTY}

unit system;
 
interface
 
type
 cardinal = 0..$FFFFFFFF;
 hresult = cardinal;
 dword = cardinal;
 integer = longint;
 
 pchar = ^char;

Procedure system_exit; {magic}
 
implementation

{$ASMMODE intel}
{$I sysfpcos.pp}
{$ASMMODE att}


Procedure system_exit;  [public, alias: 'system_exit']; {magic}

Begin
  Disable;
  outportb($3C8, 0); {Paint the screen green on exit ;-) }
  outportb($3C9, 0);
  outportb($3C9, 63);
  outportb($3C9, 0);
  Repeat
  Until False;
End;


end.
