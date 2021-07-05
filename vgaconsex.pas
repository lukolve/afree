{AFREE Prototype : Kernel}
{Version 2010.000}
{Lukas 'lukolve' Veselovsky}
{Under a MIT license WITTHOUT WARRANTY}

unit vgaconsex;

Interface

 {info constants}
Const
 p_name = 'AFREE Prototype';
 p_date = '2010';
 p_ver = 'aa';
 p_author = 'by Lukas Vesel (lukves@centrum.sk)';
 p_web = 'web: http://www.lukves.ic.cz/os';
 p_info = 'Alternative Kernel Freedom';
 p_usage = 'GRUB : QEMU';
 p_doc = 'See readme file for details';
 p_license = 'AFREE OS Binary License Agreement / Source code not yet released but will be under GPLv2';
 wait_time = 800;

 {messages}

 shell='~# ';

Var 
    xq,yq,bq:integer;


Procedure About;
Procedure MouseInit;
Procedure MouseHandle;
Procedure MouseOn;
Procedure MouseOff;

Implementation Uses vgacons;


Procedure About; [public, alias: 'About']; {about}

Begin
 WriteString(p_name); WriteString(' '); WriteString(p_date); WriteString('.'); WriteString(p_ver); NewLine();NewLine();
 WriteString(p_author); NewLine(); NewLine();
 WriteString(p_web); NewLine();
 WriteString(p_info); NewLine(); NewLine();
 WriteString(p_license); NewLine();
End;

Procedure MouseInit; [public, alias: 'MouseInit'];
Begin
End;

Procedure MouseHandle; [public, alias: 'MouseHandle'];
Begin
End;

procedure MouseOn; [public, alias: 'MouseOn'];
Begin
End;

procedure MouseOff; [public, alias: 'MouseOff'];
Begin
End;


Begin
End.
