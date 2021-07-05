{AFREE Prototype : Kernel}
{Version 2010.000}
{Lukas 'lukolve' Veselovsky}
{Under a MIT license WITTHOUT WARRANTY}


unit kernel;	{kernel}
 
interface
 
uses
        boot,		{multiboot}
        {dutils,}	{utils}
        {process,}	{threads}
	vgacons,	{console utils}
	vgaconsex;	{console extra utils}
 
procedure kmain(mbinfo: Pmultiboot_info_t; mbmagic: DWORD); stdcall;
 
implementation

{$ASMMODE intel}
{$I sysfpcos.pp}

function shiftpressed:boolean; [public, alias: 'shiftpressed']; {is press shift}
var std:byte;
begin
asm
  mov ah,2;
  int 16h
  mov std,al
  end;
shiftpressed:=(std and 1=1)or(std and 2=2);
end;
{$ASMMODE att}

procedure kuname(); [public, alias: 'kuname']; {kern name}
begin
  About();
end;

procedure kmeminform(); [public, alias: 'kmeminform']; {meminfo}
begin

end;

procedure kmain(mbinfo: Pmultiboot_info_t; mbmagic: DWORD); stdcall; [public, alias: 'kmain'];
begin
        Pointer(VideoBuf) := Pointer($B8000);
        ScreenWidth := 80;
        ScreenHeight := 25;
        GetCursorPos;

  outportb($3C8, 0); {Paint the screen green on exit ;-) }
  outportb($3C9, 63);
  outportb($3C9, 63);
  outportb($3C9, 63);

	MouseInit();
	MouseOn();

	{print the kerninfo}
	About();

        if (mbmagic <> MULTIBOOT_BOOTLOADER_MAGIC) then
        begin
                WriteString('Halting system, a multiboot-compliant boot loader needed!');
                NewLine();
                asm
                        cli
                        hlt
                end;
        end
        else
        begin
        	WriteString('Booted by a multiboot-compliant boot loader!');
                NewLine();
                //WriteString('Multiboot information:');
		//WriteString('                       Lower memory  = ');
		//WriteString(mbinfo^.mem_lower);
		//WriteString('KB');
                //WriteString('                       Higher memory = ');
    		//WriteString(mbinfo^.mem_upper);
    		//WriteString('KB');
    		//WriteString('                       Total memory  = ');
    		//WriteString(((mbinfo^.mem_upper + 1000) div 1024) +1);
    		//WriteString('MB');
        end;

      NewLine();
      WriteString(shell);

      Repeat
      
      Until False; // eh......
      
      NewLine();
      WriteString('End Of World..');
end;

end.
