local E, L, V, P, G = unpack(ElvUI)

--Is everything ok from here down
local _G = _G
local pairs, tinsert, tremove, unpack = pairs, tinsert, tremove, unpack


local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local PlaySoundFile = PlaySoundFile
local UIFrameFadeOut = UIFrameFadeOut
local CreateAnimationGroup = CreateAnimationGroup
local CONTINUE, PREVIOUS, UNKNOWN = CONTINUE, PREVIOUS, UNKNOWN
local DPS, TANK, HEALER = DPS, TANK, HEALER
--to Here?
--And do I need this frame below?
local function SetMoverPosition(mover, point, anchor, secondaryPoint, x, y)
	if not _G[mover] then return end
	local frame = _G[mover]

	frame:ClearAllPoints()
	frame:SetPoint(point, anchor, secondaryPoint, x, y)
	E:SaveMoverPosition(mover)
end

local CURRENT_PAGE = 0
local MAX_PAGE = 5

local function SetupOUILayout () 
	--General
	E.db["general"]["totems"]["growthDirection"] = "HORIZONTAL"
	E.db["general"]["threat"]["enable"] = false
	E.db["general"]["topPanel"] = false
	E.db["general"]["bordercolor"]["b"] = 0.31
	E.db["general"]["bordercolor"]["g"] = 0.31
	E.db["general"]["bordercolor"]["r"] = 0.31
	E.db["general"]["bottomPanel"] = false
	E.db["general"]["valuecolor"]["b"] = 0.93
	E.db["general"]["valuecolor"]["g"] = 0.53
	E.db["general"]["valuecolor"]["r"] = 0.53
	E.db["general"]["interruptAnnounce"] = "RAID"
	E.db["general"]["vendorGrays"] = true
	E.db["bossAuraFiltersConverted"] = true
	E.db["hideTutorial"] = true
	E.db["currentTutorial"] = 1
	
	
	E.db["databars"]["artifact"]["height"] = 130
	E.db["databars"]["reputation"]["height"] = 130
	E.db["databars"]["experience"]["height"] = 130
	E.db["databars"]["honor"]["height"] = 130
	
	E.db["datatexts"]["minimapPanels"] = false
	E.db["datatexts"]["battleground"] = false
	E.db["datatexts"]["leftChatPanel"] = false
	E.db["datatexts"]["localtime"] = false
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = ""
	E.db["datatexts"]["rightChatPanel"] = false
	
	E.db["bags"]["bagWidth"] = 500
	E.db["bags"]["countFont"] = "Expressway"
	E.db["bags"]["itemLevelFont"] = "Expressway"
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["bankWidth"] = 500
	E.db["bags"]["itemLevelFontOutline"] = "NONE"
	E.db["bags"]["alignToChat"] = false
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	
	--Tooltip
	E.db["tooltip"]["font"] = "Expressway"
	E.db["tooltip"]["healthBar"]["font"] = "Expressway"
	
	--Nameplates
	E.db["nameplates"]["statusbar"] = "Blizzard"
	E.db["nameplates"]["fontOutline"] = "NONE"
	E.db["nameplates"]["font"] = "Expressway"
	E.db["nameplates"]["fontSize"] = 10
	
	
	E.db["movers"]["AlertFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,327,-210"
	E.db["movers"]["GMMover"] = "TOP,ElvUIParent,TOP,0,-9"
	E.db["movers"]["ExperienceBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,346,32"
	E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,32"
	E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,32"
	E.db["movers"]["MinimapMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
	E.db["movers"]["ArtifactBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,358,32"
	E.db["movers"]["VehicleSeatMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,353,-4"
	E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-56,-121"
	E.db["movers"]["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,509,-210"
	E.db["movers"]["HonorBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-346,32"
	
	if InstallStepComplete then
		InstallStepComplete.message = OUI.Title..L['Layout Set']
		InstallStepComplete:Show()
		titleText[2].check:Show()
	end
	E:UpdateAll(true)
end

local function SetupOuiChat ()

	--chat
	E.db["chat"]["font"] = "Expressway"
	E.db["chat"]["panelHeight"] = 130
	E.db["chat"]["tabFont"] = "Expressway"
	E.db["chat"]["tabFontSize"] = 10
	E.db["chat"]["panelWidth"] = 340
	
	if InstallStepComplete then
		InstallStepComplete.message = OUI.Title..L['Chat Set']
		InstallStepComplete:Show()
		titleText[3].check:Show()		
	end
	E:UpdateAll(true)
end
	
local function SetupActionbars(layout)	
	--Actionbars
	if layout == 'dps' then	
		E.db["actionbar"]["bar3"]["enabled"] = false
		E.db["actionbar"]["bar3"]["buttons"] = 12
		E.db["actionbar"]["bar3"]["buttonspacing"] = 0
		E.db["actionbar"]["bar3"]["buttonsPerRow"] = 12
		E.db["actionbar"]["bar3"]["visibility"] = ""
		E.db["actionbar"]["bar2"]["enabled"] = true
		E.db["actionbar"]["bar2"]["buttons"] = 8
		E.db["actionbar"]["bar2"]["buttonspacing"] = 0
		E.db["actionbar"]["bar2"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar2"]["visibility"] = ""
		E.db["actionbar"]["bar2"]["buttonsize"] = 25
		E.db["actionbar"]["bar1"]["buttons"] = 5
		E.db["actionbar"]["bar1"]["buttonspacing"] = 0
		E.db["actionbar"]["bar1"]["visibility"] = "\n"
		E.db["actionbar"]["bar1"]["buttonsize"] = 50
		E.db["actionbar"]["bar4"]["buttons"] = 8
		E.db["actionbar"]["bar4"]["buttonspacing"] = 0
		E.db["actionbar"]["bar4"]["mouseover"] = true
		E.db["actionbar"]["bar4"]["backdrop"] = false
		E.db["actionbar"]["bar4"]["alpha"] = 0.5
		E.db["actionbar"]["bar4"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar4"]["visibility"] = ""
		E.db["actionbar"]["bar4"]["buttonsize"] = 25
		E.db["actionbar"]["bar5"]["buttons"] = 8
		E.db["actionbar"]["bar5"]["buttonspacing"] = 0
		E.db["actionbar"]["bar5"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar5"]["visibility"] = ""
		E.db["actionbar"]["bar5"]["buttonsize"] = 25
		E.db["actionbar"]["barPet"]["buttonsize"] = 15
		E.db["actionbar"]["barPet"]["buttonsPerRow"] = 10
		E.db["actionbar"]["barPet"]["backdrop"] = false
		E.db["actionbar"]["barPet"]["mouseover"] = true
		E.db["actionbar"]["backdropSpacingConverted"] = true
		E.db["actionbar"]["font"] = "Expressway"
		E.db["actionbar"]["bar6"]["enabled"] = true
		E.db["actionbar"]["bar6"]["buttons"] = 8
		E.db["actionbar"]["bar6"]["buttonspacing"] = 0
		E.db["actionbar"]["bar6"]["alpha"] = 0.5
		E.db["actionbar"]["bar6"]["mouseover"] = true
		E.db["actionbar"]["bar6"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar6"]["visibility"] = ""
		E.db["actionbar"]["bar6"]["buttonsize"] = 25
		E.db["actionbar"]["fontOutline"] = "OUTLINE"
		E.db["actionbar"]["stanceBar"]["heightMult"] = 2
		E.db["actionbar"]["stanceBar"]["widthMult"] = 2
		E.db["actionbar"]["keyDown"] = false
		
		--movers
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,30"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,177,30"
		E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,281,30"
		E.db["movers"]["ElvAB_3"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-181,98"
		E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-179,30"
		E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,-283,30"
		E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,86"
		E.db["movers"]["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,507,58"
		E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,0,217"
		E.db["movers"]["BossHeaderMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-243"
		E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-238,-355"
		
	elseif layout == 'tank' then	
		E.db["actionbar"]["bar3"]["enabled"] = false
		E.db["actionbar"]["bar3"]["buttons"] = 12
		E.db["actionbar"]["bar3"]["buttonspacing"] = 0
		E.db["actionbar"]["bar3"]["buttonsPerRow"] = 12
		E.db["actionbar"]["bar3"]["visibility"] = ""
		E.db["actionbar"]["bar2"]["enabled"] = true
		E.db["actionbar"]["bar2"]["buttons"] = 8
		E.db["actionbar"]["bar2"]["buttonspacing"] = 0
		E.db["actionbar"]["bar2"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar2"]["visibility"] = ""
		E.db["actionbar"]["bar2"]["buttonsize"] = 25
		E.db["actionbar"]["bar1"]["buttons"] = 5
		E.db["actionbar"]["bar1"]["buttonspacing"] = 0
		E.db["actionbar"]["bar1"]["visibility"] = "\n"
		E.db["actionbar"]["bar1"]["buttonsize"] = 50
		E.db["actionbar"]["bar4"]["buttons"] = 8
		E.db["actionbar"]["bar4"]["buttonspacing"] = 0
		E.db["actionbar"]["bar4"]["mouseover"] = true
		E.db["actionbar"]["bar4"]["backdrop"] = false
		E.db["actionbar"]["bar4"]["alpha"] = 0.5
		E.db["actionbar"]["bar4"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar4"]["visibility"] = ""
		E.db["actionbar"]["bar4"]["buttonsize"] = 25
		E.db["actionbar"]["bar5"]["buttons"] = 8
		E.db["actionbar"]["bar5"]["buttonspacing"] = 0
		E.db["actionbar"]["bar5"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar5"]["visibility"] = ""
		E.db["actionbar"]["bar5"]["buttonsize"] = 25
		E.db["actionbar"]["barPet"]["buttonsize"] = 15
		E.db["actionbar"]["barPet"]["buttonsPerRow"] = 10
		E.db["actionbar"]["barPet"]["backdrop"] = false
		E.db["actionbar"]["barPet"]["mouseover"] = true
		E.db["actionbar"]["backdropSpacingConverted"] = true
		E.db["actionbar"]["font"] = "Expressway"
		E.db["actionbar"]["bar6"]["enabled"] = true
		E.db["actionbar"]["bar6"]["buttons"] = 8
		E.db["actionbar"]["bar6"]["buttonspacing"] = 0
		E.db["actionbar"]["bar6"]["alpha"] = 0.5
		E.db["actionbar"]["bar6"]["mouseover"] = true
		E.db["actionbar"]["bar6"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar6"]["visibility"] = ""
		E.db["actionbar"]["bar6"]["buttonsize"] = 25
		E.db["actionbar"]["fontOutline"] = "OUTLINE"
		E.db["actionbar"]["stanceBar"]["heightMult"] = 2
		E.db["actionbar"]["stanceBar"]["widthMult"] = 2
		E.db["actionbar"]["keyDown"] = false
		
		--movers
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,30"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,177,30"
		E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,281,30"
		E.db["movers"]["ElvAB_3"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-181,98"
		E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-179,30"
		E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,-283,30"
		E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,86"
		E.db["movers"]["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,507,58"
		E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,0,217"
		E.db["movers"]["BossHeaderMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-243"
		E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-238,-355"
		
	elseif layout == 'healer' then
		E.db["actionbar"]["bar3"]["enabled"] = false
		E.db["actionbar"]["bar3"]["buttons"] = 12
		E.db["actionbar"]["bar3"]["buttonspacing"] = 0
		E.db["actionbar"]["bar3"]["buttonsPerRow"] = 12
		E.db["actionbar"]["bar3"]["visibility"] = ""
		E.db["actionbar"]["extraActionButton"]["scale"] = 0.56
		E.db["actionbar"]["bar2"]["enabled"] = true
		E.db["actionbar"]["bar2"]["buttons"] = 8
		E.db["actionbar"]["bar2"]["buttonspacing"] = 0
		E.db["actionbar"]["bar2"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar2"]["visibility"] = ""
		E.db["actionbar"]["bar2"]["buttonsize"] = 25
		E.db["actionbar"]["bar1"]["buttons"] = 5
		E.db["actionbar"]["bar1"]["buttonspacing"] = 0
		E.db["actionbar"]["bar1"]["buttonsize"] = 50
		E.db["actionbar"]["bar1"]["visibility"] = "\n"
		E.db["actionbar"]["backdropSpacingConverted"] = true
		E.db["actionbar"]["bar5"]["buttons"] = 8
		E.db["actionbar"]["bar5"]["buttonspacing"] = 0
		E.db["actionbar"]["bar5"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar5"]["visibility"] = ""
		E.db["actionbar"]["bar5"]["buttonsize"] = 25
		E.db["actionbar"]["barPet"]["buttonsize"] = 15
		E.db["actionbar"]["barPet"]["buttonsPerRow"] = 10
		E.db["actionbar"]["barPet"]["backdrop"] = false
		E.db["actionbar"]["barPet"]["mouseover"] = true
		E.db["actionbar"]["bar4"]["buttons"] = 8
		E.db["actionbar"]["bar4"]["buttonspacing"] = 0
		E.db["actionbar"]["bar4"]["mouseover"] = true
		E.db["actionbar"]["bar4"]["backdrop"] = false
		E.db["actionbar"]["bar4"]["alpha"] = 0.5
		E.db["actionbar"]["bar4"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar4"]["buttonsize"] = 25
		E.db["actionbar"]["bar4"]["visibility"] = ""
		E.db["actionbar"]["font"] = "Expressway"
		E.db["actionbar"]["bar6"]["enabled"] = true
		E.db["actionbar"]["bar6"]["buttons"] = 8
		E.db["actionbar"]["bar6"]["buttonspacing"] = 0
		E.db["actionbar"]["bar6"]["mouseover"] = true
		E.db["actionbar"]["bar6"]["alpha"] = 0.5
		E.db["actionbar"]["bar6"]["buttonsPerRow"] = 4
		E.db["actionbar"]["bar6"]["buttonsize"] = 25
		E.db["actionbar"]["bar6"]["visibility"] = ""
		E.db["actionbar"]["fontOutline"] = "OUTLINE"
		E.db["actionbar"]["stanceBar"]["heightMult"] = 2
		E.db["actionbar"]["stanceBar"]["widthMult"] = 2
		E.db["actionbar"]["keyDown"] = false
		
		--movers
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,30"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,177,30"
		E.db["movers"]["ElvAB_3"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-181,98"
		E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,281,30"
		E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-179,30"
		E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,-283,30"
		E.db["movers"]["PetAB"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,264"
		E.db["movers"]["BossButton"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-255,164"
		E.db["movers"]["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,507,58"
		E.db["movers"]["BossHeaderMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-243"
		E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-238,-355"	
	end	
	if InstallStepComplete then
		InstallStepComplete.message = OUI.Title..L['Actionbars Set']
		InstallStepComplete:Show()
		titleText[5].check:Show()
	end
	E:UpdateAll(true)
end
	
local function SetupUnitFrames(layout)	
	if layout == 'tank' then
	
		--Auras
		E.private["auras"]["enable"] = false

		--Units
		--general
		E.db["unitframe"]["statusbar"] = "Blizzard"
		E.db["unitframe"]["colors"]["auraBarBuff"]["b"] = 0.87
		E.db["unitframe"]["colors"]["auraBarBuff"]["g"] = 0.44
		E.db["unitframe"]["colors"]["auraBarBuff"]["r"] = 0
		E.db["unitframe"]["colors"]["healthclass"] = true
		E.db["unitframe"]["colors"]["castClassColor"] = true
		E.db["unitframe"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["font"] = "Expressway"
		E.db["unitframe"]["smoothbars"] = true
		E.db["unitframe"]["fontSize"] = 12
		
		--player
		E.db["unitframe"]["units"]["player"]["restIcon"] = false
		E.db["unitframe"]["units"]["player"]["debuffs"]["attachTo"] = "BUFFS"
		E.db["unitframe"]["units"]["player"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["player"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
		E.db["unitframe"]["units"]["player"]["power"]["position"] = "LEFT"
		E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
		E.db["unitframe"]["units"]["player"]["width"] = 255
		E.db["unitframe"]["units"]["player"]["health"]["text_format"] = "[health:current-percent]"
		E.db["unitframe"]["units"]["player"]["health"]["position"] = "RIGHT"
		E.db["unitframe"]["units"]["player"]["name"]["text_format"] = "[name:medium]"
		E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 20
		E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 255
		E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
		E.db["unitframe"]["units"]["player"]["height"] = 36
		E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
		E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 9
		E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 255
		
		--target
		E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 19
		E.db["unitframe"]["units"]["target"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 13
		E.db["unitframe"]["units"]["target"]["power"]["xOffset"] = -2
		E.db["unitframe"]["units"]["target"]["power"]["hideonnpc"] = false
		E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["target"]["power"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 20
		E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 255
		E.db["unitframe"]["units"]["target"]["castbar"]["insideInfoPanel"] = false
		E.db["unitframe"]["units"]["target"]["width"] = 255
		E.db["unitframe"]["units"]["target"]["height"] = 36
		E.db["unitframe"]["units"]["target"]["health"]["xOffset"] = 2
		E.db["unitframe"]["units"]["target"]["health"]["text_format"] = "[health:current-percent]"
		E.db["unitframe"]["units"]["target"]["health"]["position"] = "LEFT"
		E.db["unitframe"]["units"]["target"]["orientation"] = "LEFT"
		E.db["unitframe"]["units"]["target"]["buffs"]["selfBuffs"] = true
		E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "TOPLEFT"
		E.db["unitframe"]["units"]["target"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["name"]["text_format"] = "[namecolor][name][difficultycolor]"
		E.db["unitframe"]["units"]["target"]["aurabar"]["maxDuration"] = 120
		E.db["unitframe"]["units"]["target"]["aurabar"]["selfBuffs"] = true
		E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
		
		--pet
		E.db["unitframe"]["units"]["pet"]["name"]["yOffset"] = 3
		E.db["unitframe"]["units"]["pet"]["height"] = 25
		E.db["unitframe"]["units"]["pet"]["health"]["xOffset"] = 0
		
		--targettarget
		E.db["unitframe"]["units"]["targettarget"]["enable"] = false
		
		--party
		E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "TOP"
		E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 20
		E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 20
		E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 3
		E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 3
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 24
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = true
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["yOffset"] = 16
		E.db["unitframe"]["units"]["party"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["attachTo"] = "Frame"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "TOP"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["damager"] = false
		E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["party"]["width"] = 70
		E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
		
		--raid
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["attachTo"] = "Frame"
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["position"] = "TOP"
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["yOffset"] = 0
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["damager"] = false
		E.db["unitframe"]["units"]["raid"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["raid"]["name"]["yOffset"] = 3
		E.db["unitframe"]["units"]["raid"]["name"]["position"] = "BOTTOM"
		E.db["unitframe"]["units"]["raid"]["height"] = 40
		E.db["unitframe"]["units"]["raid"]["width"] = 65
		
		--raid 40
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["raid40"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["raid40"]["width"] = 65
		
		--Boss
		E.db["unitframe"]["units"]["boss"]["debuffs"]["numrows"] = 1
		E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = 13
		E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = -13
		E.db["unitframe"]["units"]["boss"]["debuffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["width"] = 100
		E.db["unitframe"]["units"]["boss"]["buffs"]["yOffset"] = 13
		E.db["unitframe"]["units"]["boss"]["buffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["buffs"]["xOffset"] = 13
		
		--movers
		E.db["movers"]["ElvUF_FocusCastbarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,356,342"
		E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-218,94"
		E.db["movers"]["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,164"
		E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
		E.db["movers"]["ElvUF_FocusMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,356,366"
		E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-218,158"
		E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,220,120"
		E.db["movers"]["LossControlMover"] = "TOP,ElvUIParent,TOP,0,-491"
		E.db["movers"]["ElvUF_Raid40Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,163"
		E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,447"
		E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-218,120"
		E.db["movers"]["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,127"
		E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,141"
		E.db["movers"]["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,484"
		E.db["movers"]["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,370,32"
		E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,220,94"
		E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,164"
		E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-153,330"
		E.db["movers"]["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,126,483"
		
	elseif layout == 'dps' then
	
		--Auras
		E.private["auras"]["enable"] = false

		--Units
		--general
		E.db["unitframe"]["statusbar"] = "Blizzard"
		E.db["unitframe"]["colors"]["auraBarBuff"]["b"] = 0.87
		E.db["unitframe"]["colors"]["auraBarBuff"]["g"] = 0.44
		E.db["unitframe"]["colors"]["auraBarBuff"]["r"] = 0
		E.db["unitframe"]["colors"]["healthclass"] = true
		E.db["unitframe"]["colors"]["castClassColor"] = true
		E.db["unitframe"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["font"] = "Expressway"
		E.db["unitframe"]["smoothbars"] = true
		E.db["unitframe"]["fontSize"] = 12
		
		--player
		E.db["unitframe"]["units"]["player"]["restIcon"] = false
		E.db["unitframe"]["units"]["player"]["debuffs"]["attachTo"] = "BUFFS"
		E.db["unitframe"]["units"]["player"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["player"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
		E.db["unitframe"]["units"]["player"]["power"]["position"] = "LEFT"
		E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
		E.db["unitframe"]["units"]["player"]["width"] = 255
		E.db["unitframe"]["units"]["player"]["health"]["text_format"] = "[health:current-percent]"
		E.db["unitframe"]["units"]["player"]["health"]["position"] = "RIGHT"
		E.db["unitframe"]["units"]["player"]["name"]["text_format"] = "[name:medium]"
		E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 20
		E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 255
		E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
		E.db["unitframe"]["units"]["player"]["height"] = 36
		E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
		E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 9
		E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 255
		
		--target
		E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 19
		E.db["unitframe"]["units"]["target"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 13
		E.db["unitframe"]["units"]["target"]["power"]["xOffset"] = -2
		E.db["unitframe"]["units"]["target"]["power"]["hideonnpc"] = false
		E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["target"]["power"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 20
		E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 255
		E.db["unitframe"]["units"]["target"]["castbar"]["insideInfoPanel"] = false
		E.db["unitframe"]["units"]["target"]["width"] = 255
		E.db["unitframe"]["units"]["target"]["height"] = 36
		E.db["unitframe"]["units"]["target"]["health"]["xOffset"] = 2
		E.db["unitframe"]["units"]["target"]["health"]["text_format"] = "[health:current-percent]"
		E.db["unitframe"]["units"]["target"]["health"]["position"] = "LEFT"
		E.db["unitframe"]["units"]["target"]["orientation"] = "LEFT"
		E.db["unitframe"]["units"]["target"]["buffs"]["selfBuffs"] = true
		E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "TOPLEFT"
		E.db["unitframe"]["units"]["target"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["name"]["text_format"] = "[namecolor][name][difficultycolor]"
		E.db["unitframe"]["units"]["target"]["aurabar"]["maxDuration"] = 120
		E.db["unitframe"]["units"]["target"]["aurabar"]["selfBuffs"] = true
		E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
		
		--pet
		E.db["unitframe"]["units"]["pet"]["name"]["yOffset"] = 3
		E.db["unitframe"]["units"]["pet"]["height"] = 25
		E.db["unitframe"]["units"]["pet"]["health"]["xOffset"] = 0
		
		--targettarget
		E.db["unitframe"]["units"]["targettarget"]["enable"] = false
		
		--party
		E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "TOP"
		E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 20
		E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 20
		E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 3
		E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 3
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 24
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = true
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["yOffset"] = 16
		E.db["unitframe"]["units"]["party"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["attachTo"] = "Frame"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "TOP"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["damager"] = false
		E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["party"]["width"] = 70
		E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
		
		--raid
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["attachTo"] = "Frame"
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["position"] = "TOP"
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["yOffset"] = 0
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["damager"] = false
		E.db["unitframe"]["units"]["raid"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["raid"]["name"]["yOffset"] = 3
		E.db["unitframe"]["units"]["raid"]["name"]["position"] = "BOTTOM"
		E.db["unitframe"]["units"]["raid"]["height"] = 40
		E.db["unitframe"]["units"]["raid"]["width"] = 65
		
		--raid 40
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["raid40"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["raid40"]["width"] = 65
		
		--Boss
		E.db["unitframe"]["units"]["boss"]["debuffs"]["numrows"] = 1
		E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = 13
		E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = -13
		E.db["unitframe"]["units"]["boss"]["debuffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["width"] = 100
		E.db["unitframe"]["units"]["boss"]["buffs"]["yOffset"] = 13
		E.db["unitframe"]["units"]["boss"]["buffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["buffs"]["xOffset"] = 13
		
		--movers
		E.db["movers"]["ElvUF_FocusCastbarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,356,342"
		E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-218,94"
		E.db["movers"]["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,164"
		E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
		E.db["movers"]["ElvUF_FocusMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,356,366"
		E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-218,158"
		E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,220,120"
		E.db["movers"]["LossControlMover"] = "TOP,ElvUIParent,TOP,0,-491"
		E.db["movers"]["ElvUF_Raid40Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,163"
		E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,447"
		E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-218,120"
		E.db["movers"]["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,127"
		E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,141"
		E.db["movers"]["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,484"
		E.db["movers"]["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,370,32"
		E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,220,94"
		E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,164"
		E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-153,330"
		E.db["movers"]["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,126,483"

		
	elseif layout == 'healer' then
		
		--Auras
		E.private["auras"]["enable"] = false
		
		--Units
		--general
		E.db["unitframe"]["smoothbars"] = true
		E.db["unitframe"]["colors"]["auraBarBuff"]["r"] = 0
		E.db["unitframe"]["colors"]["auraBarBuff"]["g"] = 0.44
		E.db["unitframe"]["colors"]["auraBarBuff"]["b"] = 0.87
		E.db["unitframe"]["colors"]["healthclass"] = true
		E.db["unitframe"]["colors"]["castClassColor"] = true
		E.db["unitframe"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["font"] = "Expressway"
		E.db["unitframe"]["statusbar"] = "Blizzard"
		E.db["unitframe"]["fontSize"] = 12
			
		--player
		E.db["unitframe"]["units"]["player"]["restIcon"] = false
		E.db["unitframe"]["units"]["player"]["debuffs"]["attachTo"] = "BUFFS"
		E.db["unitframe"]["units"]["player"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["player"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
		E.db["unitframe"]["units"]["player"]["power"]["position"] = "LEFT"
		E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
		E.db["unitframe"]["units"]["player"]["width"] = 255
		E.db["unitframe"]["units"]["player"]["health"]["text_format"] = "[health:current-percent]"
		E.db["unitframe"]["units"]["player"]["health"]["position"] = "RIGHT"
		E.db["unitframe"]["units"]["player"]["name"]["text_format"] = "[name:medium]"
		E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 20
		E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 255
		E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
		E.db["unitframe"]["units"]["player"]["height"] = 36
		E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
		E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 255
		E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 9
		
		--target
		E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 19
		E.db["unitframe"]["units"]["target"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 13
		E.db["unitframe"]["units"]["target"]["power"]["xOffset"] = -2
		E.db["unitframe"]["units"]["target"]["power"]["hideonnpc"] = false
		E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["target"]["power"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 20
		E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 255
		E.db["unitframe"]["units"]["target"]["castbar"]["insideInfoPanel"] = false
		E.db["unitframe"]["units"]["target"]["width"] = 255
		E.db["unitframe"]["units"]["target"]["height"] = 36
		E.db["unitframe"]["units"]["target"]["name"]["text_format"] = "[namecolor][name][difficultycolor]"
		E.db["unitframe"]["units"]["target"]["orientation"] = "LEFT"
		E.db["unitframe"]["units"]["target"]["buffs"]["selfBuffs"] = true
		E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "TOPLEFT"
		E.db["unitframe"]["units"]["target"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["health"]["xOffset"] = 2
		E.db["unitframe"]["units"]["target"]["health"]["text_format"] = "[health:current-percent]"
		E.db["unitframe"]["units"]["target"]["health"]["position"] = "LEFT"
		E.db["unitframe"]["units"]["target"]["aurabar"]["maxDuration"] = 120
		E.db["unitframe"]["units"]["target"]["aurabar"]["selfBuffs"] = true
		E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
	
		--pet
		E.db["unitframe"]["units"]["pet"]["name"]["yOffset"] = 3
		E.db["unitframe"]["units"]["pet"]["height"] = 25
		E.db["unitframe"]["units"]["pet"]["health"]["xOffset"] = 0
	
		--targettarget
		E.db["unitframe"]["units"]["targettarget"]["enable"] = false
		
		--party
		E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "TOP"
		E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 20
		E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 20
		E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 3
		E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 3
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 24
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = true
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["yOffset"] = 16
		E.db["unitframe"]["units"]["party"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["attachTo"] = "Frame"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "TOP"
		E.db["unitframe"]["units"]["party"]["roleIcon"]["damager"] = false
		E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["party"]["width"] = 70
		E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
	
		--raid
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["attachTo"] = "Frame"
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["position"] = "TOP"
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["yOffset"] = 0
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["damager"] = false
		E.db["unitframe"]["units"]["raid"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["raid"]["name"]["yOffset"] = 3
		E.db["unitframe"]["units"]["raid"]["name"]["text_format"] = "[namecolor][name:veryshort]"
		E.db["unitframe"]["units"]["raid"]["name"]["position"] = "BOTTOM"
		E.db["unitframe"]["units"]["raid"]["height"] = 35
		E.db["unitframe"]["units"]["raid"]["width"] = 65
	
		--raid 40
		E.db["unitframe"]["units"]["raid40"]["roleIcon"]["enable"] = true
		E.db["unitframe"]["units"]["raid40"]["roleIcon"]["position"] = "LEFT"
		E.db["unitframe"]["units"]["raid40"]["roleIcon"]["damager"] = false
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "RIGHT_UP"
		E.db["unitframe"]["units"]["raid40"]["name"]["text_format"] = "[namecolor][name:veryshort]"
		E.db["unitframe"]["units"]["raid40"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["raid40"]["height"] = 25
		E.db["unitframe"]["units"]["raid40"]["width"] = 65
		
		--Boss
		E.db["unitframe"]["units"]["boss"]["debuffs"]["numrows"] = 1
		E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = 13
		E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = -13
		E.db["unitframe"]["units"]["boss"]["debuffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["width"] = 100
		E.db["unitframe"]["units"]["boss"]["buffs"]["yOffset"] = 13
		E.db["unitframe"]["units"]["boss"]["buffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["buffs"]["xOffset"] = 13
	
		--movers
		E.db["movers"]["ElvUF_FocusCastbarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,360,443"
		E.db["movers"]["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,792,91"
		E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
		E.db["movers"]["ElvUF_FocusMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,360,467"
		E.db["movers"]["ClassBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,363,164"
		E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,285"
		E.db["movers"]["ElvUF_TargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-361,126"
		E.db["movers"]["LossControlMover"] = "TOP,ElvUIParent,TOP,0,-491"
		E.db["movers"]["ElvUF_Raid40Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,792,91"
		E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,363,100"
		E.db["movers"]["ElvUF_PetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,305"
		E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,363,126"
		E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,447"
		E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-361,100"
		E.db["movers"]["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,363,376"
		E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-153,330"
		E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,785,90"
		E.db["movers"]["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,363,311"
	end
	
	if InstallStepComplete then
		InstallStepComplete.message = OUI.Title..L['Unitframes Set']
		InstallStepComplete:Show()
		titleText[4].check:Show()
	end
	E:UpdateAll(true)
end

local function SetupAddOnSkins()
	if IsAddOnLoaded('AddOnSkins') then
	
	if IsAddOnLoaded('Skada') then
			E.private['addonskins']['EmbedSystem'] = false
			E.private['addonskins']['EmbedSystemDual'] = true
			E.private['addonskins']['EmbedBelowTop'] = false
			E.private['addonskins']['TransparentEmbed'] = true
			E.private['addonskins']['SkadaBackdrop'] = false
			E.private['addonskins']['EmbedMain'] = 'Skada'
			E.private['addonskins']['EmbedLeft'] = 'Skada'
			E.private['addonskins']['EmbedRight'] = 'Skada'
		end
		
		if IsAddOnLoaded('DBM-Core') then
			E.private['addonskins']['DBMFont'] = 'Expressway'
			E.private['addonskins']['DBMFontSize'] = 12
			E.private['addonskins']['DBMFontFlag'] = 'OUTLINE'
		end
	end
end

local skadaName = GetAddOnMetadata('Skada', 'Title')
local dbmName = GetAddOnMetadata('DBM-Core', 'Title')
local ravenName =  GetAddOnMetadata('Raven', 'Title')
local xctName = GetAddOnMetadata('xCT', 'Title')

local function SetupOuiAddons()
	--Skada Profile
	if SkadaDB and T.IsAddOnLoaded("Skada") then
		SkadaDB['profiles']['MaximumOverdrive'] = {
			["windows"] = {
				{
					["titleset"] = false,
					["barheight"] = 19,
					["barbgcolor"] = {
						["a"] = 0.5,
						["b"] = 0.301960784313726,
						["g"] = 0.301960784313726,
						["r"] = 0.301960784313726,
					},
					["barcolor"] = {
						["a"] = 0.5,
						["b"] = 1,
						["g"] = 0.349019607843137,
						["r"] = 0.227450980392157,
					},
					["barfontsize"] = 10,
					["classicons"] = false,
					["barslocked"] = true,
					["mode"] = "Damage taken",
					["wipemode"] = "Damage taken",
					["bartexture"] = "Blizzard",
					["barwidth"] = 156,
					["point"] = "TOPLEFT",
					["x"] = 185.000701904297,
					["y"] = -23.9979248046875,
					["barfont"] = "Expressway",
					["title"] = {
						["font"] = "Expressway",
						["borderthickness"] = 0,
						["color"] = {
							["a"] = 0.550000011920929,
							["b"] = 0.0784313725490196,
							["g"] = 0.0784313725490196,
							["r"] = 0.0784313725490196,
						},
						["height"] = 20,
						["fontflags"] = "OUTLINE",
						["texture"] = "Blizzard",
					},
					["background"] = {
						["color"] = {
							["a"] = 0.350000023841858,
							["b"] = 0.0784313725490196,
							["g"] = 0.0784313725490196,
							["r"] = 0.0784313725490196,
						},
						["bordertexture"] = "Pixel",
						["height"] = 158.000122070313,
					},
					["returnaftercombat"] = true,
					["modeincombat"] = "DPS",
					["barfontflags"] = "OUTLINE",
					["buttons"] = {
						["report"] = false,
						["menu"] = false,
						["mode"] = false,
						["segment"] = false,
						["reset"] = false,
					},
				}, -- [1]
			},
			["columns"] = {
				["Threat_TPS"] = true,
			},
			["tooltiprows"] = 5,
			["showranks"] = false,
			["icon"] = {
				["hide"] = true,
			},
			["tooltippos"] = "topleft",
			["reset"] = {
				["join"] = 1,
			},
		}
		Skada.db:SetProfile("MaximumOverdrive")
	end
	if xCTSavedDB and T.IsAddOnLoaded("xCT+") then
		xCTSavedDB["profiles"]["MaximumOverdrive"] = {
				["spells"] = {
				["merge"] = {
					[172965] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Delvar",
					},
					[201645] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Revil Cost (Cudgel of Light)",
					},
					[183058] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Quest: Cry Thunder!",
					},
					[207778] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[146075] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Nature Damage (Windwalker Monks)",
					},
					[49821] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[205224] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[199667] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[194238] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[222024] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[199668] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[130654] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[209569] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[124682] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[193473] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[47666] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 256,
					},
					[88082] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[23881] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[222026] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[190919] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Guardian Orbs (Gates of Valor)",
					},
					[198137] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[193091] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Harpoon Stomp (Q: Huln's War - The Arrival)",
					},
					[148187] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 0,
					},
					[164603] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(World Zone)|r",
						["desc"] = "Shredder",
					},
					[114942] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[122128] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 0,
					},
					[159238] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Shattered Hand",
					},
					[196733] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[131900] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "HUNTER",
						["desc"] = 0,
					},
					[52042] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[772] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[2061] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[114911] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[210723] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[222029] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[132157] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[152150] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "ROGUE",
						["desc"] = 0,
					},
					[120692] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "PRIEST",
						["desc"] = 0,
					},
					[49184] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[149276] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Legendary Cloaks)|r",
						["desc"] = "Legedary Cloak for Hunters",
					},
					[88084] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[222030] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[205231] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[221647] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Vindicator Boros (Hammer of the Righteous)",
					},
					[222031] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[196545] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[20153] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[113092] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[198590] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[209577] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[50622] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[207150] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[213474] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Skyhorn Strafing Run (Q: Justice Rains from Above)",
					},
					[34861] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[114083] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[171764] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Vivianne",
					},
					[190863] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Call of the Storm (Gates of Valor)",
					},
					[204213] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 256,
					},
					[207407] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[118459] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "HUNTER",
						["desc"] = 253,
					},
					[215775] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[42223] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARLOCK",
						["desc"] = 267,
					},
					[155158] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[55078] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[204598] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[195975] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[1064] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[124081] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[210220] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[215969] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[57841] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "ROGUE",
						["desc"] = 260,
					},
					[120696] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "PRIEST",
						["desc"] = 0,
					},
					[2643] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 0,
					},
					[153564] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[148135] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 0,
					},
					[114852] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[190357] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[148008] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Legendary Cloaks)|r",
						["desc"] = "Legedary Cloak for Casters",
					},
					[188505] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Felmouth Frenzy",
					},
					[55095] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[148009] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Legendary Cloaks)|r",
						["desc"] = "Legedary Cloak for Healers",
					},
					[1079] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[146157] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Holy Damage",
					},
					[197385] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[209202] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 66,
					},
					[188443] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[146158] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Arcane Damage (Balance Druids)",
					},
					[204157] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[47750] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 256,
					},
					[196748] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[200389] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[185123] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[210801] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[143924] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Other |cff798BDD(Spells)|r",
						["desc"] = "Item Leech",
					},
					[218594] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Quest: Softening the Target (Terrorfiend)",
					},
					[5374] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "ROGUE",
						["desc"] = 259,
					},
					[197835] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "ROGUE",
						["desc"] = 261,
					},
					[207097] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "HUNTER",
						["desc"] = 253,
					},
					[210291] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[46968] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 0,
					},
					[44461] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[157978] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[114919] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[52174] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 0,
					},
					[205246] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[146162] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Physical Damage (Hunters)",
					},
					[157979] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[115175] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[200009] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Unattended Cannon (Fel Cannonball)",
					},
					[189853] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[89753] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[146160] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Fire, Frost Damage (Mages)",
					},
					[113344] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[157980] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[156000] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[181102] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Raids)|r",
						["desc"] = "Mark Eruption",
					},
					[212338] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[199116] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[222175] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Blood Vanguard (Trample)",
					},
					[187874] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[202347] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 102,
					},
					[146739] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[86040] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[7268] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[205546] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[44425] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[198670] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[202822] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "ROGUE",
						["desc"] = 260,
					},
					[186387] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[157982] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[30455] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[164857] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[207230] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[196278] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[104318] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[191070] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[146166] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Arcane Damage (Mages)",
					},
					[116670] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[222944] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "WARRIOR",
						["desc"] = 73,
					},
					[194392] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 0,
					},
					[205223] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[153640] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[19434] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[77478] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[218321] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[689] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 0,
					},
					[198928] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[219432] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 104,
					},
					[152108] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 267,
					},
					[188389] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[8936] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[2120] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[175806] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Vivianne",
					},
					[31661] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[188196] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[119952] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[200654] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[194522] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[217070] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[191758] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[196100] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[187624] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Legedary Ring: Str DPS",
					},
					[114923] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[191840] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[157977] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[148022] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[227291] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[225311] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[202891] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(Quest Items)|r",
						["desc"] = "Trinket: Lodestone of the Stormbreaker",
					},
					[187625] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Legedary Ring: Int DPS",
					},
					[34914] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[170379] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[203526] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "WARRIOR",
						["desc"] = 73,
					},
					[33917] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 104,
					},
					[147891] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Legendary Cloaks)|r",
						["desc"] = "Legedary Cloak for Melee",
					},
					[214581] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[6572] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 73,
					},
					[187626] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Legedary Ring: Agi DPS",
					},
					[191587] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[214326] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[193439] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[20271] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[212436] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[22703] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[51490] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[202446] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[205065] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[184689] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[192592] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[119611] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[61295] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[146171] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Nature Damage (Elemental Shamans)",
					},
					[157503] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[194509] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 256,
					},
					[210687] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[197465] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 253,
					},
					[205345] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[191037] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "DRUID",
						["desc"] = 102,
					},
					[208899] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[205386] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[215537] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[195256] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[115181] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[196061] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[204301] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 66,
					},
					[157736] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "WARLOCK",
						["desc"] = 267,
					},
					[124507] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[77489] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[198485] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[184427] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Skyfire Deck Gun",
					},
					[116858] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 267,
					},
					[179041] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Murky - Pufferfish",
					},
					[201364] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[146178] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Nature Healing (Druid, Monk)",
					},
					[117418] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[2818] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "ROGUE",
						["desc"] = 259,
					},
					[175814] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Vivianne",
					},
					[162530] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[148859] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[209478] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "PALADIN",
						["desc"] = 66,
					},
					[227681] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[192997] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Wild Carve (Q: Huln's War - The Arrival)",
					},
					[115310] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[12294] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[146177] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Holy Healing (Priest, Paladin)",
					},
					[192231] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[201877] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Revil Cost (Holy Nova)",
					},
					[156287] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARRIOR",
						["desc"] = 0,
					},
					[199658] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[81297] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 0,
					},
					[29722] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 267,
					},
					[197214] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[217207] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 253,
					},
					[96103] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[198483] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[196448] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 267,
					},
					[213011] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[194466] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[203794] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[218677] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[202497] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 102,
					},
					[421] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[203539] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[25504] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[199373] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[199054] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[185656] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Raids)|r",
						["desc"] = "Shadowfel Annihilation",
					},
					[100780] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[198813] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[157997] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[218615] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[205533] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[589] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 0,
					},
					[106785] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[73921] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[110745] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 0,
					},
					[203413] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[194279] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[212739] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[122] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MAGE",
						["desc"] = 0,
					},
					[199581] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[202388] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[121253] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 268,
					},
					[204883] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[196771] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[211052] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[22482] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "ROGUE",
						["desc"] = 260,
					},
					[113780] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "ROGUE",
						["desc"] = 259,
					},
					[173010] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Vivianne",
					},
					[217020] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[218617] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[194153] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 102,
					},
					[195750] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[845] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[209700] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 71,
					},
					[203796] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[42231] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[199552] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[224239] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[213771] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 104,
					},
					[210833] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[596] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[211727] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[211088] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[201628] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[84721] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[88263] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 66,
					},
					[206930] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[211545] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 102,
					},
					[202771] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 102,
					},
					[194858] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[1449] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 62,
					},
					[81269] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[52212] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 0,
					},
					[198030] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[184707] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[184256] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Discordant Chorus",
					},
					[183042] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Quest: Cry Thunder!",
					},
					[194859] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[120361] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "HUNTER",
						["desc"] = 0,
					},
					[153596] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[198756] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[215555] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Quest: The Walk of Shame (Prince Farondis)",
					},
					[70890] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[217694] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[33763] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[189112] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[176017] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Aeda",
					},
					[183811] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 0,
					},
					[193008] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Harpoon Stomp (Q: Huln's War - The Arrival)",
					},
					[59638] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "MAGE",
						["desc"] = 64,
					},
					[100784] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[603] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[12654] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[91778] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[31935] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "PALADIN",
						["desc"] = 66,
					},
					[187708] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[6343] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 73,
					},
					[146061] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Physical Damage (Melee)",
					},
					[155625] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[197800] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "ROGUE",
						["desc"] = 261,
					},
					[191732] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[179021] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Murky - Slime",
					},
					[205273] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PALADIN",
						["desc"] = 70,
					},
					[201633] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[212680] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[77758] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 104,
					},
					[197568] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[148234] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Holy Healing (Priests, Paladins)",
					},
					[48438] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[212744] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[176020] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Aeda",
					},
					[155722] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[192611] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[146063] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Holy Damage",
					},
					[980] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[212621] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[148235] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Nature Healing (Monks, Druids)",
					},
					[118000] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 72,
					},
					[81751] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 256,
					},
					[7922] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARRIOR",
						["desc"] = 73,
					},
					[200166] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[146064] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Arcane Damage (Balance Druids)",
					},
					[179057] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 577,
					},
					[139] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[32175] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[201754] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 253,
					},
					[13812] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "HUNTER",
						["desc"] = 255,
					},
					[182218] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Raids)|r",
						["desc"] = "HFC Construct #2",
					},
					[199656] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "MONK",
						["desc"] = 270,
					},
					[146065] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Shadow Damage (Priests, Warlocks)",
					},
					[211717] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 266,
					},
					[114871] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[213709] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 104,
					},
					[107270] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 0,
					},
					[207194] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[27285] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[179217] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Quest: The Walk of Shame (Prince Farondis)",
					},
					[195292] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[51723] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "ROGUE",
						["desc"] = 259,
					},
					[204959] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[196608] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MONK",
						["desc"] = 0,
					},
					[204065] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 256,
					},
					[197997] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[196528] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[165421] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(World Zone)|r",
						["desc"] = "Shredder",
					},
					[146067] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Fire, Frost Damage (Mages)",
					},
					[14914] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[180223] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Raids)|r",
						["desc"] = "HFC Construct #4",
					},
					[187394] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "WARLOCK",
						["desc"] = 267,
					},
					[190780] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[185779] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "ROGUE",
						["desc"] = 260,
					},
					[207771] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[171454] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 253,
					},
					[155166] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 251,
					},
					[215729] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Healing Rain (Lifespring Cavern)",
					},
					[202917] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(Quest Items)|r",
						["desc"] = "Trinket: Temple Priestess' Charm",
					},
					[132463] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "MONK",
						["desc"] = 0,
					},
					[774] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "DRUID",
						["desc"] = 105,
					},
					[117588] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 262,
					},
					[115767] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "WARRIOR",
						["desc"] = 73,
					},
					[214479] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Flaming Bolas (Q: Bolas Bastion)",
					},
					[146069] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Physical Damage (Hunters)",
					},
					[53652] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "PALADIN",
						["desc"] = 65,
					},
					[210854] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "SHAMAN",
						["desc"] = 263,
					},
					[184075] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Prophecy of Fear",
					},
					[209069] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "SHAMAN",
						["desc"] = 264,
					},
					[187780] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Aspirant's Conviction (Skold-Ashil)",
					},
					[164812] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 0,
					},
					[227255] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[146070] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Arcane Damage (Mages)",
					},
					[158221] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[218797] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Broll Bearmantle (Moonfire)",
					},
					[185098] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 4.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Soothing Breeze",
					},
					[204069] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 104,
					},
					[49998] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[201642] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cff93BE3DLegion|r™ |cff798BDD(World Zones)|r",
						["desc"] = "Revil Cost (Holy Fire)",
					},
					[175796] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Bodyguards)|r",
						["desc"] = "Bodyguard: Delvar",
					},
					[146071] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Nature Damage (Elemental Shamans)",
					},
					[50842] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 250,
					},
					[32546] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 257,
					},
					[185099] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MONK",
						["desc"] = 269,
					},
					[106830] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[187727] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DEMONHUNTER",
						["desc"] = 581,
					},
					[157981] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "MAGE",
						["desc"] = 63,
					},
					[194311] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[30108] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "WARLOCK",
						["desc"] = 265,
					},
					[217676] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[105421] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "PALADIN",
						["desc"] = 0,
					},
					[132467] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 1.5,
						["class"] = "MONK",
						["desc"] = 0,
					},
					[192660] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "ROGUE",
						["desc"] = 259,
					},
					[207267] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DEATHKNIGHT",
						["desc"] = 252,
					},
					[191043] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "HUNTER",
						["desc"] = 254,
					},
					[146159] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Shadow Damage (Priests, Warlocks)",
					},
					[15407] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2,
						["class"] = "PRIEST",
						["desc"] = 258,
					},
					[146137] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffF1A864Mists of Pandaria|r™ |cff798BDD(Trinkets)|r",
						["desc"] = "Physical Damage (Melee)",
					},
					[184280] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 3.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Items)|r",
						["desc"] = "Mirror of the Blademaster",
					},
					[164815] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 2.5,
						["class"] = "DRUID",
						["desc"] = 0,
					},
					[202028] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "DRUID",
						["desc"] = 103,
					},
					[182635] = {
						["enabled"] = true,
						["prep"] = 0,
						["interval"] = 0.5,
						["class"] = "|cffA32C12Warlords of Draenor|r™ |cff798BDD(Raids)|r",
						["desc"] = "HFC Construct #1",
					},
				},
			},
			["frames"] = {
				["general"] = {
					["fontOutline"] = "2OUTLINE",
					["font"] = "Expressway",
					["colors"] = {
						["auras"] = {
							["colors"] = {
								["debuffsGained"] = {
									["color"] = {
										1, -- [1]
										0.1, -- [2]
										0.1, -- [3]
									},
								},
								["buffsGained"] = {
									["color"] = {
										1, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["buffsFaded"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["debuffsFaded"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
							},
						},
						["killingBlow"] = {
							["color"] = {
								0.2, -- [1]
								1, -- [2]
								0.2, -- [3]
							},
						},
						["combat"] = {
							["colors"] = {
								["combatLeaving"] = {
									["color"] = {
										0.1, -- [1]
										1, -- [2]
										0.1, -- [3]
									},
								},
								["combatEntering"] = {
									["color"] = {
										1, -- [1]
										0.1, -- [2]
										0.1, -- [3]
									},
								},
							},
						},
						["interrupts"] = {
							["color"] = {
								1, -- [1]
								0.5, -- [2]
								0, -- [3]
							},
						},
						["reputation"] = {
							["colors"] = {
								["reputationGain"] = {
									["color"] = {
										0.1, -- [1]
										0.1, -- [2]
										1, -- [3]
									},
								},
								["reputationLoss"] = {
									["color"] = {
										1, -- [1]
										0.1, -- [2]
										0.1, -- [3]
									},
								},
							},
						},
						["lowResources"] = {
							["colors"] = {
								["lowResourcesMana"] = {
									["color"] = {
										1, -- [1]
										0.1, -- [2]
										0.1, -- [3]
									},
								},
								["lowResourcesHealth"] = {
									["color"] = {
										1, -- [1]
										0.1, -- [2]
										0.1, -- [3]
									},
								},
							},
						},
						["honorGains"] = {
							["color"] = {
								0.1, -- [1]
								0.1, -- [2]
								1, -- [3]
							},
						},
						["dispells"] = {
							["colors"] = {
								["dispellBuffs"] = {
									["color"] = {
										0, -- [1]
										1, -- [2]
										0.5, -- [3]
									},
								},
								["dispellStolen"] = {
									["color"] = {
										0.31, -- [1]
										0.71, -- [2]
										1, -- [3]
									},
								},
								["dispellDebuffs"] = {
									["color"] = {
										1, -- [1]
										0, -- [2]
										0.5, -- [3]
									},
								},
							},
						},
					},
					["fontSize"] = 20,
					["enabledFrame"] = false,
				},
				["power"] = {
					["fontOutline"] = "2OUTLINE",
					["font"] = "Expressway",
					["enabledFrame"] = false,
					["colors"] = {
						["color_SOUL_SHARDS"] = {
							["color"] = {
								0.5, -- [1]
								0.32, -- [2]
								0.55, -- [3]
							},
						},
						["color_HOLY_POWER"] = {
							["color"] = {
								0.95, -- [1]
								0.9, -- [2]
								0.6, -- [3]
							},
						},
						["color_MANA"] = {
							["color"] = {
								0, -- [1]
								0, -- [2]
								1, -- [3]
							},
						},
						["color_FOCUS"] = {
							["color"] = {
								1, -- [1]
								0.5, -- [2]
								0.25, -- [3]
							},
						},
						["color_CHI"] = {
							["color"] = {
								0.71, -- [1]
								1, -- [2]
								0.92, -- [3]
							},
						},
						["color_RAGE"] = {
							["color"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
							},
						},
						["color_ENERGY"] = {
							["color"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
							},
						},
						["color_RUNIC_POWER"] = {
							["color"] = {
								0, -- [1]
								0.82, -- [2]
								1, -- [3]
							},
						},
						["color_RUNES"] = {
							["color"] = {
								0.5, -- [1]
								0.5, -- [2]
								0.5, -- [3]
							},
						},
						["color_ECLIPSE_positive"] = {
							["color"] = {
								0.8, -- [1]
								0.82, -- [2]
								0.6, -- [3]
							},
						},
						["color_ECLIPSE_negative"] = {
							["color"] = {
								0.3, -- [1]
								0.52, -- [2]
								0.9, -- [3]
							},
						},
					},
				},
				["healing"] = {
					["enableRealmNames"] = false,
					["fontSize"] = 12,
					["showFriendlyHealers"] = false,
					["fontOutline"] = "2OUTLINE",
					["visibilityTime"] = 2,
					["Width"] = 67,
					["Y"] = -3,
					["font"] = "Expressway",
					["colors"] = {
						["healingTakenCritical"] = {
							["color"] = {
								0.1, -- [1]
								1, -- [2]
								0.1, -- [3]
							},
						},
						["healingTaken"] = {
							["color"] = {
								0.1, -- [1]
								0.75, -- [2]
								0.1, -- [3]
							},
						},
						["healingTakenPeriodic"] = {
							["color"] = {
								0.1, -- [1]
								0.5, -- [2]
								0.1, -- [3]
							},
						},
						["shieldTaken"] = {
							["color"] = {
								0.6, -- [1]
								0.65, -- [2]
								1, -- [3]
							},
						},
						["healingTakenPeriodicCritical"] = {
							["color"] = {
								0.1, -- [1]
								0.5, -- [2]
								0.1, -- [3]
							},
						},
					},
					["Height"] = 257,
					["X"] = -204,
				},
				["outgoing"] = {
					["fontSize"] = 12,
					["fontOutline"] = "2OUTLINE",
					["visibilityTime"] = 2,
					["Width"] = 123,
					["font"] = "Expressway",
					["colors"] = {
						["genericDamage"] = {
							["color"] = {
								1, -- [1]
								0.82, -- [2]
								0, -- [3]
							},
						},
						["healingSpells"] = {
							["colors"] = {
								["healingOut"] = {
									["color"] = {
										0.1, -- [1]
										0.75, -- [2]
										0.1, -- [3]
									},
								},
								["shieldOut"] = {
									["color"] = {
										0.6, -- [1]
										0.65, -- [2]
										1, -- [3]
									},
								},
								["healingOutPeriodic"] = {
									["color"] = {
										0.1, -- [1]
										0.5, -- [2]
										0.1, -- [3]
									},
								},
							},
						},
						["spellSchools"] = {
							["colors"] = {
								["SpellSchool_Nature"] = {
									["color"] = {
										0.3, -- [1]
										1, -- [2]
										0.3, -- [3]
									},
								},
								["SpellSchool_Arcane"] = {
									["color"] = {
										1, -- [1]
										0.5, -- [2]
										1, -- [3]
									},
								},
								["SpellSchool_Frost"] = {
									["color"] = {
										0.5, -- [1]
										1, -- [2]
										1, -- [3]
									},
								},
								["SpellSchool_Physical"] = {
									["color"] = {
										1, -- [1]
										1, -- [2]
										0, -- [3]
									},
								},
								["SpellSchool_Shadow"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										1, -- [3]
									},
								},
								["SpellSchool_Holy"] = {
									["color"] = {
										1, -- [1]
										0.9, -- [2]
										0.5, -- [3]
									},
								},
								["SpellSchool_Fire"] = {
									["color"] = {
										1, -- [1]
										0.5, -- [2]
										0, -- [3]
									},
								},
							},
						},
						["misstypesOut"] = {
							["color"] = {
								0.5, -- [1]
								0.5, -- [2]
								0.5, -- [3]
							},
						},
					},
					["Height"] = 262,
					["X"] = 282,
				},
				["critical"] = {
					["fontSize"] = 12,
					["fontOutline"] = "2OUTLINE",
					["visibilityTime"] = 2,
					["Width"] = 96,
					["Y"] = -2,
					["font"] = "Expressway",
					["colors"] = {
						["genericDamageCritical"] = {
							["color"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
							},
						},
						["healingSpells"] = {
							["colors"] = {
								["healingOutCritical"] = {
									["color"] = {
										0.1, -- [1]
										1, -- [2]
										0.1, -- [3]
									},
								},
							},
						},
					},
					["Height"] = 261,
					["X"] = 197,
				},
				["procs"] = {
					["fontSize"] = 18,
					["iconsSize"] = 18,
					["fontOutline"] = "2OUTLINE",
					["Y"] = 288,
					["X"] = -2,
					["colors"] = {
						["spellReactive"] = {
							["color"] = {
								1, -- [1]
								0.82, -- [2]
								0, -- [3]
							},
						},
						["spellProc"] = {
							["color"] = {
								1, -- [1]
								0.82, -- [2]
								0, -- [3]
							},
						},
					},
					["font"] = "Expressway",
					["enabledFrame"] = false,
				},
				["loot"] = {
					["fontOutline"] = "2OUTLINE",
					["enabledFrame"] = false,
					["font"] = "Expressway",
				},
				["class"] = {
					["font"] = "Expressway",
					["colors"] = {
						["comboPoints"] = {
							["color"] = {
								1, -- [1]
								0.82, -- [2]
								0, -- [3]
							},
						},
						["comboPointsMax"] = {
							["color"] = {
								0, -- [1]
								0.82, -- [2]
								1, -- [3]
							},
						},
					},
					["enabledFrame"] = false,
					["fontOutline"] = "2OUTLINE",
				},
				["damage"] = {
					["fontSize"] = 12,
					["fontOutline"] = "2OUTLINE",
					["visibilityTime"] = 2,
					["insertText"] = "bottom",
					["Width"] = 129,
					["Y"] = -3,
					["font"] = "Expressway",
					["colors"] = {
						["missTypesTaken"] = {
							["colors"] = {
								["missTypeBlock"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeMiss"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeImmune"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeDodge"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeParry"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeResist"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeEvade"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeAbsorb"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeDeflect"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeReflect"] = {
									["color"] = {
										0.5, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
							},
						},
						["damageTakenCritical"] = {
							["color"] = {
								1, -- [1]
								0.1, -- [2]
								0.1, -- [3]
							},
						},
						["spellDamageTaken"] = {
							["color"] = {
								0.75, -- [1]
								0.3, -- [2]
								0.85, -- [3]
							},
						},
						["spellDamageTakenCritical"] = {
							["color"] = {
								0.75, -- [1]
								0.3, -- [2]
								0.85, -- [3]
							},
						},
						["damageTaken"] = {
							["color"] = {
								0.75, -- [1]
								0.1, -- [2]
								0.1, -- [3]
							},
						},
						["missTypesTakenPartial"] = {
							["colors"] = {
								["missTypeBlockPartial"] = {
									["color"] = {
										0.75, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeResistPartial"] = {
									["color"] = {
										0.75, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
								["missTypeAbsorbPartial"] = {
									["color"] = {
										0.75, -- [1]
										0.5, -- [2]
										0.5, -- [3]
									},
								},
							},
						},
					},
					["Height"] = 256,
					["X"] = -279,
				},
			}
			xCT_Plus.db:SetProfile("MaximumOverdrive")
			end
			if RavenDB and T.IsAddOnLoaded("Raven") then
			RavenDB["profiles"]["MaximumOverdrive"] = {
					["BarGroups"] = {
					["PlayerDebuffs"] = {
						["detectDebuffsCastBy"] = "anyone",
						["backdropFill"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["hideSpark"] = false,
						["pointH"] = 24.6999927520752,
						["parentFrame"] = "RealUIPlayerFrame",
						["showNoDuration"] = true,
						["name"] = "PlayerDebuffs",
						["timeOffset"] = 14,
						["timeSort"] = false,
						["spacingX"] = 14,
						["barHeight"] = 5,
						["auto"] = true,
						["pointYT"] = 0.81791665279718,
						["i_spacingX"] = 3,
						["pointW"] = 24.7000253677368,
						["iconOffsetX"] = 0,
						["hideLabel"] = true,
						["useDefaultDimensions"] = false,
						["wrapDirection"] = true,
						["spacingY"] = 5,
						["iconSize"] = 26,
						["filterDebuffTable"] = "PlayerDebuffExclusions",
						["filterCooldownTable"] = "PlayerExclusions",
						["bars"] = {
						},
						["barWidth"] = 20,
						["timeAlign"] = "LEFT",
						["i_spacingY"] = 15,
						["borderColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["pointX"] = 0.320625030199687,
						["configuration"] = 9,
						["iconInset"] = -15,
						["sor"] = "T",
						["maxBars"] = 14,
						["timeInset"] = 16,
						["i_iconSize"] = 30,
						["pointXR"] = 0.666510373254617,
						["scale"] = 0.95,
						["wrap"] = 7,
						["timeFormat"] = 23,
						["backdropColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["filterBuffTable"] = "PlayerExclusions",
						["detectDebuffs"] = true,
						["iconAlign"] = "RIGHT",
						["filterDebuffSpells"] = true,
						["pointY"] = 0.159212980958498,
						["hideBar"] = true,
						["iconOffset"] = 7,
					},
					["PlayerBuffs"] = {
						["backdropFill"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["hideSpark"] = false,
						["growDirection"] = false,
						["parentFrame"] = "RealUIPlayerFrame",
						["name"] = "PlayerBuffs",
						["timeOffset"] = 14,
						["timeSort"] = false,
						["spacingX"] = 8,
						["anchorX"] = -63,
						["minimumDuration"] = false,
						["filterBuffList"] = {
						},
						["auto"] = true,
						["pointYT"] = 0.858379611591578,
						["i_iconSize"] = 25,
						["i_spacingX"] = 2,
						["detectBuffs"] = true,
						["pointW"] = 28.7500197410584,
						["iconOffsetX"] = 0,
						["anchorPoint"] = "LEFT",
						["hideLabel"] = true,
						["useDefaultDimensions"] = false,
						["spacingY"] = 7,
						["iconSize"] = 25,
						["filterDebuffTable"] = "PlayerExclusions",
						["playerSort"] = true,
						["checkTimeLeft"] = true,
						["i_hideClock"] = false,
						["filterDuration"] = 67,
						["bars"] = {
						},
						["barWidth"] = 20,
						["timeAlign"] = "LEFT",
						["i_spacingY"] = 15,
						["iconAlign"] = "RIGHT",
						["barHeight"] = 5,
						["pointX"] = 0.300078143278758,
						["scale"] = 1.15,
						["filterBuffSpells"] = true,
						["configuration"] = 9,
						["minimumTimeLeft"] = false,
						["filterTimeLeft"] = 67,
						["sor"] = "T",
						["iconInset"] = -15,
						["maxBars"] = 5,
						["timeInset"] = 16,
						["pointH"] = 28.7500021934509,
						["pointXR"] = 0.684947888106108,
						["desaturate"] = true,
						["wrap"] = 5,
						["timeFormat"] = 23,
						["detectBuffsCastBy"] = "anyone",
						["backdropColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["filterBuffTable"] = "PlayerExclusions",
						["borderColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["pointY"] = 0.115000012998229,
						["hideBar"] = true,
						["iconOffset"] = 7,
					},
					["Buffs"] = {
						["backdropFill"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["hideSpark"] = false,
						["pointH"] = 32.9999847412109,
						["showNoDuration"] = true,
						["name"] = "Buffs",
						["timeOffset"] = 14,
						["spacingX"] = 8,
						["auto"] = true,
						["reverseSort"] = true,
						["pointYT"] = 0.00555545728391942,
						["i_spacingX"] = 3,
						["detectBuffs"] = true,
						["pointW"] = 32.9999847412109,
						["iconOffsetX"] = 0,
						["anchorPoint"] = "TOPRIGHT",
						["hideLabel"] = true,
						["useDefaultDimensions"] = false,
						["spacingY"] = 5,
						["iconSize"] = 33,
						["filterDebuffTable"] = "PlayerDebuffExclusions",
						["checkTimeLeft"] = true,
						["filterCooldownTable"] = "ClassBuffs",
						["filterDuration"] = 60,
						["bars"] = {
						},
						["barWidth"] = 20,
						["timeAlign"] = "LEFT",
						["i_spacingY"] = 15,
						["borderColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["iconAlign"] = "RIGHT",
						["timeSort"] = false,
						["pointX"] = 0.9765625,
						["configuration"] = 9,
						["filterTimeLeft"] = 60,
						["sor"] = "T",
						["anchorFrame"] = "RealUIPositionersBuffs",
						["maxBars"] = 40,
						["timeInset"] = 16,
						["growDirection"] = false,
						["pointXR"] = 0.00625000794728597,
						["iconInset"] = -15,
						["wrap"] = 20,
						["timeFormat"] = 23,
						["detectBuffsCastBy"] = "anyone",
						["i_iconSize"] = 30,
						["backdropColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["filterBuffTable"] = "PlayerExclusions",
						["barHeight"] = 5,
						["pointY"] = 0.963888997835399,
						["hideBar"] = true,
						["iconOffset"] = 7,
					},
					["TargetBuffs"] = {
						["filterBuffSpells"] = true,
						["backdropFill"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["hideSpark"] = false,
						["pointH"] = 28.7500021934509,
						["parentFrame"] = "RealUITargetFrame",
						["showNoDuration"] = true,
						["detectBuffsCastBy"] = "anyone",
						["name"] = "TargetBuffs",
						["timeOffset"] = 14,
						["timeSort"] = false,
						["spacingX"] = 8,
						["filterBuffList"] = {
						},
						["filterBuffTypes"] = false,
						["auto"] = true,
						["pointYT"] = 0.858379611591578,
						["i_spacingX"] = 3,
						["detectBuffs"] = true,
						["pointW"] = 28.7499517440796,
						["iconOffsetX"] = 0,
						["hideLabel"] = true,
						["useDefaultDimensions"] = false,
						["spacingY"] = 7,
						["iconSize"] = 25,
						["filterDebuffTable"] = "PlayerExclusions",
						["playerSort"] = true,
						["filterCooldownTable"] = "PlayerExclusions",
						["bars"] = {
						},
						["timeAlign"] = "LEFT",
						["i_spacingY"] = 15,
						["borderColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["iconAlign"] = "RIGHT",
						["pointX"] = 0.684010416666667,
						["scale"] = 1.15,
						["desaturateFriend"] = true,
						["configuration"] = 9,
						["sor"] = "T",
						["i_iconSize"] = 30,
						["maxBars"] = 5,
						["timeInset"] = 16,
						["pointXR"] = 0.301015650133292,
						["iconInset"] = -15,
						["wrap"] = 5,
						["timeFormat"] = 23,
						["detectBuffsMonitor"] = "target",
						["backdropColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["filterBuffTable"] = "TargetExclusions",
						["barHeight"] = 5,
						["desaturate"] = true,
						["pointY"] = 0.115000012998229,
						["barWidth"] = 20,
						["hideBar"] = true,
						["iconOffset"] = 7,
					},
					["TargetDebuffs"] = {
						["backdropFill"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["hideSpark"] = false,
						["parentFrame"] = "RealUITargetFrame",
						["showNoDuration"] = true,
						["name"] = "TargetDebuffs",
						["timeOffset"] = 14,
						["timeSort"] = false,
						["spacingX"] = 14,
						["barHeight"] = 5,
						["barColors"] = "Standard",
						["auto"] = true,
						["pointYT"] = 0.829351810752932,
						["i_spacingX"] = 3,
						["pointW"] = 24.7000253677368,
						["iconOffsetX"] = 0,
						["hideLabel"] = true,
						["detectOtherDebuffs"] = false,
						["useDefaultDimensions"] = false,
						["wrapDirection"] = true,
						["spacingY"] = 5,
						["iconSize"] = 26,
						["iconColors"] = "Normal",
						["filterDebuffTable"] = "TargetExclusions",
						["filterDebuffList"] = {
						},
						["bars"] = {
						},
						["barWidth"] = 20,
						["timeAlign"] = "LEFT",
						["i_spacingY"] = 15,
						["desaturate"] = true,
						["iconAlign"] = "RIGHT",
						["borderColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["pointX"] = 0.54822922706604,
						["scale"] = 0.95,
						["iconInset"] = -15,
						["configuration"] = 9,
						["filterDebuffTypes"] = false,
						["sor"] = "T",
						["detectDebuffsMonitor"] = "target",
						["i_iconSize"] = 30,
						["maxBars"] = 14,
						["timeInset"] = 16,
						["pointH"] = 24.700009059906,
						["pointXR"] = 0.438906176388264,
						["wrap"] = 7,
						["timeFormat"] = 23,
						["backdropColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["filterBuffTable"] = "PlayerExclusions",
						["detectDebuffs"] = true,
						["filterDebuffSpells"] = true,
						["pointY"] = 0.147777807902901,
						["hideBar"] = true,
						["iconOffset"] = 7,
					},
				},
				["Durations"] = {
					["Evasion"] = 15,
					[193396] = 12,
					[32752] = 5,
					["Blade Twisting"] = 8,
					["Jade Spirit"] = 12,
					[20707] = 900,
					[194858] = 8,
					["Grace"] = 15,
					["Food"] = 20,
					[19832] = 90,
					["Anticipation"] = 15,
					[146218] = 20,
					["Windswept Pages"] = 20,
					[48707] = 5,
					[196606] = 15,
					[133630] = 20,
					["Arcane Missiles!"] = 20,
					[99506] = 5,
					["Revealing Strike"] = 15,
					["Paralytic Poison"] = 15,
					["Leeching Poison"] = 3600.022,
					["Shallow Insight"] = 15,
					[186289] = 10,
					["Recently Bandaged"] = 60,
					[105771] = 1.5,
					[689] = 5.448,
					[186258] = 9,
					["River's Song"] = 7,
					["Kidney Shot"] = 2,
					["Deserter"] = 900,
					["Enlightenment"] = 10,
					["First Aid"] = 8,
					[100555] = 40,
					["Adrenaline Rush"] = 20,
					[195181] = 30,
					["Sprint"] = 8,
					["Tricks of the Trade"] = 6,
					["Cheap Shot"] = 4,
					[188290] = 9.902,
					[110660] = 5,
					["Cloak of Shadows"] = 5,
					[23958] = 10,
					[603] = 18.159,
					[77535] = 10,
					[81141] = 15,
					[206930] = 8,
					["Earthbind"] = 5,
					[45839] = 120,
					["Slice and Dice"] = 27,
					["Rupture"] = 12,
					["Combat Readiness"] = 20,
					[190831] = 3600,
					["Power Word: Shield"] = 15,
					["Dancing Steel"] = 12,
					["Vendetta"] = 20,
					[2479] = 30,
					["Forbearance"] = 60,
					["Drink"] = 20,
					[44867] = 60,
					[99390] = 180,
					[190927] = 3,
					[29235] = 3600.021,
					[97128] = 900,
					["Moderate Insight"] = 15,
					["Garrote"] = 18,
					[61684] = 16,
					["Recuperate"] = 24,
					["Weakened Soul"] = 15,
					["Blind"] = 60,
					[190931] = 12,
					["Harmony"] = 20,
					["Deadly Poison"] = 3600.022,
					["Hand of Protection"] = 10,
					["Resurrection Sickness"] = 600,
					["Deep Insight"] = 15,
					["Frostbolt"] = 9,
					["Killing Spree"] = 2,
					["Plague of Ages"] = 9,
					[190837] = 3600,
					[126236] = 15,
					[104773] = 8,
					["Eye of Vengeance"] = 10,
					[45348] = 180.064,
					[228128] = 60,
					[186257] = 3,
					[108416] = 20,
					["Hurricane"] = 12,
					[193440] = 2.724,
					["Blindside"] = 10,
					[99257] = 60,
					["Vanish"] = 3,
					["Arrow of Time"] = 20,
					[98619] = 30,
					[13812] = 10,
					["Rejuvenation"] = 12.597,
					[46021] = 60,
					["Honorless Target"] = 30,
					[55078] = 31.199,
					["Paralysis"] = 4,
					[113942] = 90,
					[185855] = 12,
					[118922] = 8,
				},
				["muteSFX"] = true,
				["Conditions"] = {
					["HUNTER"] = {
						["Aspect Missing"] = {
							["tests"] = {
								["Player Status"] = {
									["level"] = 80,
									["levelRanged"] = 1,
									["minEclipsePower"] = 0,
								},
								["Spell Ready"] = {
									["gcd"] = false,
								},
							},
						},
						["Check Aspect!"] = {
							["tests"] = {
								["Player Status"] = {
									["level"] = 80,
									["levelRanged"] = 1,
									["minEclipsePower"] = 0,
								},
							},
						},
						["No Pet!"] = {
							["tests"] = {
								["Player Status"] = {
									["levelRanged"] = 1,
									["minEclipsePower"] = 0,
									["level"] = 80,
								},
							},
						},
						["Trueshot Aura Missing"] = {
							["tests"] = {
								["Player Status"] = {
									["level"] = 80,
									["levelRanged"] = 1,
									["minEclipsePower"] = 0,
								},
								["Spell Ready"] = {
									["gcd"] = false,
								},
							},
						},
					},
					["WARRIOR"] = {
					},
					["WARLOCK"] = {
						["No Demonic Empowerment"] = {
							["enabled"] = true,
							["testResult"] = true,
							["notify"] = true,
							["tooltip"] = true,
							["associatedSpell"] = "Demonic Empowerment",
							["name"] = "No Demonic Empowerment",
							["dependencies"] = {
							},
							["result"] = true,
							["tests"] = {
								["Player Status"] = {
									["levelOffHand"] = 1,
									["minShards"] = 1,
									["minShadowOrbs"] = 1,
									["levelMainHand"] = 1,
									["minChi"] = 1,
									["minLunarPower"] = 0,
									["minHolyPower"] = 1,
									["enable"] = false,
									["minComboPoints"] = 5,
									["level"] = 85,
									["minPower"] = 100,
									["minHealth"] = 100,
								},
								["All Buffs"] = {
									["unit"] = "pet",
									["enable"] = false,
									["toggle"] = 0,
									["isMine"] = true,
									["auras"] = {
										"Demonic Empowerment", -- [1]
									},
								},
							},
						},
						["No Pet!"] = {
							["tests"] = {
								["Player Status"] = {
									["levelOffHand"] = 1,
									["minShards"] = 1,
									["levelMainHand"] = 1,
									["minChi"] = 1,
									["minLunarPower"] = 0,
									["minHolyPower"] = 1,
									["minShadowOrbs"] = 1,
									["minComboPoints"] = 5,
									["level"] = 85,
									["minPower"] = 100,
									["minHealth"] = 100,
								},
							},
							["result"] = false,
							["testResult"] = false,
						},
					},
					["SHAMAN"] = {
						["Cleanse Spirit (Magic)"] = {
							["tests"] = {
								["Debuff Type"] = {
									["toggle"] = false,
								},
								["Spell Ready"] = {
									["notUsable"] = false,
									["gcd"] = false,
								},
								["Player Status"] = {
									["levelOffHand"] = 1,
									["minShards"] = 1,
									["levelMainHand"] = 1,
									["minEclipsePower"] = 0,
									["minHolyPower"] = 1,
									["minHealth"] = 100,
									["minComboPoints"] = 5,
									["level"] = 80,
									["minPower"] = 100,
									["levelRanged"] = 1,
								},
							},
							["result"] = false,
							["testResult"] = false,
						},
						["Cleanse Spirit (Curse)"] = {
							["tests"] = {
								["Debuff Type"] = {
									["toggle"] = false,
								},
								["Spell Ready"] = {
									["notUsable"] = false,
									["gcd"] = false,
								},
							},
							["result"] = false,
							["testResult"] = false,
						},
						["Shield Missing"] = {
							["tests"] = {
								["Player Status"] = {
									["levelOffHand"] = 1,
									["minShards"] = 1,
									["levelMainHand"] = 1,
									["minEclipsePower"] = 0,
									["minHolyPower"] = 1,
									["minHealth"] = 100,
									["minComboPoints"] = 5,
									["level"] = 80,
									["minPower"] = 100,
									["levelRanged"] = 1,
								},
								["Spell Ready"] = {
									["notUsable"] = false,
									["gcd"] = false,
								},
							},
							["result"] = false,
							["testResult"] = false,
						},
						["Weapon Buff Missing"] = {
							["tests"] = {
								["Player Status"] = {
									["levelOffHand"] = 1,
									["minShards"] = 1,
									["levelMainHand"] = 1,
									["minEclipsePower"] = 0,
									["minHolyPower"] = 1,
									["minHealth"] = 100,
									["minComboPoints"] = 5,
									["level"] = 80,
									["minPower"] = 100,
									["levelRanged"] = 1,
								},
								["Spell Ready"] = {
									["notUsable"] = false,
									["gcd"] = false,
								},
							},
							["result"] = false,
							["testResult"] = false,
						},
					},
					["ROGUE"] = {
						["Lethal Poison Missing"] = {
							["associatedSpell"] = "#2823",
							["tests"] = {
								["Player Status"] = {
									["inInstance"] = true,
									["isMounted"] = 0,
									["inGroup"] = true,
									["inBattleground"] = true,
									["checkLevel"] = true,
									["inArena"] = true,
									["inCombat"] = 0,
								},
							},
						},
						["Non-Lethal Poison Missing"] = {
							["associatedSpell"] = "#5761",
							["tests"] = {
								["Player Status"] = {
									["inInstance"] = true,
									["isMounted"] = 0,
									["inGroup"] = true,
									["checkLevel"] = true,
									["inArena"] = true,
									["inBattleground"] = true,
								},
							},
						},
					},
					["DEATHKNIGHT"] = {
					},
				},
			},
			Raven.db:SetProfile("MaximumOverdrive")
		end
		if DBM_AllSavedOptions and T.IsAddOnLoaded("DBM-Core") then
				DBM_AllSavedOptions["profiles"]["MaximumOverdrive"] = {
					["SpecialWarningFontSize"] = 50,
					["HUDTextureOverride"] = false,
					["DontShowFarWarnings"] = true,
					["ChosenVoicePack"] = "None",
					["DontShowHudMap2"] = false,
					["AlwaysPlayVoice"] = false,
					["ShowSWarningsInChat"] = false,
					["HideApplicantAlerts"] = 0,
					["HUDAlpha1"] = 0.5,
					["StatusEnabled"] = true,
					["InfoFrameX"] = 345.560028076172,
					["RangeFrameX"] = 50,
					["AlwaysShowSpeedKillTimer"] = true,
					["RangeFrameY"] = -50,
					["FilterSayAndYell"] = false,
					["EnableModels"] = true,
					["SpecialWarningFlashAlph3"] = 0,
					["ArrowPoint"] = "TOP",
					["SWarnNameInNote"] = true,
					["FakeBWVersion"] = false,
					["InfoFramePoint"] = "BOTTOMLEFT",
					["CRT_Enabled"] = false,
					["SpecialWarningFlashCol2"] = {
						1, -- [1]
						0.5, -- [2]
						0, -- [3]
					},
					["WarningAlphabetical"] = true,
					["WarningFont"] = "Interface\\AddOns\\ElvUI\\media\\fonts\\Expressway.ttf",
					["CheckGear"] = true,
					["SpecialWarningX"] = 0,
					["WorldBossAlert"] = false,
					["RaidWarningPosition"] = {
						["Y"] = -185,
						["X"] = 0,
						["Point"] = "TOP",
					},
					["DontShowPT2"] = false,
					["MCMessageShown"] = false,
					["DontShowSpecialWarnings"] = true,
					["ShowMinimapButton"] = false,
					["MoviesSeen"] = {
						["11821"] = true,
					},
					["ShowQueuePop"] = true,
					["ShowAllVersions"] = true,
					["DebugMode"] = false,
					["HUDTexture3"] = "highlight",
					["SpecialWarningFontCol"] = {
						1, -- [1]
						0.7, -- [2]
						0, -- [3]
					},
					["WarningFontStyle"] = "OUTLINE",
					["InfoFrameY"] = 210.760009765625,
					["ChatFrame"] = "DEFAULT_CHAT_FRAME",
					["WarningIconRight"] = false,
					["UseSoundChannel"] = "Master",
					["ShowCountdownText"] = false,
					["ShowRespawn"] = true,
					["PTCountThreshold"] = 5,
					["HUDSize2"] = 5,
					["ShowFakedRaidWarnings"] = false,
					["FilterDispel"] = true,
					["DebugLevel"] = 1,
					["LFDEnhance"] = true,
					["SpecialWarningFlashDura1"] = 0.4,
					["DontShowPTNoID"] = false,
					["HideGarrisonToasts"] = true,
					["RangeFramePoint"] = "CENTER",
					["SpecialWarningFontShadow"] = false,
					["RLReadyCheckSound"] = true,
					["WOTLKTWMessageShown"] = false,
					["HideObjectivesFrame"] = true,
					["SpecialWarningFlashCol1"] = {
						1, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["DontShowPTText"] = false,
					["SWarnClassColor"] = true,
					["SpecialWarningFlashCol5"] = {
						0.2, -- [1]
						1, -- [2]
						1, -- [3]
					},
					["HelpMessageVersion"] = 2,
					["DontShowHealthFrame"] = false,
					["AFKHealthWarning"] = false,
					["ForumsMessageShown"] = 15061,
					["SpecialWarningDuration"] = 2,
					["AlwaysShowHealthFrame"] = false,
					["LatencyThreshold"] = 250,
					["SpecialWarningSound"] = "Sound\\Spells\\PVPFlagTaken.ogg",
					["RangeFrameRadarY"] = 185.999816894531,
					["NewsMessageShown"] = 5,
					["ShowWarningsInChat"] = true,
					["HUDSizeOverride"] = false,
					["SpecialWarningSound3"] = "Sound\\Creature\\KilJaeden\\KILJAEDEN02.ogg",
					["CountdownVoice2"] = "Kolt",
					["AutoAcceptGuildInvite"] = false,
					["ShowGuildMessages"] = true,
					["ArrowPosX"] = 0,
					["ArrowPosY"] = -150,
					["AITimer"] = true,
					["SpecialWarningFlashDura3"] = 1,
					["MovieFilter"] = "AfterFirst",
					["HPFramePoint"] = "BOTTOMRIGHT",
					["SpecialWarningPoint"] = "TOP",
					["SpecialWarningSound4"] = "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg",
					["HUDColor1"] = {
						1, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["SpecialWarningFlashDura5"] = 1,
					["DisableSFX"] = false,
					["AutologBosses"] = false,
					["SpecialWarningFlashDura4"] = 0.7,
					["DontRestoreIcons"] = false,
					["SpecialWarningFlashAlph4"] = 0.4,
					["SpecialWarningFlashCol3"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["WarningColors"] = {
						{
							["r"] = 0.411764705882353,
							["g"] = 0.8,
							["b"] = 0.941176470588235,
						}, -- [1]
						{
							["r"] = 0.949019607843137,
							["g"] = 0.949019607843137,
							["b"] = 0,
						}, -- [2]
						{
							["r"] = 1,
							["g"] = 0.501960784313726,
							["b"] = 0,
						}, -- [3]
						{
							["r"] = 1,
							["g"] = 0.101960784313725,
							["b"] = 0.101960784313725,
						}, -- [4]
					},
					["SpecialWarningFlashRepeat1"] = false,
					["SWarningAlphabetical"] = true,
					["AdvancedAutologBosses"] = false,
					["BlockNoteShare"] = false,
					["HUDAlpha4"] = 0.5,
					["FilterInterrupt"] = true,
					["DontShowCTCount"] = false,
					["ModelSoundValue"] = "Short",
					["FilterSelfHud"] = true,
					["DontShowInfoFrame"] = false,
					["HUDTexture2"] = "highlight",
					["RangeFrameRadarPoint"] = "BOTTOM",
					["SpecialWarningY"] = 75,
					["RaidWarningSound"] = "",
					["CustomSounds"] = 0,
					["RangeFrameUpdates"] = "Average",
					["AutoCorrectTimer"] = false,
					["ShortTimerText"] = true,
					["WarningY"] = 260,
					["DontRestoreRange"] = false,
					["HUDAlpha3"] = 0.5,
					["SpecialWarningFlashRepeat3"] = true,
					["RoleSpecAlert"] = true,
					["WhisperStats"] = false,
					["VoiceOverSpecW2"] = "DefaultOnly",
					["ShowEngageMessage"] = true,
					["DontPlayPTCountdown"] = false,
					["SpecialWarningFlashAlph5"] = 0.5,
					["DontShowBossAnnounces"] = false,
					["HealthFrameWidth"] = 200,
					["RangeFrameLocked"] = true,
					["WarningIconLeft"] = false,
					["RangeFrameSound1"] = "none",
					["HPFrameY"] = 257,
					["WarningFontSize"] = 20.8266906738281,
					["HUDColor4"] = {
						0, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["SpecialWarningFlashDura2"] = 0.4,
					["LastRevision"] = 0,
					["HUDColorOverride"] = false,
					["SettingsMessageShown"] = true,
					["PGMessageShown"] = false,
					["HUDTexture4"] = "highlight",
					["SpecialWarningFontStyle"] = "THICKOUTLINE",
					["FilterInterruptNoteName"] = false,
					["DontSetIcons"] = false,
					["BigBrotherAnnounceToRaid"] = false,
					["DontShowUserTimers"] = false,
					["SpecialWarningFlashRepeat4"] = false,
					["DisableStatusWhisper"] = false,
					["SpecialWarningFont"] = "Fonts\\FRIZQT__.TTF",
					["SpecialWarningFlashRepeat2"] = false,
					["InfoFrameShowSelf"] = false,
					["SpecialWarningFlashRepeat5"] = true,
					["AutoRespond"] = true,
					["HealthFrameGrowUp"] = false,
					["HUDSize4"] = 5,
					["HideBossEmoteFrame"] = true,
					["DontPlayCountdowns"] = false,
					["ShowBigBrotherOnCombatStart"] = false,
					["HUDSize3"] = 5,
					["FilterTankSpec"] = true,
					["SpecialWarningFlashAlph1"] = 0.3,
					["ShowDefeatMessage"] = true,
					["HUDAlphaOverride"] = false,
					["DontShowRangeFrame"] = false,
					["HUDTexture1"] = "highlight",
					["WarningDuration"] = 4,
					["WarningFontShadow"] = true,
					["RangeFrameFrames"] = "radar",
					["CountdownVoice"] = "Corsica",
					["DontShowBossTimers"] = false,
					["DontShowFlexMessage"] = false,
					["SpecialWarningFlashCol4"] = {
						1, -- [1]
						0, -- [2]
						1, -- [3]
					},
					["HUDColor3"] = {
						1, -- [1]
						0.5, -- [2]
						0, -- [3]
					},
					["HUDAlpha2"] = 0.5,
					["WorldBossNearAlert"] = false,
					["WarningX"] = 0,
					["HPFrameMaxEntries"] = 5,
					["SpecialWarningFlashRepeatAmount"] = 2,
					["AutoAcceptFriendInvite"] = false,
					["WarningIconChat"] = true,
					["CountdownVoice3v2"] = "HoTS_R",
					["HideGuildChallengeUpdates"] = true,
					["SpecialWarningSound5"] = "Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.ogg",
					["DontSendYells"] = false,
					["ShowPizzaMessage"] = true,
					["RangeFrameSound2"] = "none",
					["HideTooltips"] = false,
					["SpecialWarningFlashAlph2"] = 0.3,
					["HUDColor2"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["Enabled"] = true,
					["HealthFrameLocked"] = false,
					["BCTWMessageShown"] = false,
					["HUDSize1"] = 5,
					["SpecialWarningSound2"] = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg",
					["WarningPoint"] = "TOP",
					["DontShowPTCountdownText"] = false,
					["LogOnlyRaidBosses"] = false,
					["StripServerName"] = true,
					["RangeFrameRadarX"] = -414.000274658203,
					["AutoReplySound"] = true,
					["HPFrameX"] = -334.999755859375,
					["SpamBlockBossWhispers"] = true,
					["InfoFrameLocked"] = true,
					["CATATWMessageShown"] = false,
					["ShowFlashFrame"] = true,
				},
			},
		}	
		DBM-Core.DBM_AllSavedOptions:SetProfile("MaximumOverdrive")
	end
end

--I need help below setting up the tables to call for the info above based on their table numbers.


local OverdriveUIInstallTable = {
		["Name"] = "|cff9482c9Overdrive UI|r",
		["Title"] = L["|cff9482c9Overdrive UI|r Installation"],
		["tutorialImage"] = [[Interface\AddOns\ElvUI_OverdriveUI\media\textures\OverdriveUI_Banner]],
		["Pages"] = {
				[1] = function()
					
				[2] = function()
					
				[3] = function()
					
				[4] = function()
				
				[5] = function()
					
		},
		["StepTitles"] = {
		[1] = START,
		[2] = L["OverdriveUI Layout"],
		[3] = L["Chat"],
		[4] = L["Unit Frames"],
		[5] = L["Addon Profiles"],
		[6] = L["Finished"],
	},
	["StepTitlesColorSelected"] = {.53,.53,.93},
}




