local E, L, V, P, G = unpack(ElvUI)


local _G = _G
local pairs, tinsert, tremove, unpack = pairs, tinsert, tremove, unpack


local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local PlaySoundFile = PlaySoundFile
local UIFrameFadeOut = UIFrameFadeOut
local CreateAnimationGroup = CreateAnimationGroup
local CONTINUE, PREVIOUS, UNKNOWN = CONTINUE, PREVIOUS, UNKNOWN
local DPS, TANK, HEALER = DPS, TANK, HEALER


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


--This is where I am trying to firgure out how to get my addon profiles added as well as how to create buttons in the installer 
--for each spec (heals, dps, tank)



