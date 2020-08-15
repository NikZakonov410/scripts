script_version(1.0)
script_author("��� ������� | ����������� �����")

local dlstatus = require('moonloader').download_status
local sampev = require 'lib.samp.events'
local inicfg = require 'inicfg'
local screenshot = require 'lib.screenshot'
local main_color = 0xDC143C
local main_color_text = "{DC143C}"
local mc, sc, wc = '{006AC2}', '{006D86}', '{FFFFFF}'
local mcx = 0x006AC2
require "lib.moonloader"

update_state = false

local script_vers = 1
local script_vers_text = '1.00'

local update_url = "https://raw.githubusercontent.com/NikZakonov410/scripts/master/update.ini"
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = "https://raw.githubusercontent.com/NikZakonov410/scripts/master/MH.lua"
local script_path = thisScript().path

if not doesFileExist("moonloader/config/mhelper.ini") then--cfg
  inicfg.save(mainIni, "mhelper.ini") end
  
  local mainIni = inicfg.load({
    configIni =
    {
    Nick = "",
    Dol = "",
    Org = ""
    }
    }, "mhelper")

function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(100) end
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}��������! ������ {DC143C}1.0 {ffffff}by {DC143C}��� ������� {ffffff}| {DC143C}����������� �����",-1)
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}��� ������� - {DC143C}/mhelp 0",-1)
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}���� ��� - {DC143C}" ..mainIni.config.Nick.. "{ffffff}, �� - {DC143C}" ..mainIni.config.Dol.. "{ffffff}, {DC143C}"..mainIni.config.Org, -1) 
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}��������� ������������� {DC143C}<3",-1)

  downloadUrlToFile (update_url,update_path, function(id, status)
    if status == dlstatus.STATUS.ENDDOWNLOADDATA then
       updateIni = inicfg.load[nil, update_path)
      if tonumber(updateIni.info.vers) > script_vers then
        sampAddChatMessage('{DC143C}[MedHelper] {ffffff}��������� ����������! ����� ������: ' ..updateIni.info.vers_text,-1)
        update_state = true
      end
      os.remove(update_path)
    end
  end)

  sampRegisterChatCommand("mhelp", function(arg)
    if #arg == 0 then
      sampAddChatMessage("{DC143C}[MedHelper] {ffffff}������� /mhelp 0", -1)
    end
    if tonumber(arg) == 0 then
      sampShowDialog(10, "������ � MedHelper", "{DC143C}��������! {ffffff}�� ������� �� {DC143C}1-�� {ffffff}�����, �� ������ �������� {DC143C}�������!\n\n{DC143C}��� + 1 {ffffff}- �������� ����������\n{DC143C}��� + 2 {ffffff}- �������� ��������\n{DC143C}��� + 3 {ffffff}- �������� ���������� ����-��, ���, ��-� � ��� \n{DC143C}��� + 4 {ffffff}- �������� ���������� ����, �����, ��, ����, ��-�, ����\n\n{DC143C}��� + 5-8 {ffffff}�������� {DC143C}����� {ffffff}������� {DC143C}��� + Z\n\n{DC143C}��� + 5 {ffffff}- ������ ���.�����\n{DC143C}��� + 6 {ffffff}- ������ ������\n{DC143C}��� + 7 {ffffff}- ������ ����\n{DC143C}��� + 8 {ffffff}- ������ �������\n\n{DC143C}��� + NumPad0 {ffffff}- ������ �������������\n{DC143C}��� + NumPad1 {ffffff}- ��������� ��������(����� �������� ������� ���)\n{DC143C}��� + NumPad 2 {ffffff}- �������� ����-�����\n{DC143C}��� + NumPad 3 {ffffff}- ������� � �����������\n{DC143C}��� + NumPad 4 {ffffff}- �������� � ��������\n\n{DC143C}��� + Z {ffffff}- ��������� ������ �� ������(5-8)\n\n�������� ������ - /lec1 /lec2 /lec3\n\n��� ��������� {DC143C}�����{ffffff}, {DC143C}��������� {ffffff}� {DC143C}����������� {ffffff}�������� ���� {DC143C}MHELP.TXT{ffffff}, ��� �� ��������", "�������", "�������", 0)
    end
  end)
	sampRegisterChatCommand('scrheal', function(fileName) -- /savescreen ���� /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/�������', fileName) -- ���� ���������� �����: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrmedcard', function(fileName) -- /savescreen ���� /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/����� ���-�����', fileName) -- ���� ���������� �����: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrrecept', function(fileName) -- /savescreen ���� /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/����� �������', fileName) -- ���� ���������� �����: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrunstuff', function(fileName) -- /savescreen ���� /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/HEAL', fileName) -- ���� ���������� �����: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrsellmed', function(fileName) -- /savescreen ���� /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/HEAL', fileName) -- ���� ���������� �����: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
	end)		
	
  wait(-1)
  
  while true do 
   wait(0)

    if update_state then
      downloadUrlToFile (script_url,script_path, function(id, status)
        if status == dlstatus.STATUS.ENDDOWNLOADDATA then
          sampAddChatMessage('{DC143C}[MedHelper] {ffffff}������ ������� ��������!', -1)
          thisScript():reload()    
        end
      end)
      break
    end

   local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_1) then
         sampSendChat("������������, ���� ����� " ..mainIni.config.Nick.. ", � ��� ������� ����", -1)
          wait(900)
         sampSendChat("/do �� ����� �������, �� �� ��������: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
          wait(900) 
         sampSendChat("������ �������� ��� ������!", -1)
          wait(900) 
         sampSendChat("/do ���. ����� �� �����.", -1)
          wait(900)
         sampSendChat("/me ���� ���.�����", -1)
          wait(900) 
         sampSendChat("/me ������ ���.�����", -1)
          wait(900)
         sampSendChat("/me ������ ������ ��������", -1)
          wait(900) 
         sampSendChat("/do �������� � ����.", -1)
          wait(900)
         sampSendChat("/todo ���, ��������, ��� ������ ��� ������*������� ��������", -1)
          wait(900)    
         sampSendChat("/heal " ..id.. ' 1000', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}������ �� ������� ID - {DC143C}[" ..id.. "] {FFFFFF}���������.", -1)
          wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_2) then
          sampSendChat("������������, ���� ����� " ..mainIni.config.Nick.. ", � ��� ������� ����", -1)
          wait(900)
         sampSendChat("/do �� ����� �������, �� �� ��������: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
          wait(900) 
         sampSendChat("������ �������� ��� ������!", -1)
          wait(900) 
         sampSendChat("/do ���. ����� �� �����.", -1)
          wait(900)
         sampSendChat("/me ���� ���.�����", -1)
          wait(900) 
         sampSendChat("/me ������ ���.�����", -1)
          wait(900)
         sampSendChat("/me ������ ������ ��������", -1)
          wait(900) 
         sampSendChat("/do �������� � ����.", -1)
          wait(900)
         sampSendChat("/todo ���, ��������, ��� ������ ��� ������*������� ��������", -1)
          wait(900)    
         sampSendChat("/heal " ..id.. ' 1000', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}������ �� ������� ID - {DC143C}[" ..id.. "] {FFFFFF}���������.", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
         sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_3) then
          sampSendChat("������������, ���� ����� " ..mainIni.config.Nick.. ", � ��� ������� ����", -1)
          wait(900)
         sampSendChat("/do �� ����� �������, �� �� ��������: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
          wait(900) 
         sampSendChat("������ �������� ��� ������!", -1)
          wait(900) 
         sampSendChat("/do ���. ����� �� �����.", -1)
          wait(900)
         sampSendChat("/me ���� ���.�����", -1)
          wait(900) 
         sampSendChat("/me ������ ���.�����", -1)
          wait(900)
         sampSendChat("/me ������ ������ ��������", -1)
          wait(900) 
         sampSendChat("/do �������� � ����.", -1)
          wait(900)
         sampSendChat("/todo ���, ��������, ��� ������ ��� ������*������� ��������", -1)
          wait(900)    
         sampSendChat("/heal " ..id.. ' 250', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}������ �� ������� ID - {FFFF00}[" ..id.. "] {FFFFFF}���������.", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_4) then
          sampSendChat("������������, ���� ����� " ..mainIni.config.Nick.. ", � ��� ������� ����", -1)
          wait(900)
         sampSendChat("/do �� ����� �������, �� �� ��������: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
          wait(900) 
         sampSendChat("������ �������� ��� ������!", -1)
          wait(900) 
         sampSendChat("/do ���. ����� �� �����.", -1)
          wait(900)
         sampSendChat("/me ���� ���.�����", -1)
          wait(900) 
         sampSendChat("/me ������ ���.�����", -1)
          wait(900)
         sampSendChat("/me ������ ������ ��������", -1)
          wait(900) 
         sampSendChat("/do �������� � ����.", -1)
          wait(900)
         sampSendChat("/todo ���, ��������, ��� ������ ��� ������*������� ��������", -1)
          wait(900)    
         sampSendChat("/heal " ..id.. ' 500', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}������ �� ������� ID - {4169E1}[" ..id.. "] {FFFFFF}���������.", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_5) then
          sampSendChat("������, �� �������� ������ �����, �� � ������ ��� ���������", -1)
          wait(900) 
          sampSendChat("/me ����� ��������, �������� �������� ��������", -1)
          wait(900)
          sampSendChat("/do ��������� ��������� ������", -1)
          wait(900) 
          sampSendChat("�������! ������ ����� ��� ���.�����", -1)
          wait(900) 
          sampSendChat("/me ������ ����� ������ ���. ���� � ����� ��������� ����� ���. �����", -1)
          wait(900) 
          sampSendChat("/do ���. ����� ������. ������: ��������� ������.", -1)
          wait(900)
          sampSendChat("/me ������� ������� ���. ����� ��������", -1)
          wait(900)  
          sampSendChat("/medcard " ..id.. " 3", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ������ ���.����� ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrmedcard medcard')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_6) then
          sampSendChat("������, �� �������� ������ �����, ������ � ����� ��� �������", -1)
          wait(900) 
          sampSendChat("/do � ���.����� ����� ������ �������", -1)
          wait(900)
          sampSendChat("/me �������� ������, ����� ��� ����������", -1)
          wait(900) 
          sampSendChat("��� ���� �������.", -1)
          wait(900)  
          sampSendChat("/recept " ..id, -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ������ ������ ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrrecept recept')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_7) then
         sampSendChat("/do ������� ��� ������� ���� �� �����.", -1)
          wait(900) 
          sampSendChat("me ���� ������� ��� ���������� ����.", -1)
          wait(900)
          sampSendChat("/do ������� � ������ ����.", -1)
          wait(900) 
          sampSendChat("/me ����� �������� ����.", -1)
          wait(900)
          sampSendChat("���, ��� ����� �������. ����� ��� �������.", -1)
          wait(900) 
          sampSendChat("/unstuff " ..id.. " 4000", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ������ ������� ���� ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrunstuff unstuff')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_8) then
          sampSendChat("/me ������ �����", -1)
          wait(900) 
          sampSendChat("/do ����� � ����.", -1)
          wait(900)
          sampSendChat("/me ���� ����� � �������� ��� � ������� ����������", -1)
          wait(900) 
          sampSendChat("/do ����� ��������.", -1)
          wait(900)
          sampSendChat("���������� �����������", -1)
          wait(900) 
          sampSendChat("/me ������� ����� � ����� �������� �� ������", -1)
          wait(900)  
          sampSendChat("/me ������ ����� � �����", -1)
          wait(900) 
          sampSendChat("�������� ���� �������.", -1)
          wait(900) 
          sampSendChat("/sellmed " ..id.. " 5", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ������ ������� ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrsellmed sellmed')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
      _, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if result and isKeyJustPressed(VK_Z) then
          sampSendChat("������������, ���� ����� " ..mainIni.config.Nick.. ", � ��� ������� ����", -1)
          wait(900) 
          sampSendChat("� ������ ������ � ��� ��������� ������� ��������..", -1)
          wait(900)
          sampSendChat("..��� ����� - 2000���. ������ - 1500���.", -1)
          wait(900) 
          sampSendChat("������� - 1000���. ������ ���� - 4000���.", -1)
          wait(900)
          sampSendChat("����� ��� �������� ��� ������ �����.", -1)
          wait(900)
          sampSendChat("/b /pay " ..myID.. " �����", -1)
          wait(900) 
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�������� ����������� ����� �� ��� ���� �� ID {DC143C}[" ..id.. "]", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
      _, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if result and isKeyJustPressed(VK_NUMPAD0) then
          sampSendChat("������������, ���� ����� " ..mainIni.config.Nick.. ", � "..mainIni.config.Dol.. "���� ��������", -1)
          wait(900) 
          sampSendChat("�� ������ �� �������������?", -1)
          wait(900)
          sampSendChat("���� ��, �� �������� ��� ����� ���������: �������, ���.����� � ��������.", -1)
          wait(900) 
          sampSendChat("/b �� ��, ��������� ������� /showpass " ..myID.. " /showmc " ..myID.. " /showlic " ..myID, -1)
          wait(900)
          sampSendChat("/b ���������������� - �� ����� 5.", -1) 
          wait(900) 
          sampSendChat("/b �������� - �� ���. �����, ����������������� �� ������ 35.", -1) 
          wait(900) 
          sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ������ ������������� ��� ID {DC143C}[" ..id.. "]", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD1) then
          sampSendChat("/do �� ����� ����� �������� ����������", -1)
            wait(900)
          sampSendChat("/me ������ �������� �� 2-� ��������", -1)
            wait(900)
          sampSendChat("/do �������� �������", -1)
            wait(900)
          setVirtualKeyDown(VK_Y, true)
            wait(900)
          setVirtualKeyDown(VK_Y, false)
            wait(900)
          sampSendChat("/me ������ ������ ��������", -1)
            wait(900)
          sampSendChat("/do �������� �������", -1)
            wait(900)
          sampSendChat("/me ������ �������� ���������", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}��������� ��������� ��������!", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD3) then
          sampSendChat("������, � ����� �� ��� ���������!", -1)
          wait(900) 
          sampSendChat("/me ������ �����", -1)
          wait(900)
          sampSendChat("/do ����� � �����.", -1)
          wait(900) 
          sampSendChat("/me ����� ����� �������� �� ������", -1)
          wait(900)
          sampSendChat("��� ���� ����� �����!", -1)
          wait(900) 
          sampSendChat("/invite " ..id, -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ������� � ����������� ID {DC143C}[" ..id.. "]", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD2) then
          sampSendChat("������, ��������� � �������. ������� � ���������� �����.. � ����� ��� ���� ��������", -1)
          wait(900) 
          sampSendChat("��������������� ���� 3-�� �������.", -1)
          wait(900)
          sampSendChat("��� �� � ��� ���� � ����� ���������������?", -1)
          wait(900) 
          sampSendChat("/b ���������� �� �� ����?", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ������ ������� ID {DC143C}[" ..id.. "] {ffffff}�������� ������", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD4) then
          sampSendChat("� ��������� �� ��� �� ���������.", -1)
          wait(900) 
          sampSendChat("/b ����� ����������� ����� ����� �������� ������ �� ��� ����������, �� ���-��..", -1)
          wait(900)
          sampSendChat("/b ..�������� ����� ����: ��, �������������� ����������� ����������� ��� �����..", -1)
          wait(900) 
          sampSendChat("/b ..�� ��������� ��, ���������������� ����� 5. ��� �������� ������ ���������� �� ������ Rodina RP", -1)
          wait(900) 
          sampSendChat("��� ��� �� ��������� �������������!", -1)
        wait(900) 
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�� ��������� ������������� � ID {DC143C}[" ..id.. "] {ffffff}�������: �����", -1)
        end
    end
    local result, button, list, input = sampHasDialogRespond(10)
    if result then 
      if button == 1 then
        sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�������� ���� {DC143C}<3", -1)
      else
        sampAddChatMessage("{DC143C}[MedHelper] {ffffff}�������� ���� {DC143C}<3", -1)
      end
    end
  end
end
