script_version("1.0")

local imgui = require 'imgui'
local inicfg = require 'inicfg'
local encoding = require 'encoding'
local vkeys = require 'vkeys'
local sampev = require 'lib.samp.events'
local notify = import 'lib_imgui_notf'
local res_lfs, lfs = pcall(require, "lfs")
local dlstatus = require('moonloader').download_status -- ��������� ����������
encoding.default = 'CP1251' -- ��������� ��������� �� ���������, ��� ������ ��������� � ���������� �����. CP1251 - ��� Windows-1251
u8 = encoding.UTF8 -- � ������ �������� ��������� ��� ����������� UTF-8

local themes = import 'resource/imgui_themes.lua'

local main_window_state = imgui.ImBool(false)
local med_window = imgui.ImBool(false)
local type_window = imgui.ImBool(false)
local ustav_window = imgui.ImBool(false)
local klyatva_window = imgui.ImBool(false)
local systemrank_window = imgui.ImBool(false)
local kd_window = imgui.ImBool(false)
local drugoe_window = imgui.ImBool(false)
local cen_window = imgui.ImBool(false)
local uval = imgui.ImBool(false)
local uninvite_reason = imgui.ImBuffer(256)
local uninvite_id = imgui.ImBuffer(256)

local text_buffer = imgui.ImBuffer(256)
local sw, sh = getScreenResolution()

local directIni = "moonloader\\config\\mh.ini"
local mainIni = inicfg.load(nil, directIni)
local mainBind = inicfg.load(nil, bindPath)

local tag = '{FF6347}[MedHelper] '
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })

local checked_radio = imgui.ImInt(mainIni.config.org)
local combo_select = imgui.ImInt(mainIni.config.rank - 1)
local question = imgui.ImInt(1)
local pass = imgui.ImInt(1)
local lic = imgui.ImInt(1)
local card = imgui.ImInt(1)
local MAction = imgui.ImInt(1)
local MainAction = imgui.ImInt(1)
local giverank = imgui.ImInt(1)
local upWithRp = imgui.ImBool(mainIni.config.upWithRp)
local search_ustav = imgui.ImBuffer(256)
local search_cen = imgui.ImBuffer(256)
local bl_reason			= imgui.ImBuffer(256)
local st_window = imgui.ImBool(false)

function style_gray()
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2
  style.WindowRounding = 10.0
  style.FrameRounding = 5.0
  style.ChildWindowRounding = 5.0
  style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)


colors[clr.Text] 					= ImVec4(0.95, 0.96, 0.98, 1.00)
colors[clr.TextDisabled] 			= ImVec4(0.36, 0.42, 0.47, 1.00)
colors[clr.WindowBg] 				= ImVec4(0.11, 0.15, 0.17, 1.00)
colors[clr.ChildWindowBg] 			= ImVec4(0.15, 0.18, 0.22, 1.00)
colors[clr.PopupBg] 				= ImVec4(0.11, 0.15, 0.17, 1.00)
colors[clr.Border] 					= ImVec4(0.86, 0.86, 0.86, 1.00)
colors[clr.BorderShadow] 			= ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.FrameBg] 				= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.FrameBgHovered] 			= ImVec4(0.12, 0.20, 0.28, 1.00)
colors[clr.FrameBgActive] 			= ImVec4(0.09, 0.12, 0.14, 1.00)
colors[clr.TitleBg] 				= ImVec4(0.09, 0.12, 0.14, 0.65)
colors[clr.TitleBgCollapsed] 		= ImVec4(0.00, 0.00, 0.00, 0.51)
colors[clr.TitleBgActive] 			= ImVec4(0.08, 0.10, 0.12, 1.00)
colors[clr.MenuBarBg] 				= ImVec4(0.15, 0.18, 0.22, 1.00)
colors[clr.ScrollbarBg] 			= ImVec4(0.02, 0.02, 0.02, 0.39)
colors[clr.ScrollbarGrab] 			= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.ScrollbarGrabHovered] 	= ImVec4(0.18, 0.22, 0.25, 1.00)
colors[clr.ScrollbarGrabActive] 	= ImVec4(0.09, 0.21, 0.31, 1.00)
colors[clr.ComboBg] 				= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.CheckMark] 				= ImVec4(0.28, 0.56, 1.00, 1.00)
colors[clr.SliderGrab] 				= ImVec4(0.28, 0.56, 1.00, 1.00)
colors[clr.SliderGrabActive] 		= ImVec4(0.37, 0.61, 1.00, 1.00)
colors[clr.Button] 					= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.ButtonHovered] 			= ImVec4(0.28, 0.56, 1.00, 1.00)
colors[clr.ButtonActive]			= ImVec4(0.06, 0.53, 0.98, 1.00)
colors[clr.Header] 					= ImVec4(0.20, 0.25, 0.29, 0.55)
colors[clr.HeaderHovered] 			= ImVec4(0.26, 0.59, 0.98, 0.80)
colors[clr.HeaderActive] 			= ImVec4(0.26, 0.59, 0.98, 1.00)
colors[clr.ResizeGrip] 				= ImVec4(0.26, 0.59, 0.98, 0.25)
colors[clr.ResizeGripHovered] 		= ImVec4(0.26, 0.59, 0.98, 0.67)
colors[clr.ResizeGripActive] 		= ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.CloseButton] 			= ImVec4(0.40, 0.39, 0.38, 0.16)
colors[clr.CloseButtonHovered] 		= ImVec4(0.40, 0.39, 0.38, 0.39)
colors[clr.CloseButtonActive] 		= ImVec4(0.40, 0.39, 0.38, 1.00)
colors[clr.PlotLines] 				= ImVec4(0.61, 0.61, 0.61, 1.00)
colors[clr.PlotLinesHovered] 		= ImVec4(1.00, 0.43, 0.35, 1.00)
colors[clr.PlotHistogram] 			= ImVec4(0.90, 0.70, 0.00, 1.00)
colors[clr.PlotHistogramHovered] 	= ImVec4(1.00, 0.60, 0.00, 1.00)
colors[clr.TextSelectedBg] 			= ImVec4(0.25, 1.00, 0.00, 0.43)
colors[clr.ModalWindowDarkening] 	= ImVec4(0.00, 0.00, 0.00, 0.10)
end


local arr_str = {u8(mainIni.nameRank[1].. '(1)'), u8(mainIni.nameRank[2].. '(2)'), u8(mainIni.nameRank[3].. '(3)'), u8(mainIni.nameRank[4].. '(4)'), u8(mainIni.nameRank[5].. '(5)'), u8(mainIni.nameRank[6].. '(6)'), u8(mainIni.nameRank[7].. '(7)'), u8(mainIni.nameRank[8].. '(8)'), u8(mainIni.nameRank[9].. '(9)'), u8(mainIni.nameRank[10].. '(10)')}

function imgui.BeforeDrawFrame()
  if fa_font == nil then
      local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
      font_config.MergeMode = true
      fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
  end
end

function imgui.OnDrawFrame()
  if not main_window_state.v and not med_window.v then
    imgui.Process = false
  end 

  if main_window_state.v then
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(450, 310), imgui.Cond.FirstUseEver)
  

    imgui.Begin(u8'MedHelper', main_window_state, imgui.WindowFlags.NoResize)


    imgui.BeginChild("Mhmain", imgui.ImVec2(150, 190), true)
    imgui.CenterTextColoredRGB('{FF6347}���������� �����')
    imgui.CenterTextColoredRGB('���: ' ..mainIni.config.name)
    imgui.CenterTextColoredRGB('{FF6347}���������:')
    imgui.CenterTextColoredRGB(mainIni.nameRank[mainIni.config.rank])
    imgui.NewLine()
    imgui.CenterTextColoredRGB('��������: ' ..mainIni.stat.heal)
    imgui.CenterTextColoredRGB('������ ���.����: ' ..mainIni.stat.medc)
    imgui.CenterTextColoredRGB('������ ��������: ' ..mainIni.stat.rec)
    imgui.CenterTextColoredRGB('������ �������: ' ..mainIni.stat.aptech)
    imgui.CenterTextColoredRGB('����� ����: ' ..mainIni.stat.utatu)
    imgui.EndChild()
    imgui.SameLine()
   if MainAction.v == 2 then
    imgui.BeginChild("Mhchange", imgui.ImVec2(-1, 185), false)
    imgui.Text(u8'������� ���� ���')
    if imgui.InputText(u8'##1', text_buffer) then -- ������� ����� ����������� ��� ��������� ������
    end
    if imgui.Button(u8'���������', imgui.ImVec2(100, 20)) then
      mainIni.config.name = u8:decode(text_buffer.v)
      if inicfg.save(mainIni, directIni) then
         sampAddChatMessage(tag.. '{FFFFFF}����� ���: {DC143C}' ..mainIni.config.name, -1)
      end
    end
    imgui.Text(u8' ')
    imgui.Text(u8'�������� ���� ���������')
    if imgui.Combo(u8'##2', combo_select, arr_str, #arr_str) then
      mainIni.config.rank = combo_select.v + 1
      if inicfg.save(mainIni, directIni) then
          sampAddChatMessage(tag.. '{FFFFFF}���������, ����� ���������: {DC143C}' ..mainIni.nameRank[mainIni.config.rank], -1)
      end
    end
  
    imgui.Text(u8'�������� ���� �����������')
    if imgui.RadioButton(u8'���', checked_radio, 1) then
      mainIni.config.org = 1
      mainIni.nameRank[1] = '������'
      mainIni.nameRank[2] = '���.��������'
      mainIni.nameRank[3] = '��������'
      mainIni.nameRank[4] = '��������'
      mainIni.nameRank[5] = '�����������'
      mainIni.nameRank[6] = '������'
      mainIni.nameRank[7] = '���������'
      mainIni.nameRank[8] = '���.����������'
      mainIni.nameRank[9] = '���.����.�����'
      mainIni.nameRank[10] = '����.����'
      if inicfg.save(mainIni, directIni) then
          sampAddChatMessage(tag.. '{FFFFFF}���������, ����� �����������: {DC143C}' ..mainIni.nameOrg[mainIni.config.org].. '{FFFFFF} ������������� ��� ��������� �������� ������', -1)
      end
    end
    imgui.SameLine()
    if imgui.RadioButton(u8'��-�', checked_radio, 2) then
      mainIni.config.org = 2
      mainIni.nameRank[1] = '������'
      mainIni.nameRank[2] = '���������� ����'
      mainIni.nameRank[3] = '��������'
      mainIni.nameRank[4] = '��������'
      mainIni.nameRank[5] = '�������'
      mainIni.nameRank[6] = '������'
      mainIni.nameRank[7] = '��������'
      mainIni.nameRank[8] = '���.����������'
      mainIni.nameRank[9] = '���.����.�����'
      mainIni.nameRank[10] = '����.����'
      if inicfg.save(mainIni, directIni) then
        sampAddChatMessage(tag.. '{FFFFFF}���������, ����� �����������: {DC143C}' ..mainIni.nameOrg[mainIni.config.org].. '{FFFFFF} ������������� ��� ��������� �������� ������', -1)
      end
    end
    imgui.EndChild()
   end
   if MainAction.v == 1 then
    imgui.BeginChild("Chmain", imgui.ImVec2(-1, 200), false)
      if imgui.Button(u8('�����'), imgui.ImVec2(-1, 30)) then
        ustav_window.v = true
      end
      if imgui.Button(u8('������ ���������'), imgui.ImVec2(-1, 30)) then
        klyatva_window.v = true
      end
      if imgui.Button(u8('������� ���������'), imgui.ImVec2(-1, 30)) then
        systemrank_window.v = true
      end
      if imgui.Button(u8('�/� ����� �����������'), imgui.ImVec2(-1, 30)) then
        kd_window.v = true
      end
      if imgui.Button(u8('������� ������'), imgui.ImVec2(-1, 30)) then
        st_window.v = true
      end
      if imgui.Button(u8('������� ��������'), imgui.ImVec2(-1, 30)) then
        cen_window.v = true
      end
    imgui.EndChild()
   end
    if MainAction.v == 3 then
    imgui.BeginChild("ChLections", imgui.ImVec2(-1, 185), false)
        	imgui.CenterTextColoredRGB('���� ���������� ������ ����������� {868686}(?)')
        	imgui.HintHovered(u8'�� ������ ��������� ���� ������!\n��� ����� � ����� moonloader/MH/Lec\n�������� ��������� ���� � �������� ���� ������ ������')
        	imgui.NewLine()
        if doesDirectoryExist("moonloader/MH/Lec") then
				  for line in lfs.dir(getWorkingDirectory().."\\MH\\Lec") do
				  	if line == nil then
				  	elseif line:match(".+%.txt") then
				  		if imgui.Button(u8(line:match("(.+)%.txt")), imgui.ImVec2(-1, 30)) then
							  lua_thread.create(function()
								    local lection_text = io.open("moonloader/MH/Lec/"..line:match("(.+)%.txt")..".txt", "r+")
								    for line in lection_text:lines() do
									    sampSendChat(line)
									    wait(1500)
								    end
								    lection_text:close()
								    sampAddChatMessage(tag.. '{FFFFFF}��������������� ������ ��������!', -1)
							  end)
						  end
            end
          end
			  else
				   imgui.NewLine(); imgui.NewLine()
				   imgui.CenterTextColoredRGB('� ��� ����������� ����� � ��������\n�� �� ������ ������� �������������\n��� ����� ������� "������� ������"')
				   imgui.NewLine()
				   imgui.SetCursorPosX((imgui.GetWindowWidth() - 130) / 2)
				    if imgui.Button(u8('������� ������ '), imgui.ImVec2(130, 30)) then
					   downloadLections()
				    end
        end
    imgui.EndChild()
    end
     imgui.SetCursorPos(imgui.ImVec2(10, 225))
     imgui.RadioButton(u8("INFO"), MainAction, 1)
     imgui.SetCursorPos(imgui.ImVec2(10, 255))
     imgui.RadioButton(u8("���������"), MainAction, 2)
     imgui.SetCursorPos(imgui.ImVec2(10, 285))
     imgui.RadioButton(u8("������"), MainAction, 3)
     imgui.SameLine()
     imgui.SetCursorPosX(235)
     imgui.SetCursorPosY(250)
     if imgui.Button(u8('���� ����������'), imgui.ImVec2(130, 30)) then
      uval.v = true
     end
    imgui.End()
  end
  if ustav_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(xx / 1.5, yy / 1.5), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8'����� ������������ ���������������', ustav_window, imgui.WindowFlags.NoCollapse)
       imgui.PushItemWidth(200)
       imgui.PushAllowKeyboardFocus(false)
       imgui.InputText("##search_ustav", search_ustav, imgui.InputTextFlags.EnterReturnsTrue)
       imgui.PopAllowKeyboardFocus()
       imgui.PopItemWidth()
      if not imgui.IsItemActive() and #search_ustav.v == 0 then
       imgui.SameLine(15)
       imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
       imgui.Text(u8'����� �� ������')
       imgui.PopStyleColor()
      end
			local ustav = io.open("moonloader/MH/INFO/�����_��.txt", "r+")
      for line in ustav:lines() do
        if #search_ustav.v < 1 then
          imgui.TextColoredRGB(u8:decode(line))
				elseif string.rlower(line):find(string.rlower(u8:decode(search_ustav.v))) then
					imgui.TextColoredRGB(u8:decode(line))
				end
      end
			ustav:close()

		imgui.End()
  end
  if klyatva_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'������ ����������', klyatva_window)
			local klyatva = io.open("moonloader/MH/INFO/������_����������.txt", "r+")
			for line in klyatva:lines() do
        imgui.TextColoredRGB(u8:decode(line))
      end
			klyatva:close()

		imgui.End()
  end
  if systemrank_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(xx / 1.5, yy / 1.5), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'������� ��������� ������������ ���������������', systemrank_window, imgui.WindowFlags.NoCollapse)
     if checked_radio.v == 1 then
			local systemrank = io.open("moonloader/MH/INFO/�������_���������.txt", "r+")
			for line in systemrank:lines() do
        imgui.TextColoredRGB(u8:decode(line))
      end
      systemrank:close()
     end
     if checked_radio.v == 2 then
			local systemrank = io.open("moonloader/MH/INFO/�������_���������_��-�.txt", "r+")
			for line in systemrank:lines() do
        imgui.TextColoredRGB(u8:decode(line))
      end
      systemrank:close()
     end
		imgui.End()
  end
  if kd_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    if checked_radio.v == 1 then
        imgui.Begin(u8'�/� ����� ����������� ��', kd_window, imgui.WindowFlags.NoCollapse)
			local kd = io.open("moonloader/MH/INFO/��_�����_�����������.txt", "r+")
			for line in kd:lines() do
        imgui.CenterTextColoredRGB(u8:decode(line))
      end
			kd:close()
    end
    if checked_radio.v == 2 then
      imgui.Begin(u8'�/� ����� ����������� ��', kd_window, imgui.WindowFlags.NoCollapse)
      local kd = io.open("moonloader/MH/INFO/��_�����_�����������_��-�.txt", "r+")
      for line in kd:lines() do
        imgui.CenterTextColoredRGB(u8:decode(line))
      end
      kd:close()
    end
		imgui.End()
  end
  if cen_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8'������� �������� ������������ ���������������', cen_window, imgui.WindowFlags.NoCollapse)
       imgui.PushItemWidth(200)
       imgui.PushAllowKeyboardFocus(false)
       imgui.InputText("##search_cen", search_cen, imgui.InputTextFlags.EnterReturnsTrue)
       imgui.PopAllowKeyboardFocus()
       imgui.PopItemWidth()
      if not imgui.IsItemActive() and #search_ustav.v == 0 then
       imgui.SameLine(15)
       imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
       imgui.Text(u8'����� �� �������� ���')
       imgui.PopStyleColor()
      end
			local cen = io.open("moonloader/MH/INFO/�������_��������.txt", "r+")
      for line in cen:lines() do
        if #search_cen.v < 1 then
          imgui.TextColoredRGB(u8:decode(line))
				elseif string.rlower(line):find(string.rlower(u8:decode(search_cen.v))) then
					imgui.TextColoredRGB(u8:decode(line))
				end
      end
			cen:close()
    imgui.End()
  end
  if st_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
     imgui.Begin(u8'����������� ������������ ���������������', st_window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
     if checked_radio.v == 1 then
     imgui.CenterTextColoredRGB('����������� �������� �������(���) {868686}(?)')
     imgui.HintHovered(u8'��������:\n��: ����� �������\n���: ���� ����������\n��������: ��� �������\n��������: ���� ��������')
     imgui.CenterTextColoredRGB('{FF6347}����.����')
     imgui.CenterTextColoredRGB('������� ������ | ���� (22.09.2020)')
     imgui.CenterTextColoredRGB('{FF6347}���.����.����')
     imgui.CenterTextColoredRGB('����')
     imgui.CenterTextColoredRGB('{FF6347}���.����.����')
     imgui.CenterTextColoredRGB('����')
     imgui.CenterTextColoredRGB('{FF6347}���.����.����')
     imgui.CenterTextColoredRGB('����')
     end
     if checked_radio.v == 2 then
     imgui.CenterTextColoredRGB('����������� �������� �����(��-�) {868686}(?)')
     imgui.HintHovered(u8'��������:\n��: ����� �������\n���: ���� ����������\n��������: ��� �������\n��������: ���� ��������')
     imgui.CenterTextColoredRGB('{FF6347}����.����')
     imgui.CenterTextColoredRGB('���� | ���� ( .. -  ..)')
     imgui.CenterTextColoredRGB('{FF6347}���.����.����')
     imgui.CenterTextColoredRGB('����')
     imgui.CenterTextColoredRGB('{FF6347}���.����.����')
     imgui.CenterTextColoredRGB('����')
     imgui.CenterTextColoredRGB('{FF6347}���.����.����')
     imgui.CenterTextColoredRGB('����')
     end
     imgui.End()
  end

  if med_window.v then 

    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(500, 290), imgui.Cond.FirstUseEver)
    imgui.Begin(u8'MedHelperH', med_window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)

    imgui.BeginChild("ChInfo", imgui.ImVec2(150, 170), true)
      if sampIsPlayerConnected(actionId) then
       imgui.CenterTextColoredRGB('{FF6347}��� ������')
       imgui.CenterTextColoredRGB(sampGetPlayerNickname(actionId)..' ['..actionId..']')
       imgui.NewLine()
       imgui.CenterTextColoredRGB('{FF6347}�����')
       imgui.CenterTextColoredRGB(string.format(os.date("%H",os.time())..':'..os.date("%M",os.time())))
       imgui.NewLine()
       imgui.CenterTextColoredRGB('{FF6347}��������� � ������')
        if MAction.v ~= 2 then 
          imgui.CenterTextColoredRGB(tostring(sampGetPlayerScore(actionId))..' ���')
        else
          if sampGetPlayerScore(actionId) > 2 then
           imgui.CenterTextColoredRGB(tostring(sampGetPlayerScore(actionId))..' ��� | ��������')
          else
           imgui.CenterTextColoredRGB(tostring(sampGetPlayerScore(actionId))..' ��� | {FF0000}�� ��������')
          end
      end
    imgui.EndChild()
    imgui.SameLine()
    if MAction.v == 1 then
      imgui.BeginChild("Chheal", imgui.ImVec2(-1, 278), false)
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
      imgui.SetCursorPosY(5)
       if imgui.Button(u8'�������� ������������ ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("������������, ���� ����� " ..mainIni.config.name.. ", � ��� ������� ����", -1)
            wait(900)
           sampSendChat("/do �� ����� �������, �� �� ��������: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
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
            sampSendChat("/heal " ..actionId.. ' 1000', -1)
            function sampev.onServerMessage(color, text)
              if text:find('�� ��������� �����������') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', '�� ��������� ������ �� ������� ID {DC143C}[' ..actionId.. ']\n�� ��� ��������: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('�� �� ������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� ������!', 2, 2, 6)
              end
              if text:find('����� ������ ��������� �� ������ ���� �� ���������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� �� ���������!', 2, 2, 6)
              end
              if text:find('�������� ����������� ����� � ����� ��������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}� ��� ��� ������������!', 2, 2, 6)
              end
              if text:find('�� ������ �� ������') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ������ �� ������!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}�� ������ ���������� � ��������, ��������� ��� ������ ��C!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ���������� � �������� ��� � ������!', 2, 2, 6)
              end
            end
          end)
        else
            notify.addNotify('{DC143C}[MedHelper]', '�������� ������ �� 2 �����', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'�������� �������� ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("������������, ���� ����� " ..mainIni.config.name.. ", � ��� ������� ����", -1)
            wait(900)
           sampSendChat("/do �� ����� �������, �� �� ��������: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
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
            sampSendChat("/heal " ..actionId.. ' 1000', -1)
            function sampev.onServerMessage(color, text)
              if text:find('�� ��������� �����������') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', '�� ��������� ������ �� ������� ID {DC143C}[' ..actionId.. ']\n�� ��� ��������: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('�� �� ������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� ������!', 2, 2, 6)
              end
              if text:find('����� ������ ��������� �� ������ ���� �� ���������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� �� ���������!', 2, 2, 6)
              end
              if text:find('�������� ����������� ����� � ����� ��������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}� ��� ��� ������������!', 2, 2, 6)
              end
              if text:find('�� ������ �� ������') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ������ �� ������!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}�� ������ ���������� � ��������, ��������� ��� ������ ��C!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ���������� � �������� ��� � ������!', 2, 2, 6)
              end
            end
          end)
        else
            notify.addNotify('{DC143C}[MedHelper]', '�������� ������ �� 2 �����', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'�������� ���������� ��� ���-�� � �� ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("������������, ���� ����� " ..mainIni.config.name.. ", � ��� ������� ����", -1)
            wait(900)
           sampSendChat("/do �� ����� �������, �� �� ��������: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
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
            sampSendChat("/heal " ..actionId.. ' 250', -1)
            function sampev.onServerMessage(color, text)
              if text:find('�� ��������� �����������') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', '�� ��������� ������ �� ������� ID {DC143C}[' ..actionId.. ']\n�� ��� ��������: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('�� �� ������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� ������!', 2, 2, 6)
              end
              if text:find('����� ������ ��������� �� ������ ���� �� ���������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� �� ���������!', 2, 2, 6)
              end
              if text:find('�������� ����������� ����� � ����� ��������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}� ��� ��� ������������!', 2, 2, 6)
              end
              if text:find('�� ������ �� ������') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ������ �� ������!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}�� ������ ���������� � ��������, ��������� ��� ������ ��C!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ���������� � �������� ��� � ������!', 2, 2, 6)
              end
            end
          end)
        else
            notify.addNotify('{DC143C}[MedHelper]', '�������� ������ �� 2 �����', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'�������� ���������� ���, ��, ��-�, ���� ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("������������, ���� ����� " ..mainIni.config.name.. ", � ��� ������� ����", -1)
            wait(900)
           sampSendChat("/do �� ����� �������, �� �� ��������: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
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
            sampSendChat("/heal " ..actionId.. ' 500', -1)
            function sampev.onServerMessage(color, text)
              if text:find('�� ��������� �����������') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', '�� ��������� ������ �� ������� ID {DC143C}[' ..actionId.. ']\n�� ��� ��������: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('�� �� ������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� ������!', 2, 2, 6)
              end
              if text:find('����� ������ ��������� �� ������ ���� �� ���������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� �� �� ���������!', 2, 2, 6)
              end
              if text:find('�������� ����������� ����� � ����� ��������!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}� ��� ��� ������������!', 2, 2, 6)
              end
              if text:find('�� ������ �� ������') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ������ �� ������!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}�� ������ ���������� � ��������, ��������� ��� ������ ��C!') then 
               notify.addNotify('{DC143C}[������]', '�� �� ������ �������� ID {DC143C}[' ..actionId.. ']\n{DC143C}�� ���������� � �������� ��� � ������!', 2, 2, 6)
              end
            end
          end)
        else
          notify.addNotify('{DC143C}[MedHelper]', '�������� ������ �� 2 �����', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX(14)
       if imgui.Button(u8'������ ���.����� ' ..fa.ICON_ID_CARD_O, imgui.ImVec2(257, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 2 then
          lua_thread.create(function()
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
           sampSendChat("/medcard " ..actionId.. " 3", -1)
           mainIni.stat.medc = mainIni.stat.medc + 1
           notify.addNotify('{DC143C}[MedHelper]', '�� ������ ���.����� ������ � ID {DC143C}[' ..actionId.. ']\n������ ���: {DC143C}' ..mainIni.stat.medc.. '', 2, 2, 6)
           wait(900)
           sampSendChat("/time")
           wait(900)
           setVirtualKeyDown(VK_F8, true)
            wait(100)
           setVirtualKeyDown(VK_F8, false)
          end)
        else
           notify.addNotify('{DC143C}[MedHelper]', '�������� ������ � 3 �����', 2, 2, 3)
        end
       end
       imgui.SameLine()
       if imgui.Button('' ..fa.ICON_RUB, imgui.ImVec2(35, 30)) then 
        med_window.v = false
         lua_thread.create(function()
          sampSendChat("������������, ���� ����� " ..mainIni.config.name.. ", � ��� ������� ����", -1)
          wait(900) 
          sampSendChat("� ������ ������ � ��� ��������� ������� ��������..", -1)
          wait(900)
          sampSendChat("..��� ����� - " ..mainIni.config.mcard.. " ������ - " ..mainIni.config.recept, -1)
          wait(900) 
          sampSendChat("������� - " ..mainIni.config.apte.. " ������ ���� - " ..mainIni.config.tatu, -1)
          wait(900)
          sampSendChat("����� ��� �������� ��� ������ �����.", -1)
          wait(900)
          sampSendChat("/b /pay " ..myID.. " �����", -1)
          wait(900) 
          notify.addNotify('{DC143C}[MedHelper]', '�������� ������ �� ������ � ID {DC143C}[' ..id.. ']', 2, 2, 6)
         end)
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'�������� ������ ' ..fa.ICON_PENCIL_SQUARE_O, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 3 then
          lua_thread.create(function()
            sampSendChat("������, �� �������� ������ �����, ������ � ����� ��� �������", -1)
            wait(900) 
            sampSendChat("/do � ���.����� ����� ������ �������", -1)
            wait(900)
            sampSendChat("/me �������� ������, ����� ��� ����������", -1)
            wait(900) 
            sampSendChat("��� ���� �������.", -1)
            wait(900)  
            sampSendChat("/recept " ..actionId, -1)
            mainIni.stat.rec = mainIni.stat.rec + 1
            notify.addNotify('{DC143C}[MedHelper]', '�� ������ ������ ������ � ID {DC143C}[' ..actionId.. ']\n������ ���: {DC143C}' ..mainIni.stat.rec.. '', 2, 2, 6)
            wait(900)
            sampSendChat("/time")
            wait(900)
            setVirtualKeyDown(VK_F8, true)
             wait(100)
           setVirtualKeyDown(VK_F8, false)
          end)
        else
          notify.addNotify('{DC143C}[MedHelper]', '�������� ������ � 4 �����', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'������ ������� ' ..fa.ICON_MEDKIT, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 5 then
          lua_thread.create(function()
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
           sampSendChat("/sellmed " ..actionId.. " 5", -1)
           mainIni.stat.aptech = mainIni.stat.aptech + 5
           notify.addNotify('{DC143C}[MedHelper]', '�� ������ ������� ������ � ID {DC143C}[' ..actionId.. ']\n������ ���: {DC143C}' ..mainIni.stat.aptech.. '', 2, 2, 6)
           wait(900)
           sampSendChat("/time")
           wait(900)
           setVirtualKeyDown(VK_F8, true)
            wait(100)
           setVirtualKeyDown(VK_F8, false)
          end)
        else
           notify.addNotify('{DC143C}[MedHelper]', '�������� ������ � 6 �����', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'����� ���� ' ..fa.ICON_USER_MD, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 5 then
          lua_thread.create(function()
             sampSendChat("/do ������� ��� ������� ���� �� �����.", -1)
              wait(900) 
              sampSendChat("/me ���� ������� ��� ���������� ����.", -1)
              wait(900)
              sampSendChat("/do ������� � ������ ����.", -1)
              wait(900) 
              sampSendChat("/me ����� �������� ����.", -1)
              wait(900)
              sampSendChat("���, ��� ����� �������. ����� ��� �������.", -1)
              wait(900) 
              sampSendChat("/unstuff " ..actionId.. " 4000", -1)
              mainIni.stat.utatu = mainIni.stat.utatu + 1
             notify.addNotify('{DC143C}[MedHelper]', '�� ����� ���� ������ � ID {DC143C}[' ..actionId.. ']\n����� ���: {DC143C}' ..mainIni.stat.utatu.. ' {DC143C}����', 2, 2, 6)
             wait(900)
             sampSendChat("/time")
             wait(900)
             setVirtualKeyDown(VK_F8, true)
               wait(100)
             setVirtualKeyDown(VK_F8, false)
          end)
        else
          notify.addNotify('{DC143C}[MedHelper]', '�������� ������ � 6 �����', 2, 2, 3)
        end
       end
      imgui.EndChild()
    end
    if MAction.v == 2 then
    imgui.BeginChild("Chheal", imgui.ImVec2(-1, 280), false)
      imgui.CenterTextColoredRGB('{FF6347}������������ ��������:')
      imgui.CenterTextColoredRGB('� 3 ���� ���������� � ������ (3+ ���)')
      imgui.CenterTextColoredRGB('� 35 � ����� �����������������')
      imgui.CenterTextColoredRGB('� ��������� ����. ����������')
      imgui.CenterTextColoredRGB('� ��������� ���������������� {868686}(?)')
      if imgui.IsItemHovered() then
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(u8'����������� �� 5 ��.')
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()       
                end
      imgui.CenterTextColoredRGB('� ���������� ��������� � ������ ��')
      imgui.NewLine()
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
      if imgui.Button(u8('�����������'), imgui.ImVec2(300, 30)) then
        lua_thread.create(function()
                    sampSendChat("������������, � "..mainIni.config.nameRank[mainIni.config.rank].." - " ..mainIni.config.name)
                    wait(2500)
                    sampSendChat("�� �� �������������?")
                  end)
      end
      if pass.v == 1 then
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 315 + imgui.GetStyle().ItemSpacing.x) / 2)
        if imgui.Button(u8('�������'), imgui.ImVec2(100, 30)) then
        lua_thread.create(function()
          sampSendChat("������, �������������� � �������� ��� ��� �������!")
                  end)
                  pass.v = 2
        end
      end
      if pass.v == 2 then
        if imgui.Button(u8('�����'), imgui.ImVec2(100, 30)) then
        lua_thread.create(function()
          sampSendChat("/do �� ����� ����� �������")
            wait(900)
            sampSendChat("/me ������ �������, �������� ��� �� ��������")
            wait(900)
            sampSendChat("/me �������� �������, ������ ���")
            wait(900)
            sampSendChat("/do ������� ����� �� �����")    
                  end)
                  pass.v = 1
        end
      end
      imgui.SameLine()
      if card.v == 1 then
        if imgui.Button(u8('���.�����'), imgui.ImVec2(100, 30)) then
        lua_thread.create(function()
          sampSendChat("���, ������� � �������, ������ �������� ��� ���� ���.�����")
                  end)
                  card.v = 2
        end
      end
      if card.v == 2 then
        if imgui.Button(u8('�����'), imgui.ImVec2(90, 30)) then
        lua_thread.create(function()
          sampSendChat("/do �� ����� ����� ���.�����")
            wait(900)
            sampSendChat("/me ������ ���.�����, �������� ������� �����������")
            wait(900)
            sampSendChat("/me �������� ���.�����, ������ �")
            wait(900)
            sampSendChat("/do ���.����� ����� �� �����")   
                  end)
                  card.v = 1
        end
      end
      imgui.SameLine()
      if lic.v == 1 then
        if imgui.Button(u8('��������'), imgui.ImVec2(90, 30)) then
        lua_thread.create(function()
          sampSendChat("��.. �������, ��������-�� ��� ���� ��������") 
                  end)
                  lic.v = 2
        end
      end
      if lic.v == 2 then
        if imgui.Button(u8('�����'), imgui.ImVec2(90, 30)) then
        lua_thread.create(function()
          sampSendChat("/do �� ����� ����� ����� � ����������")
          wait(900)
          sampSendChat("/me ������ �����, �������� ������� �������� �� ��������")
          wait(900)
          sampSendChat("/me �������� �����, ������ �")
          wait(900)
          sampSendChat("/do ����� ����� �� �����")    
                  end)
                  lic.v = 1
        end
      end
      if question.v == 1 then 
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
        if imgui.Button(u8('������ ������ �1'), imgui.ImVec2(300, 30)) then
          lua_thread.create(function()
                  sampSendChat("� ����������� �� � �������, ������ � ����� ��� ���� ��������")
                   wait(900)
                   sampSendChat("������ �� �� ������������ ���� ����� ����� �� �������� '�������'")
                    question.v = 2
          end)
        end
      end
      if question.v == 2 then 
        if imgui.Button(u8('������ ������ �2'), imgui.ImVec2(300, 30)) then
                  sampSendChat("��� ����� ���������� �������� � ����� �����������?")
                    question.v = 3
        end
      end
      if question.v == 3 then 
        if imgui.Button(u8('������ ������ �3'), imgui.ImVec2(300, 30)) then
          lua_thread.create(function()
                    sampSendChat("�� ����� ��������� ���������� ����� � ���?")
                    wait(500)
                    sampAddChatMessage(tag..'������� ���������! ����� ��������� �����!', -1)
                      question.v = 1
                  end)
        end
      end
      imgui.NewLine()
      greenbtn()
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 150 + imgui.GetStyle().ItemSpacing.x) / 2)
      if imgui.Button(u8('�������'), imgui.ImVec2(75, 30)) then
        med_window.v = false
        lua_thread.create(function()
                    sampSendChat("����������! �� ��� ���������")
                    wait(900)
                    sampSendChat("/do ��� ������ ����� ������ � ����� ������")
                      wait(900)
                      sampSendChat("/me ���� ���� �� �������, ������� ��� ������ ����������")
                        wait(900)
                        sampSendChat("������� �� ������� ����� � ������ ������, �������� ������!")
                  end)
      end
      endbtn()
      imgui.SameLine()
      redbtn()
      if imgui.Button(u8('��������'), imgui.ImVec2(75, 30)) then
        med_window.v = false
        lua_thread.create(function()
                    sampSendChat("� ���������, �� ��� �� ���������")
                    wait(900)
                    sampSendChat("/b ������ ����� ���� ���������..")
                    wait(900)
                    sampSendChat("/b ����� ��������� �� ��� - �����, �� ��������� �� ���������..")
                    wait(900)
                    sampSendChat("��������� �� ��������� �������������!")
                  end)
      end
      endbtn()
    imgui.EndChild()
    end
    if MAction.v == 3 then
    imgui.BeginChild("Chgiverank", imgui.ImVec2(-1, 280), false)
      
      imgui.NewLine()
      imgui.SetCursorPosX(51)
      imgui.TextDisabled('1'); imgui.SameLine(78)
      imgui.TextDisabled('2'); imgui.SameLine(105)
      imgui.TextDisabled('3'); imgui.SameLine(132)
      imgui.TextDisabled('4'); imgui.SameLine(159)
      imgui.TextDisabled('5'); imgui.SameLine(186)
      imgui.TextDisabled('6'); imgui.SameLine(213)
      imgui.TextDisabled('7'); imgui.SameLine(240)
      imgui.TextDisabled('8'); imgui.SameLine(267)
      imgui.TextDisabled('9')

      imgui.SetCursorPosX(45)
      imgui.RadioButton(u8("##giverank1"), giverank, 1); imgui.HintHovered(u8(mainIni.nameRank[1])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank2"), giverank, 2); imgui.HintHovered(u8(mainIni.nameRank[2])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank3"), giverank, 3); imgui.HintHovered(u8(mainIni.nameRank[3])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank4"), giverank, 4); imgui.HintHovered(u8(mainIni.nameRank[4])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank5"), giverank, 5); imgui.HintHovered(u8(mainIni.nameRank[5])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank6"), giverank, 6); imgui.HintHovered(u8(mainIni.nameRank[6])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank7"), giverank, 7); imgui.HintHovered(u8(mainIni.nameRank[7])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank8"), giverank, 8); imgui.HintHovered(u8(mainIni.nameRank[8])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank9"), giverank, 9); imgui.HintHovered(u8(mainIni.nameRank[9]));
      imgui.NewLine()
      imgui.SetCursorPosX(110)
      if imgui.Checkbox(u8'� �� ����������', upWithRp) then 
        mainIni.config.upWithRp = upWithRp.v
        if inicfg.save(mainIni, directIni) then
          sampAddChatMessage(tag.. '{FFFFFF}���������', -1)
        end
      end
      imgui.NewLine()
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 295 + imgui.GetStyle().ItemSpacing.x) / 2)
      if imgui.Button(u8('��������'), imgui.ImVec2(140, 30)) then
        med_window.v = false
    if upWithRp.v then 
      lua_thread.create(function()
        sampSendChat('/do � ����� �������')
          wait(900)
        sampSendChat('/me �������� ����� ������ ��, ����� ����������')
          wait(900)
        sampSendChat('/me ������ ����������, ������� ��� � ���������')
          wait(900)
        sampSendChat('/do ����� ��������� ���������� - ' ..mainIni.config.nameRank[giverank.v])
          wait(900)
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
        if mainIni.config.rank > 8 then
          if not doesDirectoryExist(getWorkingDirectory()..'/MH/���������') then 
              if createDirectory(getWorkingDirectory()..'/MH/���������') then 
                sampfuncsLog('Bank-Helper: ������� ����������� /BHelper/���������')
              end
            end
            log_giverank = io.open(getWorkingDirectory()..'/MH/���������/���������.txt', "a")
          log_giverank:write(sampGetPlayerNickname(actionId).." | "..tostring(giverank.v - 1).." -> "..tostring(giverank.v).." | "..os.date("%d.%m.%Y").." | "..os.date("%H:%M:%S", os.time()).." | "..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))).."\n")
          log_giverank:close()
        end
      end)
    else
      lua_thread.create(function()
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
        if mainIni.config.rank > 8 then
          if not doesDirectoryExist(getWorkingDirectory()..'/MH/���������') then 
              if createDirectory(getWorkingDirectory()..'/MH/���������') then 
                sampfuncsLog('Bank-Helper: ������� ����������� /BHelper/���������')
              end
            end
            log_giverank = io.open(getWorkingDirectory()..'/MH/���������/���������.txt', "a")
          log_giverank:write(sampGetPlayerNickname(actionId).." | "..tostring(giverank.v - 1).." -> "..tostring(giverank.v).." | "..os.date("%d.%m.%Y").." | "..os.date("%H:%M:%S", os.time()).." | "..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))).."\n")
          log_giverank:close()
        end
      end)
    end
  end
  imgui.SameLine()
  if imgui.Button(u8('��������'), imgui.ImVec2(140, 30)) then
    med_window.v = false
    if upWithRp.v then 
      lua_thread.create(function()
        sampSendChat('/do � ����� �������')
          wait(900)
        sampSendChat('/me �������� ����� ������ ��, ����� ����������')
          wait(900)
        sampSendChat('/me ������ ����������, ������� ��� � ���������')
          wait(900)
        sampSendChat('/do ����� ��������� ���������� - ' ..mainIni.config.nameRank[giverank.v])
          wait(900)
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
      end)
    else
      lua_thread.create(function()
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
      end)
    end
  end
  imgui.NewLine()
  imgui.CenterTextColoredRGB('��������!')
  imgui.CenterTextColoredRGB('����� ��������� ���������� �� 5-� ����\n ��� ����� �������� ����-���� �� ������')

    imgui.EndChild()
    end
      imgui.SetCursorPos(imgui.ImVec2(10, 200))
    if mainIni.config.rank > 1 then
      imgui.RadioButton(u8("���.������"), MAction, 1)
    else
      imgui.RadioButton(u8"���.������ " ..fa.ICON_LOCK, false)
      imgui.HintHovered(u8'�������� � 2+ �����')
    end
      imgui.SetCursorPos(imgui.ImVec2(10, 230))
    if mainIni.config.rank > 4 then
      imgui.RadioButton(u8("C�����������e"), MAction, 2)
    else
      imgui.RadioButton(u8"C�����������e " ..fa.ICON_LOCK, false)
      imgui.HintHovered(u8'�������� � 5+ �����')
    end
      imgui.SetCursorPos(imgui.ImVec2(10, 260))
    if mainIni.config.rank > 8 then
      imgui.RadioButton(u8("���������"), MAction, 3)
    else
      imgui.RadioButton(u8"��������� " ..fa.ICON_LOCK, false)
      imgui.HintHovered(u8'�������� � 9+ �����')
    end
        end
    imgui.End()
  end
  if uval.v then
    imgui.SetNextWindowSize(imgui.ImVec2(335, 205), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'���� ����������', uval, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)

		imgui.CenterTextColoredRGB('������� ID{SSSSSS} ������ � �������{SSSSSS} ����������')
		imgui.NewLine()
		imgui.SetCursorPosY(65)
		imgui.PushItemWidth(120)
		imgui.InputText(u8"##uninvite_id", uninvite_id, imgui.InputTextFlags.CharsDecimal)
		imgui.PopItemWidth()
		if not imgui.IsItemActive() and #uninvite_id.v == 0 then
			imgui.SameLine(15)
			imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
			imgui.Text(u8'ID')
			imgui.PopStyleColor()
		end
		imgui.PushItemWidth(120)
		imgui.InputText(u8"##uninvite_reason", uninvite_reason)
		imgui.PopItemWidth()
		if not imgui.IsItemActive() and #uninvite_reason.v == 0 then
			imgui.SameLine(15)
			imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
			imgui.Text(u8'�������')
			imgui.PopStyleColor()
		end
		imgui.PushItemWidth(120)
		imgui.InputText(u8"##bl_reason", bl_reason)
		imgui.HintHovered(u8'�������� ������\n���� ��� ��')
		imgui.PopItemWidth()
		if not imgui.IsItemActive() and #bl_reason.v == 0 then
			imgui.SameLine(15)
			imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
			imgui.Text(u8'������� ��')
			imgui.PopStyleColor()
		end 
		imgui.SetCursorPos(imgui.ImVec2(140, 65))
		imgui.BeginChild("##UvalInfo", imgui.ImVec2(-1, 68), true, imgui.WindowFlags.NoScrollbar)
		if #uninvite_id.v > 0 then
			if sampIsPlayerConnected(tonumber(uninvite_id.v)) then
				name_uval = '{SSSSSS}'..sampGetPlayerNickname(tonumber(uninvite_id.v))
			else
				name_uval = '{FF0000}��� �� �������!'
			end
		else
			name_uval = '{565656}�������� ID'
		end
		imgui.CenterTextColoredRGB('���: '..name_uval)
		if #uninvite_reason.v == 0 then
			uval_res = '{565656}�� �������' 
		else 
			if #bl_reason.v == 0 then
				uval_res = u8:decode(uninvite_reason.v) 
			else
				uval_res = u8:decode(uninvite_reason.v)..' + ��'
			end
		end
		imgui.CenterTextColoredRGB('�������: {SSSSSS}'..uval_res)
		if #bl_reason.v == 0 then
			chs_res = '{565656}��� ��' 
		else 
			chs_res = '{SSSSSS}'..u8:decode(bl_reason.v)
		end
		imgui.CenterTextColoredRGB('������� ��: '..chs_res)

		imgui.EndChild()
		imgui.NewLine()
		if #uninvite_id.v > 0 and #uninvite_reason.v > 0 then
			if imgui.Button(u8('������� ')..fa.ICON_MINUS_CIRCLE, imgui.ImVec2(-1, 40)) then
				uval.v = false
				lua_thread.create(function()
	                sampSendChat('/me ������ �� ������� ��� � ������� ���')
	                wait(2500)
	                sampSendChat('/me ������ ������ �����������')
	                wait(2500)
	                sampSendChat('/me ������ ���� ���������� '..sampGetPlayerNickname(tonumber(uninvite_id.v)))
	                wait(2500)
	                sampSendChat('/me ������ ���������� �� �����������')
	                wait(500)
	                sampSendChat('/uninvite '..uninvite_id.v..' '..tostring(uval_res))
	                if #bl_reason.v > 0 then
						wait(2000)
						sampSendChat('/me �������� ������ �׸���� ������')
						wait(2500)
						sampSendChat('/me ��� '..sampGetPlayerNickname(tonumber(uninvite_id.v))..' � ������ ������ �����������')
						wait(500)
						sampSendChat('/blacklist '..uninvite_id.v..' '..tostring(u8:decode(bl_reason.v)))
					end
					uninvite_id.v, uninvite_reason.v, bl_reason.v = '', '', ''
					name_uval, uval_res, chs_res = '', '', ''
	            end)
			end
		end
		imgui.End()
	end
  
end

function main() -- ����
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(tag.. '{FFFFFF}��������', -1)
    imgui.Process = false
    sampRegisterChatCommand('mhelp', function()
        main_window_state.v = not main_window_state.v
        imgui.Process = main_window_state.v
    end)
    sampRegisterChatCommand('uval', function(id_player)
      if mainIni.config.rank > 8 then
        if #id_player == 0 then 
          sampAddChatMessage(tag..'������ ������������: /uval [id] [�������] [�� ������� (0 ���� ���)]', -1)
          uninvite_id.v, uninvite_reason.v, bl_reason.v = '', '', ''
          name_uval, uval_res, chs_res = '', '', ''
          main_window_state.v = not main_window_state.v
          imgui.Process = main_window_state.v
          uval.v = not uval.v
          imgui.Process = uval.v
        else
          local id_u, reason_u, bl_u = id_player:match('(%d+) (.+) (.+)')
          if tonumber(id_u) and reason_u and bl_u then
            if bl_u == '0' then 
              bl_reason.v = ''
            else
              bl_reason.v = u8(bl_u)
            end
            uninvite_id.v = tostring(id_u)
            uninvite_reason.v = u8(reason_u)
            main_window_state.v = not main_window_state.v
            imgui.Process = main_window_state.v
            uval.v = not uval.v
            imgui.Process = uval.v
          else
            sampAddChatMessage('[������] /uval [id] [�������] [�� ������� (0 ���� ���)]', -1)
          end
        end
      else
        sampAddChatMessage(tag..'������� �������� ������ � 9-��� �����', -1)
      end
    end)
    

    imgui.SwitchContext()
    style_gray()
    autoupdate("https://raw.githubusercontent.com/NikZakonov410/scripts/master/version.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/NikZakonov410/scripts/master/version.json")
    while true do
        wait(0)
        if testCheat('MM') then
          MainAction.v = 1
          main_window_state.v = not main_window_state.v
          imgui.Process = main_window_state.v
        end
        if testCheat('uval') then
          MainAction.v = 3
          main_window_state.v = not main_window_state.v
          imgui.Process = main_window_state.v
        end
        if isKeyJustPressed(0x52) then
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) --�������
            if valid and doesCharExist(ped) then
                local result, id = sampGetPlayerIdByCharHandle(ped)
                local _, selfid = sampGetPlayerIdByCharHandle(playerPed) 
	            if result then
                    sampAddChatMessage(tag..'{ffffff}��������� Esc, ��� �� ������� ����', -1)
                    actionId = id
                    med_window.v = not med_window.v
                end
                imgui.Process = med_window.v
	        end
        end
        if isKeyJustPressed(0x32) then
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) --�������
            if valid and doesCharExist(ped) then
                local result, id = sampGetPlayerIdByCharHandle(ped)
	            if result then
                    sampAddChatMessage(tag..'{ffffff}��������� Esc, ��� �� ������� ����', -1)
                    actionId = id
                    our_window_state.v = not our_window_state.v
                end
                imgui.Process = our_window_state.v
	        end
        end
        if isKeyJustPressed(0x33) then
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) --�������
            if valid and doesCharExist(ped) then
                local result, id = sampGetPlayerIdByCharHandle(ped)
	            if result then
                    sampAddChatMessage(tag..'{ffffff}��������� Esc, ��� �� ������� ����', -1)
                    actionId = id
                    sobes_window_state.v = not sobes_window_state.v
                end
                imgui.Process = sobes_window_state.v
	        end
      end
    end
end

 function sampev.onServerMessage(color, text)
  if text:find('������� ��� 4000 ���.') then
    notify.addNotify('{DC143C}[MedHelper]', '������� {DC143C}��� + 3 {FFFFFF}���-�� ������� ����', 2, 2, 6)
  end
 end

 function sampev.onServerMessage(color, text)
  if text:find('������� ��� 2000 ���.') then
    notify.addNotify('{DC143C}[MedHelper]', '������� {DC143C}��� + 3 {FFFFFF}���-�� ������ ���.�����', 2, 2, 6)
  end
 end

 function sampev.onServerMessage(color, text)
  if text:find('������� ��� 1500 ���.') then
    notify.addNotify('{DC143C}[MedHelper]', '������� {DC143C}��� + 3 {FFFFFF}���-�� ������ ������', 2, 2, 6)
  end
 end

 function sampev.onServerMessage(color, text)
  if text:find('������� ��� 1000 ���.') then
    notify.addNotify('{DC143C}[MedHelper]', '������� {DC143C}��� + 3 {FFFFFF}���-�� ������ �������', 2, 2, 6)
  end
 end

function imgui.CenterTextColoredRGB(text)
  local width = imgui.GetWindowWidth()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local ImVec4 = imgui.ImVec4

  local explode_argb = function(argb)
      local a = bit.band(bit.rshift(argb, 24), 0xFF)
      local r = bit.band(bit.rshift(argb, 16), 0xFF)
      local g = bit.band(bit.rshift(argb, 8), 0xFF)
      local b = bit.band(argb, 0xFF)
      return a, r, g, b
  end

  local getcolor = function(color)
      if color:sub(1, 6):upper() == 'SSSSSS' then
          local r, g, b = colors[1].x, colors[1].y, colors[1].z
          local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
          return ImVec4(r, g, b, a / 255)
      end
      local color = type(color) == 'string' and tonumber(color, 16) or color
      if type(color) ~= 'number' then return end
      local r, g, b, a = explode_argb(color)
      return imgui.ImColor(r, g, b, a):GetVec4()
  end

  local render_text = function(text_)
      for w in text_:gmatch('[^\r\n]+') do
          local textsize = w:gsub('{.-}', '')
          local text_width = imgui.CalcTextSize(u8(textsize))
          imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
          local text, colors_, m = {}, {}, 1
          w = w:gsub('{(......)}', '{%1FF}')
          while w:find('{........}') do
              local n, k = w:find('{........}')
              local color = getcolor(w:sub(n + 1, k - 1))
              if color then
                  text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                  colors_[#colors_ + 1] = color
                  m = n
              end
              w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
          end
          if text[0] then
              for i = 0, #text do
                  imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                  imgui.SameLine(nil, 0)
              end
              imgui.NewLine()
          else
              imgui.Text(u8(w))
          end
      end
  end
  render_text(text)
end
function sampev.onSendChat(msg)
 if msg:find('{my_name}') then
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name_without_space = sampGetPlayerNickname(myid):gsub('_', ' ')
  local input_with_name = msg:gsub('{my_name}', name_without_space)
  sampSendChat(input_with_name)
  return false
 end
end
function imgui.HintHovered(text)
  if imgui.IsItemHovered() then
      imgui.BeginTooltip()
      imgui.PushTextWrapPos(450)
      imgui.TextUnformatted(text)
      imgui.PopTextWrapPos()
      imgui.EndTooltip()
  end
end

function greenbtn()
  imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.50, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.00, 0.40, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.00, 0.30, 0.00, 1.00))
end

function redbtn()
  imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.50, 0.00, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.40, 0.00, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.30, 0.00, 0.00, 1.00))
end

function imgui.PushDisableButton()
	imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.0, 0.0, 0.0, 0.2))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.0, 0.0, 0.0, 0.2))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.0, 0.0, 0.0, 0.2))
end

function imgui.PopDisableButton()
	imgui.PopStyleColor(3)
end

function endbtn()
  imgui.PopStyleColor(3)
end

function imgui.TextColoredRGB(text)
  local style = imgui.GetStyle()
  local colors = style.Colors
  local ImVec4 = imgui.ImVec4

  local explode_argb = function(argb)
      local a = bit.band(bit.rshift(argb, 24), 0xFF)
      local r = bit.band(bit.rshift(argb, 16), 0xFF)
      local g = bit.band(bit.rshift(argb, 8), 0xFF)
      local b = bit.band(argb, 0xFF)
      return a, r, g, b
  end

  local getcolor = function(color)
      if color:sub(1, 6):upper() == 'SSSSSS' then
          local r, g, b = colors[1].x, colors[1].y, colors[1].z
          local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
          return ImVec4(r, g, b, a / 255)
      end
      local color = type(color) == 'string' and tonumber(color, 16) or color
      if type(color) ~= 'number' then return end
      local r, g, b, a = explode_argb(color)
      return imgui.ImColor(r, g, b, a):GetVec4()
  end

  local render_text = function(text_)
      for w in text_:gmatch('[^\r\n]+') do
          local text, colors_, m = {}, {}, 1
          w = w:gsub('{(......)}', '{%1FF}')
          while w:find('{........}') do
              local n, k = w:find('{........}')
              local color = getcolor(w:sub(n + 1, k - 1))
              if color then
                  text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                  colors_[#colors_ + 1] = color
                  m = n
              end
              w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
          end
          if text[0] then
              for i = 0, #text do
                  imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                  imgui.SameLine(nil, 0)
              end
              imgui.NewLine()
          else imgui.Text(u8(w)) end
      end
  end

  render_text(text)
end
local russian_characters = {
  [168] = '�', [184] = '�', [192] = '�', [193] = '�', [194] = '�', [195] = '�', [196] = '�', [197] = '�', [198] = '�', [199] = '�', [200] = '�', [201] = '�', [202] = '�', [203] = '�', [204] = '�', [205] = '�', [206] = '�', [207] = '�', [208] = '�', [209] = '�', [210] = '�', [211] = '�', [212] = '�', [213] = '�', [214] = '�', [215] = '�', [216] = '�', [217] = '�', [218] = '�', [219] = '�', [220] = '�', [221] = '�', [222] = '�', [223] = '�', [224] = '�', [225] = '�', [226] = '�', [227] = '�', [228] = '�', [229] = '�', [230] = '�', [231] = '�', [232] = '�', [233] = '�', [234] = '�', [235] = '�', [236] = '�', [237] = '�', [238] = '�', [239] = '�', [240] = '�', [241] = '�', [242] = '�', [243] = '�', [244] = '�', [245] = '�', [246] = '�', [247] = '�', [248] = '�', [249] = '�', [250] = '�', [251] = '�', [252] = '�', [253] = '�', [254] = '�', [255] = '�',
}
function string.rlower(s)
  s = s:lower()
  local strlen = s:len()
  if strlen == 0 then return s end
  s = s:lower()
  local output = ''
  for i = 1, strlen do
      local ch = s:byte(i)
      if ch >= 192 and ch <= 223 then -- upper russian characters
          output = output .. russian_characters[ch + 32]
      elseif ch == 168 then -- �
          output = output .. russian_characters[184]
      else
          output = output .. string.char(ch)
      end
  end
  return output
end
function sampev.onServerMessage(clr, msg) -- ��� ����
	local other, get_rank = string.match(msg, '(.+) ������� �� (%d+) �����')
	if other and rank ~= nil then
		if tonumber(get_rank) > 0 and tonumber(get_rank) < 10 then
			sampAddChatMessage(tag..'�����������! '..other..' ������� ��� �� '..get_rank..' �����!', -1)
			sampAddChatMessage(tag..'������ ��� ����: '..mainIni.nameRank[tonumber(get_rank)], -1)
			sampAddChatMessage(tag..'�� �������� ������� �������� � /time', -1)
			mainIni.config.rank = tonumber(get_rank)
			inicfg.save(mainIni, directIni)
		end
  end
end

function onWindowMessage(msg, wparam, lparam)
  if wparam == vkeys.VK_ESCAPE then 
    if med_window.v then
        consumeWindowMessage(true, true)
        med_window.v = false
      end
      --if bank.v and not binder_open then
        --consumeWindowMessage(true, true)
        --bank.v = false
      --end
      if main_window_state.v then
        consumeWindowMessage(true, true)
        main_window_state.v = false
      end
  end
end
function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((tag..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), -1)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('�������� ���������� ���������.')
                      sampAddChatMessage((prefix..'���������� ���������!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((tag..'���������� ������ ��������. �������� ���������� ������..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end