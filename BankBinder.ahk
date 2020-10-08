buildscr = 2 ;������ ��� ���������, ���� ������ ��� � ver.ini - ���������
downlurl := "https://github.com/NikZakonov410/scripts/blob/master/upb.exe?raw=true"
downllen := "https://raw.githubusercontent.com/NikZakonov410/scripts/master/bankver.ini"

Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
    If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
        BOM = 3
    Else
        BOM = 0

    UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "Int", 0, "Int", 0)
    VarSetCapacity(UniBuf, UniSize * 2)
    DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "UInt", &UniBuf, "Int", UniSize)

    AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Int", 0, "Int", 0
                    , "Int", 0, "Int", 0)
    VarSetCapacity(AnsiString, AnsiSize)
    DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Str", AnsiString, "Int", AnsiSize
                    , "Int", 0, "Int", 0)
    Return AnsiString
}
WM_HELP(){
    IniRead, vupd, %a_temp%/ver.ini, UPD, v
    IniRead, desupd, %a_temp%/ver.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, update, %a_temp%/ver.ini, UPD, upd
    msgbox, ������ ��������� ������ %vupd%`n%update%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,��������������, ������ �������. ��������..`n��������� ������� ����������.
URLDownloadToFile, %downllen%, %a_temp%/ver.ini
IniRead, buildupd, %a_temp%/ver.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n������. ��� ����� � ��������.
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/ver.ini, UPD, v
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n���������� ���������� �� ������ %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/ver.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/ver.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    SplashTextoff
    msgbox, 16384, ���������� ������� �� ������ %vupd%, %desupd%
    IfMsgBox OK
    {
        msgbox, 1, ���������� ������� �� ������ %vupd%, ������ �� �� ����������?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,��������������, ����������. ��������..`n��������� ������ �� ������ %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/up.exe
            sleep, 1000
            run, %a_temp%/up.exe
            exitapp
        }
    }
}
SplashTextoff
IfnotExist, %A_ScriptDir%\MB ;���� ����� ����� ���, ��...
{
 FileCreateDir, %A_ScriptDir%\MB ;�� ������� ��� �����
}
IfnotExist, %A_ScriptDir%\MB\med.ini ;���� ������ ����� ���, ��...
{
URLDownloadToFile, https://raw.githubusercontent.com/NikZakonov410/scripts/master/med.ini, %A_ScriptDir%\MB\med.ini ;�� ���� ���� ���������
}
IfnotExist, %A_ScriptDir%\help.txt ;���� ������ ����� ���, ��...
{
URLDownloadToFile, https://raw.githubusercontent.com/NikZakonov410/scripts/master/help.txt, %A_ScriptDir%\help.txt ;�� ���� ���� ���������
}


IniRead, name, MB\med.ini, main, n
IniRead, delay, MB\med.ini, main, d

IniRead, r, MB\med.ini, main, r
IniRead, forg, MB\med.ini, main, forg
IniRead, rankname, MB\med.ini, main, rankname
if forg = ���
{
 if r = 1
 rankname = ������ 
 if r = 2
 rankname = ���������� ����
 if r = 3
 rankname = ��������
 if r = 4
 rankname = ��������
 if r = 5
 rankname = �������
 if r = 6
 rankname = ������
 if r = 7
 rankname = ��������
 if r = 8
 rankname = ���. ����������
 if r = 9
 rankname = ���.����.�����
 if r = 10
 rankname = ����.����
}
if forg = ����
{
 if r = 1
 rankname = ������ 
 if r = 2
 rankname = ���������� ����
 if r = 3
 rankname = ��������
 if r = 4
 rankname = ��������
 if r = 5
 rankname = �������
 if r = 6
 rankname = ������
 if r = 7
 rankname = ��������
 if r = 8
 rankname = ���. ����������
 if r = 9
 rankname = ���.����.�����
 if r = 10
 rankname = ����.����
}
if forg = ��-�
{
 if r = 1
 rankname = ������ 
 if r = 2
 rankname = ���������� ����
 if r = 3
 rankname = ��������
 if r = 4
 rankname = ��������
 if r = 5
 rankname = �������
 if r = 6
 rankname = ������
 if r = 7
 rankname = ��������
 if r = 8
 rankname = ���. ����������
 if r = 9
 rankname = ���.����.�����
 if r = 10
 rankname = ����.����
}
SendMessage, 0x50,, 0x4190419,, A
Gui, Font, S15 CDefault Bold, Trebuchet MS
Gui, Add, Text, x65 y9 w110 h30 ,  ���������
Gui, Font, S10 CDefault Bold, Trebuchet MS
Gui, Add, Button, x25 y169 w180 h30 gKeyR, ������ ����(1-10)
Gui, Add, Button, x25 y129 w180 h30 gKeyS, ������ ��������
Gui, Add, Button, x25 y89 w180 h30 gKeyN, ������ ���-����
Gui, Add, Button, x25 y49 w180 h30 gKeyO, ������ �������� ���.
Gui, Add, Button, x2 y229 w60 h30 gKeyOK, OK
Gui, Add, Button, x167 y229 w60 h30 gKeyI, INFO
; Generated using SmartGUI Creator 4.0
Gui, Show, x497 y241 h262 w230, MedBinder
Return

GuiClose:
ExitApp

keyN:
InputBox, ni, ��� ����, ������� ���� ���.`n��� �������� ��� - %name%
IniWrite, %ni%, MB\med.ini, main, n
return
keyR:
InputBox, fN, ����, ������� ���� ����(1-10).`n�� ������ ������ �� %rankname%[%r%]
IniWrite, %fN%, MB\med.ini, main, r
reload
return
keyS:
InputBox, S, ��������, ������� ��������(������: 1000) 1000 = 1 �������.`n���� �������� - %delay%
IniWrite, %S%, MB\med.ini, main, d
return
keyO:
InputBox, Org, �����������, ������� �������� ����� �����������(��� | ���� | ��-�).`n���� �������� ����������� - %forg% 
IniWrite, %Org%, MB\med.ini, main, forg
return
keyOK:
gui,Minimize
return
keyI:
MsgBox, 64, INFO, ������ ������ ��� �� �������� ������������ ������. ��������� - ��� �������`n(@sukhankov - VK)`n��� ���������� �� ��������, �� ������ ���������� � ��������� ���������, ������� ��������� ����� ������� �������.                                
return


  :?:/p:: 
  SendMessage, 0x50,, 0x4190419,, A
  IniRead, r, MB\med.ini, main, r
  SendInput, {F6}{Enter}
  SendInput, {F6}������������, ���� ����� %name%, � %rankname% %forg% {Enter}
  sleep %delay%
  SendInput, {F6}��� � ���� ��� ������? {Enter}
  return
  :?:/h:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 1
  {
  Sendinput, {F6}������, ������ � ����� ��� ���������, � ������� 10 ����� ��� ������ ���� �����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���������� �������� � �����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ������ ��������� ������ ����, ������(�) ��������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���������� �������� ������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ��������(�) ����, ����� ���� ����(�) ��������� "��������"{Enter}
   Sleep %delay%
  Sendinput, {F6}������� ���������, ��������� ��� ��� ������ ���������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/heal {Space}
   Sleep %delay%

  }
  if r < 2
   {
   SendInput, {F6}��������, �� � �� ���� ��� ��������, ������ ������ ������� {Enter}
   sleep %delay%
   SendInput, {F6}/r ����� �������� ����������, ����� ������� ������� � ������ {enter}
   }
  return
  
  :?:/utatu:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 5
  {
   Sleep %delay%
  Sendinput, {F6}�������, �������� ����� ����������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b /showtatu{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ��������(�) �������� ������� MV-110{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ������� �������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ����(�) ��������, ����� ���� ����(�) ������� � ����{Enter}
   Sleep %delay%
  Sendinput, {F6}/do �������� �����, ������� � ����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ������� ���������, �����(�) ������ ��������� �� �������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ������� ������� ���� ����������� ����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���� "��������" ����� � �������� ���� �� �����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ������ ��������� ����(�) ����, ����� ���� ������(�) ��{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���� � �������� ���� ��������� � ����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ���������� ��������� �����(��) ����, ����� ���� ������(�) �������{Enter}
   Sleep %delay%
  Sendinput, {F6}���, �� �������� ������ �� ���������� ������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/unstuff 7000{Space}
   Sleep %delay%

  }
  if r < 6
   {
   SendInput, {F6}��������, �� � �� ���� ����� ��� ����, ������ ������ ������� {Enter}
   sleep %delay%
   SendInput, {F6}/r ����� ����� ���� ����������, ����� ������� ������� � ������� ������� {enter}
   }
  return
  :?:/medc:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 2
  {
  Sendinput, {F6}������������, �� ������ �� ���.������?{Enter}
   Sleep %delay%
  Sendinput, {F6}������, �� ���������� ���.����� ����� ������� �������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ������ "������� ��-200" ����� �� �����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ��������(�) ���� �� ������ ������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���� ������ � ����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me �������(�) ���� ������ � �������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���� ������ � ��������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me �����(�) ��������� ����� ���.����� ����� ����������� ���������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ����� ���.����� ������ � ����������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me �����(�) ������ "������" ����� ���� ��������(�) ���.�����{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���.����� �����������.{Enter}
   Sleep %delay%
  Sendinput, {F6}���� ���.����� ������ � �������������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b ����� ��� ������ ���.�����, ��� ����� �� ��������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b /pay id 3000.{Enter}
   Sleep %delay%
  Sendinput, {F6}/medcard{Space}
   Sleep %delay%

  }
  if r < 3
   {
   SendInput, {F6}��������, �� � �� ���� ������ ��� ���.�����, ������ ������ ������� {Enter}
   sleep %delay%
   SendInput, {F6}/r ����� ������ ���.����� ����������, ����� ������� ������� � ������ {enter}
   }
  return
  :?:/apt:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 5
  {
  Sendinput, {F6}������������, �� ������ �� ��������?{Enter}
   Sleep %delay%
  Sendinput, {F6}������, ������ � ����� ��� �������� �������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ������������ ������� ����� � �����, ��� ������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ����(�) ������ �� �����, ����� ���� ������(�) ������ ���-�� ������������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ������������ ������� ����� �� �����.{Enter}
   Sleep %delay%
  Sendinput, {F6}������� ��� �������� �������, ����� ��� ��� ��� �������, ��� ����� ��������� ��� ��� �������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me �������(�) ������� �� ����� ��� �������{Enter}
   Sleep %delay%
  Sendinput, {F6}/sellmed{Space}
   Sleep %delay%

  }
  if r < 6
   {
   SendInput, {F6}��������, �� � �� ���� ������ ��� �������, ������ ������ ������� {Enter}
   sleep %delay%
   SendInput, {F6}/r ����� ������ ������� ����������, ����� ������� ������� � ������ {enter}
   }
  return
  :?:/rec:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 3
  {
  Sendinput, {F6}������, �� ���������� ������� ����� ������� �������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ������ "�4" ����� �� �����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ��������(�) ���� �� ������ ������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���� ������ � ����.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me �������(�) ���� ������ � �������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do ���� ������ � ��������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me �����(�) ���������� �������� ����� ����������� ���������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do �������� ������ � ����������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me �����(�) ������ "������" ����� ���� ��������(�) ��������{Enter}
   Sleep %delay%
  Sendinput, {F6}/do �������� �����������.{Enter}
   Sleep %delay%
  Sendinput, {F6}���� �������� ������ � �������������.{Enter}
   Sleep %delay%
  Sendinput, {F6}����� ��� ������ ��������, ��� ����� �� ��������.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b /pay id 1500.{Enter}
   Sleep %delay%
  Sendinput, {F6}/recept{Space}
   Sleep %delay%

  }
  if r < 4
   {
   SendInput, {F6}��������, �� � �� ���� ������ ��� ������, ������ ������ ������� {Enter}
   sleep %delay%
   SendInput, {F6}/r ����� ������ ������ ����������, ����� ������� ������� � ������ {enter}
   }
  return
   :?:/sob:: 
   IniRead, r, MB\med.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   if r > 4
   {
   SendInput, {F6}������������, ������������ ��� ���������� ���� ���������, � ������.. {Enter}
     sleep %delay%
   SendInput, {F6}..�������, ���.����� � �������� �� ��������{Enter}
     sleep %delay%
   SendInput, {F6}/b ��������: 3 LVL, 35 �����������������, �� ������ 5 ���������������� {Enter}
     sleep %delay%
   SendInput, {F6}/b ��� ��������� ���������� �� ��{!} {Enter}
   }
   if r < 5
   {
   SendInput, {F6}��������, � �� ���� ��������� �������������, ������ ������ ������� {Enter}
     sleep %delay%
   SendInput, {F6}/r ��������� ������ �� �������������, ����� ������� ������� � ������ {enter}
   }
   return
   :?:/tpass:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do ������� �� ����� {Enter}
     sleep %delay%
   SendInput, {F6}/me ���� ������� � ���� {Enter}
     sleep %delay%
   SendInput, {F6}/do ������� � �����{Enter}
     sleep %delay%
   SendInput, {F6}/me ������ ������� �� ������ ��������, ���������� ������ ������ {Enter}
     sleep %delay%
   SendInput, {F6}/do ������� �������� {Enter}
     sleep %delay%
   SendInput, {F6}/todo ������*��������� ������� {Enter}
   return
   :?:/tlic:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do �������� ���� �� ����� {Enter}
     sleep %delay%
   SendInput, {F6}/me ���� �������� � ���� {Enter}
     sleep %delay%
   SendInput, {F6}/do �������� � �����{Enter}
     sleep %delay%
   SendInput, {F6}/me ���� ��������, �������� � �� ����������� {Enter}
     sleep %delay%
   SendInput, {F6}/do �������� ��������� {Enter}
     sleep %delay%
   SendInput, {F6}/todo ���..*��������� �������� {Enter}
   return
   :?:/tmed:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do ���.����� �� ����� {Enter}
     sleep %delay%
   SendInput, {F6}/me ���� ���.����� � ���� {Enter}
     sleep %delay%
   SendInput, {F6}/do ���.����� � �����{Enter}
     sleep %delay%
   SendInput, {F6}/me ������ ���.�����, �������� ������� ����������� {Enter}
     sleep %delay%
   SendInput, {F6}/do ���.����� ��������� {Enter}
     sleep %delay%
   SendInput, {F6}/todo �������*��������� ���.����� {Enter}
   return
   :?:/inv:: 
   IniRead, r, MB\med.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}����������, �� ��� ���������{!} {Enter}
     sleep %delay%
   SendInput, {F6}/do � �������� ����� �������� {Enter}
     sleep %delay%
   SendInput, {F6}/me ���� �������, ������ ���� ���������, ��� � �������{Enter}
     sleep %delay%
   SendInput, {F6}/do ������� ����� {Enter}
     sleep %delay%
   SendInput, {F6}/me ������� ������� ������ ��������� {Enter}
     sleep %delay%
   if r > 8
   {
   SendInput, {F6}/invite{space}
   }
   if r < 9
   {
   SendInput, {F6}/rb ������� � ����������� ID {space}
   }
   return
   :?:/otkl:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}� ���������, �� ��� �� ��������� {Enter}
     sleep %delay%
   SendInput, {F6}/b ��������� ������� ������: {Enter}
     sleep %delay%
   SendInput, {F6}/b �� ��������� �� ���������, ��� ��, ����.�����������{Enter}
     sleep %delay%
   SendInput, {F6}��������� ���! {Enter}
   return
  
  :?:/grank:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 8
  {
  SendInput, {F6}���������� ��� � ����������{!} {Enter}
    sleep %delay%
  SendInput, {F6}/do ����� ������� � ����� {Enter}
    sleep %delay%
  SendInput, {F6}/me ������� ������� ���������� {Enter}
    sleep %delay%
  SendInput, {F6}/giverank{space}
  }
  if r < 9
  {
  SendInput, {F6}� �� ���� ��� �������� {Enter}
  }
  return
  :?:/fw:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 6
  {
  SendInput, {F6}/do ������� � ���� {Enter}
    sleep %delay%
  SendInput, {F6}/me ����� � ������ ���� ����������, ����� ��� ������� {Enter}
    sleep %delay%
  SendInput, {F6}/do ���������� �������� ������� {Enter}
    sleep %delay%
  SendInput, {F6}/fwarn{space}
  }
  if r < 7
  {
  SendInput, {F6}� �� ���� ������ �������{enter}
  }
  return
  :?:/ufw:: 
  IniRead, r, MB\med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 8
  {
  SendInput, {F6}/do ������� � ���� {Enter}
  sleep %delay%
  SendInput, {F6}/me ����� � ������ ���� ����������, ���� ��� ������� {Enter}
  sleep %delay%
  SendInput, {F6}/do � ���������� -1 ������� {Enter}
  sleep %delay%
  SendInput, {F6}/unfwarn{space}
  }
  if r < 9
  {
  SendInput, {F6}� �� ���� ����� �������{enter}
  }
  return
  :?:/op1:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    Sendinput, {F6}/me ����� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ����� �����{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� �������������� ������� ���������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ���������{Enter}
     sleep %delay%
    Sendinput, {F6/me ������ ��������� ������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ���������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ����������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������ ����������� �� ����������� �������������� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ���������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������ ��������� ������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ���������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ����������� �����������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ������ ������������� ��������.{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� �� ���� ��� �����������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ���� ������������.{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ������������ �������.{Enter}
     sleep %delay%
    Sendinput, {F6}/me �������� �������������� ������� ���������{Enter}
     sleep %delay%    
    Sendinput, {F6}/me ���� �����{enter}
     sleep %delay%
    Sendinput, {F6}/me ������ ����������� �� ��������� �������� �� ���������.{Enter}
     sleep %delay%
    Sendinput, {F6}/heal{space}

  return
  :?:/op2:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    Sendinput, {F6}/me �������� ���� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ������� ������� ��� ��������� ������������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��� �������� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ���� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������ ��������������{Enter}
     sleep %delay%
    Sendinput, {F6}/me �������� ����������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ������� �������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ����� ����� ������� �� ���������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ���������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������ ������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� �����{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ����{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ������ � ������� ����� ����� ���� ����������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ����� � ������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ����� ����{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ���� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ���� ������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ����� ���������{Enter}
     sleep %delay%
    Sendinput, {F6}/heal{space}
    if ascreen = true 
    {
    Sendinput, {F6}/time{Enter}
     sleep 200
    Sendinput, {F8}
    }
  return
  :?:/op3:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    Sendinput, {F6}/me �������� ���� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ������� ������� ��� ��������� ������������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ����{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������ ��������������{Enter}
     sleep %delay%
    Sendinput, {F6}/me �������� ����������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ������� ������� �������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ���� ����� � ������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ����� ����{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ���� ��������{Enter}
     sleep %delay%
    Sendinput, {F6}/me ��������� ���� ������{Enter}
     sleep %delay%
    Sendinput, {F6}/heal{space}
    if ascreen = true 
    {
    Sendinput, {F6}/time{Enter}
     sleep 200
    Sendinput, {F8}
    }
  return
  :?:-��������:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}������������, ��������� ����������{!}{Enter}
      sleep %delay%
    SendInput, {F6}������ � ������� ��������� ��������...{Enter}
     sleep %delay%
    SendInput, {F6}..�� ������� ���.����{Enter}
     sleep %delay%
    SendInput, {F6}����� ���� ������� ���� ���.����� � ������������ �� ����������� %forg%{Enter}
     sleep %delay%
    SendInput, {F6}������� �� ���������.{Enter}
     sleep %delay%
  return
  :?:-�����������:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do ���.����� �� ����� {Enter}
   sleep %delay%
   SendInput, {F6}/me ���� ���.����� � ���� {Enter}
   sleep %delay%
   SendInput, {F6}/do ���.����� � �����{Enter}
   sleep %delay%
   SendInput, {F6}/me ������ ���.�����, �������� ������� ����������� {Enter}
   sleep %delay%
   SendInput, {F6}/do ���.����� ��������� {Enter}
   sleep %delay%
   SendInput, {F6}/todo �������*��������� ���.����� {Enter}
      SendInput, {F6}/time {Enter}
      sleep 100
   SendInput, {F8}
  return
  :?:-�����������:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do �� ����� ��������� �����������{Enter}
   sleep %delay%
   SendInput, {F6}/me ����� ��������� ����, ������ ����������� {Enter}
   sleep %delay%
   SendInput, {F6}/do ����������� ������{Enter}
   sleep %delay%
   SendInput, {F6}/me ������ ���� � �����, �������� �������� {Enter}
   sleep %delay%
   SendInput, {F6}/try ��� ���������� {Enter}
   sleep %delay%
   SendInput, {F6}/todo ��...*������������ �������� {Enter}
   sleep %delay%
   SendInput, {F6}/time {Enter}
      sleep 100
   SendInput, {F8}
  return
  :?:-�������������:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/me ������ ��� � �����, ������ ���{Enter}
   sleep %delay%
   SendInput, {F6}���.. � ������������ ��������� ������������ ����{Enter}
   sleep %delay%
   SendInput, {F6}�� ������� �� ��������� ������, ���� �������� �� ���������..{Enter}
   sleep %delay%
   SendInput, {F6}..�� ������� ����������, � �� ������ ������ ��������� �����{!}{Enter}
   sleep %delay%
   SendInput, {F6}/time {Enter}
      sleep 100
   SendInput, {F8}
  return
  :?:/lec1:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}/r ��������� �������, ����� ���������� ������ ������ ����� ������ � ��������� ���������� ���� � ������ �� �����.{Enter}
      sleep %delay%
    SendInput, {F6}/r �� ����� ����� ������ ������ � ��������� ���������� ����.{Enter}
     sleep %delay%
    SendInput, {F6}/r �������� ����� ����� ������ � ��������� ���������� ���������� � ������ �� �����.{Enter}
     sleep %delay%
    SendInput, {F6}/r ��� ������� ������� ����� ������ � ������� � ������ ������.{Enter}
     sleep %delay%
    SendInput, {F6}/r ������� �� ��������.{Enter}
     sleep %delay%
  return
  :?:/lec2:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}/r ��������� ����������, ����� ��������� ������ ��������. {Enter}
     Sleep %delay%
    SendInput, {F6}/r �������� ����� ������ � ������� � ������ � �������������.{Enter}
     Sleep %delay%
    SendInput, {F6}/r ��� ����� �������� ��� �������������, ������� ������� ������ �� ����������.{Enter}
     Sleep %delay%
    SendInput, {F6}/r ������� �� ��������.{Enter}
     Sleep %delay%
    Sendinput, {F6}/time{Enter}
     Sleep 150
    sendinput, {F8}
  Return
  :?:/lec3:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}/r ��������� ������� ����� ��������� ��������. {Enter}
     Sleep %delay%
    SendInput, {F6}/r ����� �������� ��������� ����������� ����� ����: ����� ����������� �����, ����������� �������.{Enter}
     Sleep %delay%
    SendInput, {F6}/r ����� �������� ��������� ����������� ����� ��� ��� � ������������� �� �����.{Enter}
     Sleep %delay%
    SendInput, {F6}/r ������� �� ��������.{Enter}
     Sleep %delay%
    Sendinput, {F6}/time{Enter}
     Sleep 150
    Sendinput, {F8}
  Return
  :?:-�����:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}��������� ����������, ������ � ������� ��� ����������. {Enter}
     Sleep %delay%
    SendInput, {F6}������ � ��������...{Enter}
     Sleep %delay%
    SendInput, {F6}20 ���������� � 30 ���������.{Enter}
     Sleep %delay%
    SendInput, {F6}���������, ������ ����� ������ ��������{space}
  Return
  :?:/reload:: 
  Reload


!Home::
Process, Close, gta_sa.exe
Process, Close, bdcam.exe
return
; --------------------����� ������---------------------------

