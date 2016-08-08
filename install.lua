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


local CURRENT_PAGE = 0
local MAX_PAGE = 8

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

	--chat
	E.db["chat"]["font"] = "Expressway"
	E.db["chat"]["panelHeight"] = 130
	E.db["chat"]["tabFont"] = "Expressway"
	E.db["chat"]["tabFontSize"] = 10
	E.db["chat"]["panelWidth"] = 340
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
	if SkadaDB and IsAddonLoaded('Skada') then
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
		}
	}		
		elseif SkadaDB and IsAddonLoaded('Skada') then
		SkadaDB['profiles']['MaximumOverheals'] = {
			["windows"] = {
				{
					["titleset"] = false,
					["barheight"] = 19,
					["classicons"] = false,
					["barslocked"] = true,
					["wipemode"] = "Damage taken",
					["y"] = -23.9979248046875,
					["x"] = 185.000701904297,
					["title"] = {
						["color"] = {
							["a"] = 0.550000011920929,
							["r"] = 0.0784313725490196,
							["g"] = 0.0784313725490196,
							["b"] = 0.0784313725490196,
						},
						["font"] = "Expressway",
						["borderthickness"] = 0,
						["height"] = 20,
						["fontflags"] = "OUTLINE",
						["texture"] = "Blizzard",
					},
					["barfontflags"] = "OUTLINE",
					["point"] = "TOPLEFT",
					["returnaftercombat"] = true,
					["mode"] = "Damage taken",
					["background"] = {
						["color"] = {
							["a"] = 0.350000023841858,
							["r"] = 0.0784313725490196,
							["g"] = 0.0784313725490196,
							["b"] = 0.0784313725490196,
						},
						["height"] = 158.000122070313,
						["bordertexture"] = "Pixel",
					},
					["buttons"] = {
						["report"] = false,
						["menu"] = false,
						["mode"] = false,
						["segment"] = false,
						["reset"] = false,
					},
					["barwidth"] = 156,
					["barbgcolor"] = {
						["a"] = 0.5,
						["r"] = 0.301960784313726,
						["g"] = 0.301960784313726,
						["b"] = 0.301960784313726,
					},
					["barcolor"] = {
						["a"] = 0.5,
						["r"] = 0.227450980392157,
						["g"] = 0.349019607843137,
						["b"] = 1,
					},
					["barfontsize"] = 10,
					["modeincombat"] = "Healing",
					["bartexture"] = "Blizzard",
					["barfont"] = "Expressway",
				}, -- [1]
			},
			["icon"] = {
				["hide"] = true,
			},
			["columns"] = {
				["Threat_TPS"] = true,
			},
			["tooltiprows"] = 5,
			["showranks"] = false,
			["hidedisables"] = false,
			["tooltippos"] = "topleft",
			["reset"] = {
				["leave"] = 2,
				["instance"] = 2,
				["join"] = 2,
			},
		}
	end
	if xCTSavedDB and IsAddonLoaded("xCT+") then
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
		}
	end
			
			--Raven Profiles
			if RavenDB and IsAddonLoaded('Raven') then
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
			}
			elseif RavenDB and IsAddonLoaded('Raven') then
			RavenDB["profiles"]["MaximumOverdrive-Bars"] = { 
				["BarGroups"] = {
				["PlayerDebuffs"] = {
				["desaturateFriend"] = false,
				["borderSaturation"] = 0,
				["detectTracking"] = false,
				["detectDebuffsCastBy"] = "anyone",
				["detectNPCDebuffs"] = false,
				["soundAltExpire"] = "None",
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["anchorLastBar"] = false,
				["timelineSplashY"] = 0,
				["bgNormalAlpha"] = 1,
				["iconFSize"] = 8,
				["showSpecialization"] = "",
				["filterBuffLink"] = true,
				["filterCooldown"] = true,
				["showInstance"] = true,
				["minimumTimeLeft"] = true,
				["filterCooldownSpells"] = false,
				["showVehicle"] = true,
				["borderBrightness"] = 0,
				["showOnlyNoDuration"] = false,
				["hideSpark"] = false,
				["pointH"] = 32.9999847412109,
				["backdropPadH"] = 0,
				["labelOffset"] = 0,
				["texture"] = "Blizzard",
				["timeSpaces"] = false,
				["detectCooldowns"] = false,
				["expireMinimum"] = 0,
				["timelineHeight"] = 25,
				["parentFrame"] = "RealUIPlayerFrame",
				["borderWidth"] = 1,
				["bgColors"] = "Normal",
				["clockReverse"] = true,
				["delayTime"] = 5,
				["showFishing"] = true,
				["backdropEnable"] = false,
				["backdropOffsetX"] = 0,
				["showSolo"] = true,
				["useDefaultFontsAndTextures"] = false,
				["timeIcon"] = false,
				["showNoDuration"] = true,
				["labelShadow"] = false,
				["detectCooldownsBy"] = "player",
				["anchor"] = false,
				["showMounted"] = true,
				["i_iconOffsetY"] = 0,
				["detectBuffsCastBy"] = "player",
				["labelAlpha"] = 1,
				["expireMSBT"] = false,
				["showBuff"] = false,
				["iconMono"] = true,
				["name"] = "PlayerDebuffs",
				["spellTips"] = true,
				["detectAllBuffs"] = false,
				["showCombat"] = true,
				["showEnemy"] = true,
				["showDebuff"] = false,
				["backdropTexture"] = "None",
				["timelineHide"] = false,
				["timeThick"] = false,
				["linkSettings"] = false,
				["i_hideCount"] = true,
				["i_hideBar"] = true,
				["timeOffset"] = 14,
				["timeSort"] = false,
				["i_iconOffsetX"] = 0,
				["timelinePercent"] = 50,
				["spacingX"] = 8,
				["barHeight"] = 5,
				["barColors"] = "Spell",
				["locked"] = true,
				["soundSpellStart"] = false,
				["detectSharedFrostTraps"] = true,
				["setDuration"] = false,
				["anchorX"] = 0,
				["anchorEmpty"] = false,
				["minimumDuration"] = true,
				["combatAlpha"] = 1,
				["noHeaders"] = false,
				["backdropInset"] = 4,
				["showCooldown"] = false,
				["auto"] = true,
				["reverseSort"] = false,
				["noMouse"] = false,
				["filterDebuffLink"] = true,
				["detectInternalCooldowns"] = true,
				["pointYT"] = 0.0527776848435788,
				["pulseStart"] = false,
				["timelineDelta"] = 0,
				["fadeAlpha"] = 1,
				["anchorTips"] = "DEFAULT",
				["timelineExp"] = 3,
				["i_iconSize"] = 30,
				["bgBrightness"] = 0,
				["noDurationFirst"] = false,
				["fgBrightness"] = 0,
				["filterDebuffBars"] = false,
				["showTooltips"] = true,
				["backdropOffsetY"] = 0,
				["timelineOffset"] = 0,
				["filterBuffBars"] = false,
				["detectCastable"] = false,
				["expireLabelColor"] = false,
				["useDefaultColors"] = true,
				["strata"] = "MEDIUM",
				["filterBuff"] = true,
				["detectSpellEffectCooldowns"] = true,
				["i_spacingX"] = 3,
				["bgtexture"] = "Blizzard",
				["disableAlpha"] = false,
				["detectBuffs"] = false,
				["pointW"] = 32.9999847412109,
				["excludeResources"] = false,
				["timelineTexture"] = "Blizzard",
				["expireTimeColor"] = false,
				["timelineWidth"] = 225,
				["labelInset"] = 0,
				["iconOffsetX"] = 0,
				["bgCombatAlpha"] = 1,
				["expireColor"] = false,
				["i_hideSpark"] = false,
				["testStatic"] = 0,
				["hideLabel"] = true,
				["hideCount"] = true,
				["timeCase"] = false,
				["useDefaultDimensions"] = false,
				["snapCenter"] = false,
				["iconOffsetY"] = 0,
				["targetAlpha"] = 1,
				["colorExpiring"] = false,
				["wrapDirection"] = false,
				["uniformDuration"] = 120,
				["spacingY"] = 5,
				["timelineColor"] = false,
				["checkDuration"] = false,
				["detectNPCBuffs"] = false,
				["detectVehicleBuffs"] = false,
				["testTimers"] = 10,
				["iconSize"] = 33,
				["showFriendly"] = true,
				["borderOffset"] = 0,
				["i_hideLabel"] = true,
				["iconColors"] = "None",
				["filterDebuffTable"] = "PlayerDebuffExclusions",
				["timelineSplash"] = true,
				["detectEnrageBuffs"] = false,
				["playerSort"] = false,
				["timelineDuration"] = 300,
				["showParty"] = true,
				["labelFSize"] = 10,
				["i_scale"] = 1,
				["checkTimeLeft"] = false,
				["detectSpellCooldowns"] = true,
				["i_hideClock"] = true,
				["noLabels"] = false,
				["filterCooldownTable"] = "PlayerExclusions",
				["timeFSize"] = 10,
				["soundAltStart"] = "None",
				["soundSpellEnd"] = false,
				["timeOutline"] = true,
				["noTargets"] = false,
				["flashExpiring"] = false,
				["filterDuration"] = 120,
				["borderTexture"] = "None",
				["expireTime"] = 5,
				["labelOutline"] = true,
				["merged"] = false,
				["detectStealable"] = false,
				["timeColor"] = {
				},
				["bars"] = {
				},
				["iconOutline"] = true,
				["timeAlign"] = "LEFT",
				["hide"] = false,
				["timelineSwitch"] = 2,
				["combatTips"] = true,
				["filterCooldownLink"] = true,
				["detectEffectBuffs"] = false,
				["detectSharedShouts"] = true,
				["i_spacingY"] = 15,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["showRaid"] = true,
				["filterBuffSpells"] = false,
				["showNoDurationBackground"] = false,
				["pulseEnd"] = false,
				["enabled"] = true,
				["soundAltEnd"] = "None",
				["detectDispellable"] = false,
				["bgSaturation"] = 0,
				["fgSaturation"] = 1,
				["pointX"] = 0.976041666666667,
				["showNotInstance"] = true,
				["desaturate"] = false,
				["alpha"] = 1,
				["labelCenter"] = false,
				["labelAlign"] = "MIDDLE",
				["showResting"] = true,
				["detectSharedShocks"] = true,
				["filterDebuffSpells"] = true,
				["expirePercentage"] = 0,
				["i_barWidth"] = 20,
				["iconShadow"] = false,
				["timelineSplashX"] = 0,
				["showBattleground"] = true,
				["bgAlpha"] = 0,
				["detectSharedStances"] = true,
				["configuration"] = 9,
				["timeMono"] = true,
				["soundSpellExpire"] = false,
				["filterDebuff"] = true,
				["mouseAlpha"] = 1,
				["anchorColumn"] = true,
				["fade"] = false,
				["iconHide"] = false,
				["detectRuneCooldowns"] = false,
				["timeAlpha"] = 1,
				["detectInflictable"] = false,
				["detectBoss"] = false,
				["detectAllDebuffs"] = false,
				["headerGaps"] = false,
				["detectPotionCooldowns"] = true,
				["detectMagicBuffs"] = false,
				["timelineAlternate"] = true,
				["labelFont"] = "Expressway",
				["timelineAlpha"] = 1,
				["sor"] = "T",
				["detectOtherBuffs"] = false,
				["filterTimeLeft"] = 120,
				["iconMouse"] = true,
				["includeTotems"] = false,
				["detectDebuffsMonitor"] = "player",
				["backdropWidth"] = 16,
				["fgAlpha"] = 0.5,
				["detectVehicleDebuffs"] = false,
				["backdropPadding"] = 16,
				["maxBars"] = 20,
				["ghost"] = false,
				["timeInset"] = 16,
				["growDirection"] = false,
				["labelColor"] = {
				},
				["showNotBlizz"] = true,
				["hideClock"] = true,
				["i_hideValue"] = false,
				["pointXR"] = 0.0067708412806193,
				["timeFont"] = "Expressway",
				["i_barHeight"] = 5,
				["showOOC"] = true,
				["colorMSBT"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["hideIcon"] = false,
				["iconColor"] = {
				},
				["targetFirst"] = false,
				["scale"] = 1,
				["iconInset"] = -15,
				["hideValue"] = false,
				["wrap"] = 20,
				["timeFormat"] = 23,
				["iconFont"] = "pixel_large",
				["iconAlpha"] = 1,
				["detectBuffsMonitor"] = "player",
				["testLoop"] = false,
				["criticalMSBT"] = false,
				["detectBossBuffs"] = false,
				["iconThick"] = false,
				["filterCooldownBars"] = false,
				["anchorY"] = 0,
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["barWidth"] = 20,
				["detectSharedCrusader"] = true,
				["flashTime"] = 5,
				["casterTips"] = true,
				["detectOtherCooldowns"] = true,
				["filterBuffTable"] = "PlayerExclusions",
				["detectDebuffs"] = true,
				["labelThick"] = false,
				["backdropPanel"] = "None",
				["detectTrinketCooldowns"] = true,
				["fillBars"] = false,
				["detectWeaponBuffs"] = false,
				["labelWrap"] = false,
				["showArena"] = true,
				["anchorRow"] = false,
				["checkCondition"] = false,
				["timeShadow"] = false,
				["showBlizz"] = true,
				["showFocusTarget"] = true,
				["replay"] = false,
				["replayTime"] = 5,
				["pointY"] = 0.91666677027574,
				["timelineLabels"] = false,
				["backdropPadW"] = 0,
				["setOnlyLongDuration"] = false,
				["hideBar"] = true,
				["iconAlign"] = "RIGHT",
				["i_hideIcon"] = false,
				["labelMono"] = true,
				["i_showTooltips"] = true,
				["iconOffset"] = 7,
			},
			["PlayerBuffs"] = {
				["iconShadow"] = false,
				["borderSaturation"] = 0,
				["detectTracking"] = false,
				["detectDebuffsCastBy"] = "player",
				["detectNPCDebuffs"] = false,
				["soundAltExpire"] = "None",
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["anchorLastBar"] = false,
				["timelineSplashY"] = 0,
				["bgNormalAlpha"] = 1,
				["iconFSize"] = 8,
				["showSpecialization"] = "",
				["filterBuffLink"] = true,
				["filterCooldown"] = true,
				["showInstance"] = true,
				["setOnlyLongDuration"] = false,
				["filterCooldownSpells"] = false,
				["showVehicle"] = true,
				["borderBrightness"] = 0,
				["showOnlyNoDuration"] = false,
				["hideSpark"] = false,
				["pointH"] = 16.5000073432922,
				["backdropPadH"] = 0,
				["labelOffset"] = 0,
				["texture"] = "Blizzard",
				["timeSpaces"] = false,
				["detectCooldowns"] = false,
				["expireMinimum"] = 0,
				["timelineHeight"] = 25,
				["borderWidth"] = 1,
				["bgColors"] = "Normal",
				["clockReverse"] = true,
				["delayTime"] = 5,
				["showFishing"] = true,
				["backdropEnable"] = false,
				["backdropOffsetX"] = 0,
				["showSolo"] = true,
				["useDefaultFontsAndTextures"] = false,
				["timeIcon"] = false,
				["showNoDuration"] = false,
				["labelShadow"] = false,
				["detectCooldownsBy"] = "player",
				["anchor"] = false,
				["showMounted"] = true,
				["i_iconOffsetY"] = 0,
				["detectBuffsMonitor"] = "player",
				["labelAlpha"] = 1,
				["expireMSBT"] = false,
				["showBuff"] = false,
				["i_barHeight"] = 5,
				["name"] = "PlayerBuffs",
				["spellTips"] = true,
				["detectAllBuffs"] = false,
				["showCombat"] = true,
				["showEnemy"] = true,
				["showDebuff"] = false,
				["backdropTexture"] = "None",
				["timelineHide"] = false,
				["timeThick"] = false,
				["linkSettings"] = false,
				["i_hideCount"] = true,
				["i_hideBar"] = true,
				["timeOffset"] = 0,
				["timeMono"] = true,
				["i_iconOffsetX"] = 0,
				["timelinePercent"] = 50,
				["spacingX"] = 8,
				["casterTips"] = true,
				["barColors"] = "Spell",
				["locked"] = true,
				["soundSpellStart"] = false,
				["detectSharedFrostTraps"] = true,
				["setDuration"] = false,
				["anchorX"] = -63,
				["anchorEmpty"] = false,
				["minimumDuration"] = false,
				["combatAlpha"] = 1,
				["noHeaders"] = false,
				["backdropInset"] = 4,
				["filterBuffList"] = {
				},
				["auto"] = true,
				["reverseSort"] = false,
				["noMouse"] = false,
				["filterDebuffLink"] = true,
				["detectInternalCooldowns"] = true,
				["pointYT"] = 0.820740698138704,
				["pulseStart"] = false,
				["timelineDelta"] = 0,
				["fadeAlpha"] = 1,
				["anchorTips"] = "DEFAULT",
				["timelineExp"] = 3,
				["i_iconSize"] = 25,
				["bgBrightness"] = 0,
				["noDurationFirst"] = false,
				["fgBrightness"] = 0,
				["filterDebuffBars"] = false,
				["showTooltips"] = true,
				["backdropOffsetY"] = 0,
				["timelineOffset"] = 0,
				["filterBuffBars"] = false,
				["labelCenter"] = true,
				["expireLabelColor"] = false,
				["useDefaultColors"] = true,
				["strata"] = "MEDIUM",
				["filterBuff"] = true,
				["detectSpellEffectCooldowns"] = true,
				["i_spacingX"] = 2,
				["bgtexture"] = "Blizzard",
				["disableAlpha"] = false,
				["detectBuffs"] = true,
				["pointW"] = 251.899983215332,
				["excludeResources"] = false,
				["timelineTexture"] = "Blizzard",
				["expireTimeColor"] = false,
				["timelineWidth"] = 225,
				["labelInset"] = 0,
				["iconOffsetX"] = 0,
				["bgCombatAlpha"] = 1,
				["expireColor"] = false,
				["i_hideSpark"] = false,
				["anchorPoint"] = "LEFT",
				["testStatic"] = 0,
				["hideLabel"] = false,
				["hideCount"] = true,
				["timeCase"] = false,
				["useDefaultDimensions"] = false,
				["snapCenter"] = false,
				["iconOffsetY"] = 0,
				["targetAlpha"] = 1,
				["colorExpiring"] = false,
				["wrapDirection"] = false,
				["uniformDuration"] = 120,
				["spacingY"] = 7,
				["timelineColor"] = false,
				["checkDuration"] = false,
				["detectNPCBuffs"] = false,
				["detectVehicleBuffs"] = false,
				["testTimers"] = 8,
				["iconSize"] = 15,
				["showFriendly"] = true,
				["borderOffset"] = 0,
				["i_hideLabel"] = true,
				["iconColors"] = "None",
				["filterDebuffTable"] = "PlayerExclusions",
				["timelineSplash"] = true,
				["detectEnrageBuffs"] = false,
				["playerSort"] = true,
				["timelineDuration"] = 300,
				["showParty"] = true,
				["labelFSize"] = 10,
				["i_scale"] = 1,
				["checkTimeLeft"] = true,
				["detectSpellCooldowns"] = true,
				["i_hideClock"] = false,
				["noLabels"] = false,
				["filterCooldownTable"] = "ClassBuffs",
				["timeFSize"] = 10,
				["soundAltStart"] = "None",
				["soundSpellEnd"] = false,
				["timeOutline"] = true,
				["noTargets"] = false,
				["flashExpiring"] = false,
				["filterDuration"] = 67,
				["borderTexture"] = "None",
				["expireTime"] = 5,
				["labelOutline"] = true,
				["merged"] = false,
				["detectStealable"] = false,
				["timeColor"] = {
				},
				["bars"] = {
				},
				["iconOutline"] = true,
				["timeAlign"] = "RIGHT",
				["hide"] = false,
				["timelineSwitch"] = 2,
				["detectEffectBuffs"] = false,
				["combatTips"] = true,
				["filterCooldownLink"] = true,
				["detectOtherCooldowns"] = true,
				["showRaid"] = true,
				["i_spacingY"] = 15,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["iconAlign"] = "CENTER",
				["showNoDurationBackground"] = false,
				["filterCooldownBars"] = false,
				["timelineLabels"] = false,
				["enabled"] = true,
				["soundAltEnd"] = "None",
				["detectCastable"] = false,
				["i_barWidth"] = 20,
				["fgSaturation"] = 1,
				["pointX"] = 0.320260451634725,
				["showNotInstance"] = true,
				["desaturate"] = true,
				["showResting"] = true,
				["showFocusTarget"] = true,
				["detectSharedShocks"] = true,
				["expirePercentage"] = 0,
				["filterDebuffSpells"] = false,
				["soundSpellExpire"] = false,
				["timelineSplashX"] = 0,
				["detectSharedCrusader"] = true,
				["filterBuffSpells"] = true,
				["detectSharedStances"] = true,
				["showBattleground"] = true,
				["bgAlpha"] = 0,
				["scale"] = 1.1,
				["barHeight"] = 15,
				["configuration"] = 1,
				["filterDebuff"] = true,
				["mouseAlpha"] = 1,
				["fade"] = false,
				["anchorColumn"] = true,
				["detectRuneCooldowns"] = false,
				["iconHide"] = false,
				["detectTrinketCooldowns"] = true,
				["detectInflictable"] = false,
				["detectBoss"] = false,
				["timeSort"] = false,
				["minimumTimeLeft"] = false,
				["headerGaps"] = false,
				["detectPotionCooldowns"] = true,
				["detectMagicBuffs"] = false,
				["timelineAlternate"] = true,
				["labelFont"] = "Expressway",
				["timelineAlpha"] = 1,
				["sor"] = "T",
				["detectOtherBuffs"] = false,
				["filterTimeLeft"] = 67,
				["iconMouse"] = true,
				["includeTotems"] = false,
				["detectDebuffsMonitor"] = "player",
				["detectAllDebuffs"] = false,
				["fgAlpha"] = 0.25,
				["barWidth"] = 214,
				["backdropPadding"] = 16,
				["maxBars"] = 8,
				["ghost"] = false,
				["timeInset"] = 0,
				["growDirection"] = true,
				["iconInset"] = -15,
				["showNotBlizz"] = true,
				["detectVehicleDebuffs"] = false,
				["labelColor"] = {
				},
				["pointXR"] = 0.548541640440623,
				["hideClock"] = true,
				["colorMSBT"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["showOOC"] = true,
				["backdropWidth"] = 16,
				["i_hideValue"] = false,
				["timeFont"] = "Expressway",
				["targetFirst"] = false,
				["hideIcon"] = false,
				["iconColor"] = {
				},
				["timeAlpha"] = 1,
				["wrap"] = 8,
				["timeFormat"] = 23,
				["hideValue"] = false,
				["iconFont"] = "pixel_large",
				["iconAlpha"] = 1,
				["detectBuffsCastBy"] = "anyone",
				["testLoop"] = false,
				["criticalMSBT"] = false,
				["iconMono"] = true,
				["detectBossBuffs"] = false,
				["anchorY"] = 0,
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["iconThick"] = false,
				["flashTime"] = 5,
				["showCooldown"] = false,
				["labelAlign"] = "MIDDLE",
				["detectSharedShouts"] = true,
				["filterBuffTable"] = "PlayerExclusions",
				["detectDebuffs"] = false,
				["labelThick"] = false,
				["backdropPanel"] = "None",
				["alpha"] = 1,
				["fillBars"] = false,
				["detectWeaponBuffs"] = false,
				["labelWrap"] = false,
				["showArena"] = true,
				["anchorRow"] = false,
				["checkCondition"] = false,
				["timeShadow"] = false,
				["showBlizz"] = true,
				["pulseEnd"] = false,
				["replay"] = false,
				["replayTime"] = 5,
				["pointY"] = 0.163981515557354,
				["bgSaturation"] = 0,
				["backdropPadW"] = 0,
				["detectDispellable"] = false,
				["hideBar"] = false,
				["i_hideIcon"] = false,
				["desaturateFriend"] = false,
				["labelMono"] = true,
				["i_showTooltips"] = true,
				["iconOffset"] = 7,
			},
			["Buffs"] = {
				["desaturateFriend"] = false,
				["borderSaturation"] = 0,
				["detectTracking"] = false,
				["detectDebuffsCastBy"] = "player",
				["detectNPCDebuffs"] = false,
				["soundAltExpire"] = "None",
				["backdropFill"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["anchorLastBar"] = false,
				["timelineSplashY"] = 0,
				["bgNormalAlpha"] = 1,
				["iconFSize"] = 8,
				["showSpecialization"] = "",
				["filterBuffLink"] = true,
				["filterCooldown"] = true,
				["showInstance"] = true,
				["minimumTimeLeft"] = true,
				["filterCooldownSpells"] = false,
				["showVehicle"] = true,
				["borderBrightness"] = 0,
				["showOnlyNoDuration"] = false,
				["hideSpark"] = false,
				["growDirection"] = false,
				["backdropPadH"] = 0,
				["labelOffset"] = 0,
				["texture"] = "Plain",
				["timeSpaces"] = false,
				["detectCooldowns"] = false,
				["expireMinimum"] = 0,
				["timelineHeight"] = 25,
				["borderWidth"] = 1,
				["bgColors"] = "Normal",
				["clockReverse"] = true,
				["delayTime"] = 5,
				["showFishing"] = true,
				["backdropEnable"] = false,
				["backdropOffsetX"] = 0,
				["showSolo"] = true,
				["useDefaultFontsAndTextures"] = true,
				["timeIcon"] = false,
				["showNoDuration"] = true,
				["labelShadow"] = false,
				["detectCooldownsBy"] = "player",
				["anchor"] = false,
				["showMounted"] = true,
				["i_iconOffsetY"] = 0,
				["detectBuffsMonitor"] = "player",
				["labelAlpha"] = 1,
				["expireMSBT"] = false,
				["showBuff"] = false,
				["i_barHeight"] = 5,
				["name"] = "Buffs",
				["spellTips"] = true,
				["detectAllBuffs"] = false,
				["showCombat"] = true,
				["showEnemy"] = true,
				["showDebuff"] = false,
				["backdropTexture"] = "None",
				["timelineHide"] = false,
				["timeThick"] = false,
				["linkSettings"] = false,
				["i_hideCount"] = true,
				["i_hideBar"] = true,
				["timeOffset"] = 14,
				["timeSort"] = false,
				["i_iconOffsetX"] = 0,
				["timelinePercent"] = 50,
				["spacingX"] = 8,
				["casterTips"] = true,
				["barColors"] = "Spell",
				["locked"] = true,
				["soundSpellStart"] = false,
				["detectSharedFrostTraps"] = true,
				["setDuration"] = false,
				["anchorX"] = 0,
				["anchorEmpty"] = false,
				["minimumDuration"] = true,
				["combatAlpha"] = 1,
				["noHeaders"] = false,
				["backdropInset"] = 4,
				["showCooldown"] = false,
				["auto"] = true,
				["reverseSort"] = true,
				["noMouse"] = false,
				["filterDebuffLink"] = true,
				["detectInternalCooldowns"] = true,
				["pointYT"] = 0.00555545728391942,
				["pulseStart"] = false,
				["timelineDelta"] = 0,
				["fadeAlpha"] = 1,
				["anchorTips"] = "DEFAULT",
				["timelineExp"] = 3,
				["i_hideIcon"] = false,
				["bgBrightness"] = 0,
				["noDurationFirst"] = false,
				["fgBrightness"] = 0,
				["filterDebuffBars"] = false,
				["showTooltips"] = true,
				["backdropOffsetY"] = 0,
				["timelineOffset"] = 0,
				["filterBuffBars"] = false,
				["detectCastable"] = false,
				["expireLabelColor"] = false,
				["useDefaultColors"] = true,
				["strata"] = "MEDIUM",
				["filterBuff"] = true,
				["detectSpellEffectCooldowns"] = true,
				["i_spacingX"] = 3,
				["detectSharedShouts"] = true,
				["disableAlpha"] = false,
				["detectBuffs"] = true,
				["pointW"] = 32.9999847412109,
				["excludeResources"] = false,
				["timelineTexture"] = "Blizzard",
				["expireTimeColor"] = false,
				["timelineWidth"] = 225,
				["labelInset"] = 0,
				["iconOffsetX"] = 0,
				["bgCombatAlpha"] = 1,
				["expireColor"] = false,
				["i_hideSpark"] = false,
				["anchorPoint"] = "TOPRIGHT",
				["testStatic"] = 0,
				["hideLabel"] = true,
				["hideCount"] = true,
				["timeCase"] = false,
				["useDefaultDimensions"] = false,
				["snapCenter"] = false,
				["iconOffsetY"] = 0,
				["targetAlpha"] = 1,
				["colorExpiring"] = false,
				["wrapDirection"] = false,
				["uniformDuration"] = 120,
				["spacingY"] = 5,
				["timelineColor"] = false,
				["checkDuration"] = false,
				["detectNPCBuffs"] = false,
				["detectVehicleBuffs"] = false,
				["testTimers"] = 10,
				["iconSize"] = 33,
				["showFriendly"] = true,
				["borderOffset"] = 0,
				["i_hideLabel"] = true,
				["iconColors"] = "None",
				["i_hideValue"] = false,
				["timelineSplash"] = true,
				["detectEnrageBuffs"] = false,
				["playerSort"] = false,
				["hideValue"] = false,
				["showParty"] = true,
				["labelFSize"] = 8,
				["iconFont"] = "pixel_large",
				["checkTimeLeft"] = true,
				["detectSpellCooldowns"] = true,
				["i_hideClock"] = true,
				["noLabels"] = false,
				["filterCooldownTable"] = "ClassBuffs",
				["timeFSize"] = 8,
				["soundAltStart"] = "None",
				["soundSpellEnd"] = false,
				["timeOutline"] = true,
				["noTargets"] = false,
				["flashExpiring"] = false,
				["filterDuration"] = 60,
				["borderTexture"] = "None",
				["expireTime"] = 5,
				["labelOutline"] = true,
				["merged"] = false,
				["detectStealable"] = false,
				["timeColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["bars"] = {
				},
				["iconOutline"] = true,
				["timeAlign"] = "LEFT",
				["hide"] = false,
				["timelineSwitch"] = 2,
				["detectEffectBuffs"] = false,
				["combatTips"] = true,
				["filterCooldownLink"] = true,
				["filterBuffSpells"] = false,
				["barHeight"] = 5,
				["i_spacingY"] = 15,
				["borderColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["showRaid"] = true,
				["showNoDurationBackground"] = false,
				["filterCooldownBars"] = false,
				["timelineLabels"] = false,
				["enabled"] = true,
				["soundAltEnd"] = "None",
				["filterDebuffTable"] = "PlayerDebuffExclusions",
				["i_barWidth"] = 20,
				["desaturate"] = false,
				["pointX"] = 0.9765625,
				["showNotInstance"] = true,
				["fgSaturation"] = 0,
				["labelCenter"] = false,
				["showResting"] = true,
				["showFocusTarget"] = true,
				["expirePercentage"] = 0,
				["timeShadow"] = false,
				["iconAlign"] = "RIGHT",
				["detectOtherCooldowns"] = true,
				["soundSpellExpire"] = false,
				["setOnlyLongDuration"] = false,
				["labelWrap"] = false,
				["showBattleground"] = true,
				["bgAlpha"] = 0,
				["scale"] = 1,
				["detectSharedStances"] = true,
				["timelineSplashX"] = 0,
				["filterDebuff"] = true,
				["mouseAlpha"] = 1,
				["fade"] = false,
				["anchorColumn"] = true,
				["detectRuneCooldowns"] = false,
				["iconHide"] = false,
				["iconColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["detectTrinketCooldowns"] = true,
				["detectInflictable"] = false,
				["detectBoss"] = false,
				["detectAllDebuffs"] = false,
				["headerGaps"] = false,
				["detectPotionCooldowns"] = true,
				["detectMagicBuffs"] = false,
				["timelineAlternate"] = true,
				["labelFont"] = "Expressway",
				["timelineAlpha"] = 1,
				["sor"] = "T",
				["detectOtherBuffs"] = false,
				["filterTimeLeft"] = 60,
				["iconMouse"] = true,
				["includeTotems"] = false,
				["detectDebuffsMonitor"] = "player",
				["i_scale"] = 1,
				["fgAlpha"] = 1,
				["i_iconSize"] = 30,
				["backdropPadding"] = 16,
				["maxBars"] = 20,
				["ghost"] = false,
				["timeInset"] = 16,
				["detectVehicleDebuffs"] = false,
				["pointH"] = 32.9999847412109,
				["showNotBlizz"] = true,
				["labelColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["hideClock"] = true,
				["pointXR"] = 0.00625000794728597,
				["backdropWidth"] = 16,
				["colorMSBT"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["showOOC"] = true,
				["timeFont"] = "pixel_large",
				["alpha"] = 1,
				["hideIcon"] = false,
				["targetFirst"] = false,
				["anchorFrame"] = "RealUIPositionersBuffs",
				["timeAlpha"] = 1,
				["bgtexture"] = "Plain",
				["wrap"] = 20,
				["timeFormat"] = 23,
				["timelineDuration"] = 300,
				["testLoop"] = false,
				["iconAlpha"] = 1,
				["detectBuffsCastBy"] = "anyone",
				["criticalMSBT"] = false,
				["iconMono"] = true,
				["detectBossBuffs"] = false,
				["iconThick"] = false,
				["anchorY"] = 0,
				["backdropColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["iconInset"] = -15,
				["flashTime"] = 5,
				["pulseEnd"] = false,
				["labelAlign"] = "MIDDLE",
				["detectSharedCrusader"] = true,
				["filterBuffTable"] = "PlayerExclusions",
				["detectDebuffs"] = false,
				["labelThick"] = false,
				["backdropPanel"] = "None",
				["configuration"] = 9,
				["fillBars"] = false,
				["detectWeaponBuffs"] = false,
				["showArena"] = true,
				["iconShadow"] = false,
				["anchorRow"] = false,
				["checkCondition"] = false,
				["filterDebuffSpells"] = false,
				["showBlizz"] = true,
				["detectSharedShocks"] = true,
				["replay"] = false,
				["replayTime"] = 5,
				["pointY"] = 0.963888997835399,
				["bgSaturation"] = 0,
				["backdropPadW"] = 0,
				["detectDispellable"] = false,
				["hideBar"] = true,
				["timeMono"] = true,
				["labelMono"] = true,
				["barWidth"] = 20,
				["i_showTooltips"] = true,
				["iconOffset"] = 7,
			},
			["TargetBuffs"] = {
				["desaturateFriend"] = true,
				["borderSaturation"] = 0,
				["detectTracking"] = false,
				["detectDebuffsCastBy"] = "player",
				["detectNPCDebuffs"] = false,
				["soundAltExpire"] = "None",
				["backdropFill"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["anchorLastBar"] = false,
				["timelineSplashY"] = 0,
				["bgNormalAlpha"] = 1,
				["iconFSize"] = 8,
				["showSpecialization"] = "",
				["filterBuffLink"] = true,
				["filterCooldown"] = true,
				["showInstance"] = true,
				["minimumTimeLeft"] = true,
				["filterCooldownSpells"] = false,
				["showVehicle"] = true,
				["borderBrightness"] = 0,
				["showOnlyNoDuration"] = false,
				["hideSpark"] = false,
				["pointH"] = 27.5,
				["backdropPadH"] = 0,
				["labelOffset"] = 0,
				["hideClock"] = true,
				["timeSpaces"] = false,
				["detectCooldowns"] = false,
				["expireMinimum"] = 0,
				["timelineHeight"] = 25,
				["parentFrame"] = "RealUITargetFrame",
				["borderWidth"] = 1,
				["bgColors"] = "Normal",
				["clockReverse"] = true,
				["delayTime"] = 5,
				["showFishing"] = true,
				["backdropEnable"] = false,
				["backdropOffsetX"] = 0,
				["showSolo"] = true,
				["useDefaultFontsAndTextures"] = true,
				["timeIcon"] = false,
				["showNoDuration"] = true,
				["labelShadow"] = false,
				["detectCooldownsBy"] = "player",
				["anchor"] = false,
				["showMounted"] = true,
				["i_iconOffsetY"] = 0,
				["detectBuffsMonitor"] = "target",
				["labelAlpha"] = 1,
				["expireMSBT"] = false,
				["showBuff"] = false,
				["i_barHeight"] = 5,
				["name"] = "TargetBuffs",
				["spellTips"] = true,
				["detectAllBuffs"] = false,
				["showCombat"] = true,
				["showEnemy"] = true,
				["showDebuff"] = false,
				["backdropTexture"] = "None",
				["timelineHide"] = false,
				["timeThick"] = false,
				["linkSettings"] = false,
				["i_hideCount"] = true,
				["i_hideBar"] = true,
				["timeOffset"] = 0,
				["timeSort"] = false,
				["i_iconOffsetX"] = 0,
				["timelinePercent"] = 50,
				["spacingX"] = 8,
				["casterTips"] = true,
				["barColors"] = "Spell",
				["locked"] = true,
				["soundSpellStart"] = false,
				["detectSharedFrostTraps"] = true,
				["setDuration"] = false,
				["anchorX"] = 0,
				["anchorEmpty"] = false,
				["minimumDuration"] = true,
				["combatAlpha"] = 1,
				["noHeaders"] = false,
				["backdropInset"] = 4,
				["filterBuffList"] = {
				},
				["filterBuffTypes"] = false,
				["auto"] = true,
				["reverseSort"] = false,
				["noMouse"] = false,
				["filterDebuffLink"] = true,
				["detectInternalCooldowns"] = true,
				["pointYT"] = 0.85944442855772,
				["pulseStart"] = false,
				["timelineDelta"] = 0,
				["fadeAlpha"] = 1,
				["anchorTips"] = "DEFAULT",
				["timelineExp"] = 3,
				["i_iconSize"] = 30,
				["bgBrightness"] = 0,
				["noDurationFirst"] = false,
				["fgBrightness"] = 0,
				["filterDebuffBars"] = false,
				["showTooltips"] = true,
				["backdropOffsetY"] = 0,
				["timelineOffset"] = 0,
				["filterBuffBars"] = false,
				["labelCenter"] = true,
				["expireLabelColor"] = false,
				["useDefaultColors"] = true,
				["strata"] = "MEDIUM",
				["filterBuff"] = true,
				["detectSpellEffectCooldowns"] = true,
				["i_spacingX"] = 3,
				["bgtexture"] = "Plain",
				["disableAlpha"] = false,
				["detectBuffs"] = true,
				["pointW"] = 27.4999433517456,
				["excludeResources"] = false,
				["timelineTexture"] = "Blizzard",
				["expireTimeColor"] = false,
				["timelineWidth"] = 225,
				["labelInset"] = 0,
				["iconOffsetX"] = 0,
				["bgCombatAlpha"] = 1,
				["expireColor"] = false,
				["i_hideSpark"] = false,
				["testStatic"] = 0,
				["hideLabel"] = true,
				["hideCount"] = true,
				["timeCase"] = false,
				["useDefaultDimensions"] = false,
				["snapCenter"] = false,
				["iconOffsetY"] = 0,
				["targetAlpha"] = 1,
				["colorExpiring"] = false,
				["wrapDirection"] = false,
				["uniformDuration"] = 120,
				["spacingY"] = 7,
				["timelineColor"] = false,
				["checkDuration"] = false,
				["detectNPCBuffs"] = false,
				["detectVehicleBuffs"] = false,
				["testTimers"] = 10,
				["iconSize"] = 25,
				["showFriendly"] = true,
				["borderOffset"] = 0,
				["i_hideLabel"] = true,
				["iconColors"] = "None",
				["i_hideValue"] = false,
				["timelineSplash"] = true,
				["detectEnrageBuffs"] = false,
				["playerSort"] = true,
				["timelineDuration"] = 300,
				["showParty"] = true,
				["labelFSize"] = 8,
				["i_scale"] = 1,
				["checkTimeLeft"] = false,
				["detectSpellCooldowns"] = true,
				["i_hideClock"] = true,
				["noLabels"] = false,
				["filterCooldownTable"] = "PlayerExclusions",
				["timeFSize"] = 8,
				["soundAltStart"] = "None",
				["soundSpellEnd"] = false,
				["timeOutline"] = true,
				["noTargets"] = false,
				["flashExpiring"] = false,
				["filterDuration"] = 120,
				["borderTexture"] = "None",
				["expireTime"] = 5,
				["labelOutline"] = true,
				["merged"] = false,
				["detectStealable"] = false,
				["timeColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["bars"] = {
				},
				["iconOutline"] = true,
				["timeAlign"] = "RIGHT",
				["hide"] = false,
				["timelineSwitch"] = 2,
				["detectEffectBuffs"] = false,
				["combatTips"] = true,
				["filterCooldownLink"] = true,
				["barHeight"] = 15,
				["showRaid"] = true,
				["i_spacingY"] = 15,
				["detectOtherCooldowns"] = true,
				["iconAlign"] = "CENTER",
				["pulseEnd"] = false,
				["labelAlign"] = "MIDDLE",
				["timelineLabels"] = false,
				["enabled"] = true,
				["soundAltEnd"] = "None",
				["alpha"] = 1,
				["i_barWidth"] = 20,
				["fgSaturation"] = 0,
				["pointX"] = 0.684062569936117,
				["showNotInstance"] = true,
				["desaturate"] = true,
				["showResting"] = true,
				["showFocusTarget"] = true,
				["detectSharedShocks"] = true,
				["soundSpellExpire"] = false,
				["timeShadow"] = false,
				["borderColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["filterBuffSpells"] = true,
				["barWidth"] = 214,
				["timeAlpha"] = 1,
				["detectSharedStances"] = true,
				["showBattleground"] = true,
				["bgAlpha"] = 0,
				["scale"] = 1.1,
				["timeMono"] = true,
				["timelineSplashX"] = 0,
				["filterDebuff"] = true,
				["mouseAlpha"] = 1,
				["fade"] = false,
				["anchorColumn"] = true,
				["detectRuneCooldowns"] = false,
				["iconHide"] = false,
				["detectInflictable"] = false,
				["detectTrinketCooldowns"] = true,
				["detectBoss"] = false,
				["headerGaps"] = false,
				["detectAllDebuffs"] = false,
				["timelineAlternate"] = true,
				["detectPotionCooldowns"] = true,
				["detectMagicBuffs"] = false,
				["timelineAlpha"] = 1,
				["labelFont"] = "Expressway",
				["sor"] = "T",
				["backdropWidth"] = 16,
				["detectOtherBuffs"] = false,
				["filterTimeLeft"] = 120,
				["iconMouse"] = true,
				["includeTotems"] = false,
				["detectDebuffsMonitor"] = "player",
				["growDirection"] = true,
				["fgAlpha"] = 1,
				["detectCastable"] = false,
				["backdropPadding"] = 16,
				["maxBars"] = 5,
				["ghost"] = false,
				["timeInset"] = 0,
				["detectVehicleDebuffs"] = false,
				["labelColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["showNotBlizz"] = true,
				["texture"] = "Plain",
				["filterDebuffTable"] = "PlayerExclusions",
				["pointXR"] = 0.301614542901516,
				["timeFont"] = "pixel_large",
				["colorMSBT"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["showOOC"] = true,
				["hideIcon"] = false,
				["iconColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["i_showTooltips"] = true,
				["targetFirst"] = false,
				["hideValue"] = false,
				["iconFont"] = "pixel_large",
				["testLoop"] = false,
				["wrap"] = 5,
				["timeFormat"] = 23,
				["iconAlpha"] = 1,
				["detectBuffsCastBy"] = "anyone",
				["criticalMSBT"] = false,
				["iconMono"] = true,
				["detectBossBuffs"] = false,
				["iconThick"] = false,
				["filterCooldownBars"] = false,
				["iconInset"] = -15,
				["anchorY"] = 0,
				["backdropColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["flashTime"] = 5,
				["detectSharedShouts"] = true,
				["showCooldown"] = false,
				["detectSharedCrusader"] = true,
				["setOnlyLongDuration"] = false,
				["filterBuffTable"] = "TargetExclusions",
				["detectDebuffs"] = false,
				["labelThick"] = false,
				["backdropPanel"] = "None",
				["configuration"] = 9,
				["fillBars"] = false,
				["detectWeaponBuffs"] = false,
				["labelWrap"] = false,
				["showArena"] = true,
				["anchorRow"] = false,
				["checkCondition"] = false,
				["filterDebuffSpells"] = false,
				["showBlizz"] = true,
				["expirePercentage"] = 0,
				["replay"] = false,
				["replayTime"] = 5,
				["pointY"] = 0.115092605601287,
				["bgSaturation"] = 0,
				["backdropPadW"] = 0,
				["detectDispellable"] = false,
				["hideBar"] = true,
				["showNoDurationBackground"] = false,
				["i_hideIcon"] = false,
				["labelMono"] = true,
				["iconShadow"] = false,
				["iconOffset"] = 7,
			},
			["TargetDebuffs"] = {
				["desaturateFriend"] = false,
				["borderSaturation"] = 0,
				["detectTracking"] = false,
				["detectDebuffsCastBy"] = "player",
				["detectNPCDebuffs"] = false,
				["soundAltExpire"] = "None",
				["backdropFill"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["anchorLastBar"] = false,
				["timelineSplashY"] = 0,
				["bgNormalAlpha"] = 1,
				["iconFSize"] = 8,
				["showSpecialization"] = "",
				["filterBuffLink"] = true,
				["filterCooldown"] = true,
				["showInstance"] = true,
				["detectAllDebuffs"] = false,
				["filterCooldownSpells"] = false,
				["showVehicle"] = true,
				["borderBrightness"] = 0,
				["showOnlyNoDuration"] = false,
				["hideSpark"] = false,
				["growDirection"] = true,
				["backdropPadH"] = 0,
				["labelOffset"] = 0,
				["texture"] = "Blizzard",
				["timeSpaces"] = false,
				["detectCooldowns"] = false,
				["expireMinimum"] = 0,
				["timelineHeight"] = 25,
				["parentFrame"] = "RealUITargetFrame",
				["borderWidth"] = 1,
				["bgColors"] = "Normal",
				["clockReverse"] = true,
				["delayTime"] = 5,
				["showFishing"] = true,
				["backdropEnable"] = false,
				["backdropOffsetX"] = 0,
				["showSolo"] = true,
				["useDefaultFontsAndTextures"] = false,
				["timeIcon"] = false,
				["showNoDuration"] = true,
				["labelShadow"] = false,
				["detectCooldownsBy"] = "player",
				["anchor"] = false,
				["showMounted"] = true,
				["i_iconOffsetY"] = 0,
				["detectBuffsCastBy"] = "player",
				["labelAlpha"] = 1,
				["expireMSBT"] = false,
				["showBuff"] = false,
				["i_barHeight"] = 5,
				["name"] = "TargetDebuffs",
				["spellTips"] = true,
				["detectAllBuffs"] = false,
				["showCombat"] = true,
				["showEnemy"] = true,
				["showDebuff"] = false,
				["backdropTexture"] = "None",
				["timelineHide"] = false,
				["timeThick"] = false,
				["linkSettings"] = false,
				["i_hideCount"] = true,
				["i_hideBar"] = true,
				["timeOffset"] = 0,
				["timeSort"] = false,
				["i_iconOffsetX"] = 0,
				["timelinePercent"] = 50,
				["spacingX"] = 8,
				["barHeight"] = 15,
				["barColors"] = "Standard",
				["locked"] = true,
				["soundSpellStart"] = false,
				["detectSharedFrostTraps"] = true,
				["setDuration"] = false,
				["anchorX"] = 0,
				["anchorEmpty"] = false,
				["minimumDuration"] = true,
				["combatAlpha"] = 1,
				["noHeaders"] = false,
				["backdropInset"] = 4,
				["showCooldown"] = false,
				["auto"] = true,
				["reverseSort"] = false,
				["noMouse"] = false,
				["filterDebuffLink"] = true,
				["detectInternalCooldowns"] = true,
				["pointYT"] = 0.837037011818301,
				["pulseStart"] = false,
				["timelineDelta"] = 0,
				["fadeAlpha"] = 1,
				["anchorTips"] = "DEFAULT",
				["timelineExp"] = 3,
				["i_hideIcon"] = false,
				["bgBrightness"] = 0,
				["noDurationFirst"] = false,
				["fgBrightness"] = 0,
				["filterDebuffBars"] = false,
				["labelMono"] = true,
				["backdropOffsetY"] = 0,
				["timelineOffset"] = 0,
				["filterBuffBars"] = false,
				["labelCenter"] = true,
				["expireLabelColor"] = false,
				["useDefaultColors"] = true,
				["strata"] = "MEDIUM",
				["filterBuff"] = true,
				["detectSpellEffectCooldowns"] = true,
				["i_spacingX"] = 3,
				["bgtexture"] = "Blizzard",
				["disableAlpha"] = false,
				["detectBuffs"] = false,
				["pointW"] = 251.900033569336,
				["excludeResources"] = false,
				["timelineTexture"] = "Blizzard",
				["expireTimeColor"] = false,
				["timelineWidth"] = 225,
				["labelInset"] = 0,
				["iconOffsetX"] = 0,
				["bgCombatAlpha"] = 1,
				["expireColor"] = false,
				["i_hideSpark"] = false,
				["testStatic"] = 0,
				["hideLabel"] = false,
				["hideCount"] = true,
				["timeCase"] = false,
				["detectOtherDebuffs"] = false,
				["useDefaultDimensions"] = false,
				["snapCenter"] = false,
				["iconOffsetY"] = 0,
				["targetAlpha"] = 1,
				["colorExpiring"] = false,
				["wrapDirection"] = false,
				["uniformDuration"] = 120,
				["spacingY"] = 7,
				["timelineColor"] = false,
				["checkDuration"] = false,
				["detectNPCBuffs"] = false,
				["detectVehicleBuffs"] = false,
				["testTimers"] = 10,
				["iconSize"] = 15,
				["showFriendly"] = true,
				["borderOffset"] = 0,
				["backdropWidth"] = 16,
				["iconColors"] = "Normal",
				["filterDebuffTable"] = "TargetExclusions",
				["timelineSplash"] = true,
				["filterDebuffList"] = {
				},
				["detectEnrageBuffs"] = false,
				["playerSort"] = false,
				["timelineDuration"] = 300,
				["showParty"] = true,
				["labelFSize"] = 10,
				["i_scale"] = 1,
				["checkTimeLeft"] = false,
				["detectSpellCooldowns"] = true,
				["i_hideClock"] = true,
				["noLabels"] = false,
				["timeFSize"] = 10,
				["soundAltStart"] = "None",
				["soundSpellEnd"] = false,
				["timeOutline"] = true,
				["noTargets"] = false,
				["flashExpiring"] = false,
				["filterDuration"] = 120,
				["borderTexture"] = "None",
				["expireTime"] = 5,
				["labelOutline"] = true,
				["merged"] = false,
				["detectStealable"] = false,
				["timeColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["bars"] = {
				},
				["iconOutline"] = true,
				["timeAlign"] = "RIGHT",
				["hide"] = false,
				["timelineSwitch"] = 2,
				["detectEffectBuffs"] = false,
				["combatTips"] = true,
				["filterCooldownLink"] = true,
				["minimumTimeLeft"] = true,
				["iconAlign"] = "CENTER",
				["i_spacingY"] = 15,
				["borderColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["showRaid"] = true,
				["labelAlign"] = "MIDDLE",
				["detectSharedShouts"] = true,
				["timelineLabels"] = false,
				["enabled"] = true,
				["soundAltEnd"] = "None",
				["showResting"] = true,
				["bgSaturation"] = 0,
				["desaturate"] = true,
				["pointX"] = 0.548281284968058,
				["showNotInstance"] = true,
				["fgSaturation"] = 1,
				["showFocusTarget"] = true,
				["filterBuffSpells"] = false,
				["detectSharedShocks"] = true,
				["soundSpellExpire"] = false,
				["filterDebuffSpells"] = true,
				["i_barWidth"] = 20,
				["timelineSplashX"] = 0,
				["iconInset"] = -15,
				["iconShadow"] = false,
				["detectSharedStances"] = true,
				["showBattleground"] = true,
				["bgAlpha"] = 0,
				["scale"] = 1.1,
				["timeMono"] = true,
				["configuration"] = 1,
				["filterDebuff"] = true,
				["mouseAlpha"] = 1,
				["fade"] = false,
				["anchorColumn"] = true,
				["detectRuneCooldowns"] = false,
				["iconHide"] = false,
				["detectTrinketCooldowns"] = true,
				["detectBoss"] = false,
				["filterDebuffTypes"] = false,
				["headerGaps"] = false,
				["timelineAlternate"] = true,
				["timelineAlpha"] = 1,
				["detectPotionCooldowns"] = true,
				["detectMagicBuffs"] = false,
				["sor"] = "T",
				["labelFont"] = "Expressway",
				["showNoDurationBackground"] = false,
				["barWidth"] = 214,
				["detectOtherBuffs"] = false,
				["filterTimeLeft"] = 120,
				["iconMouse"] = true,
				["includeTotems"] = false,
				["detectDebuffsMonitor"] = "target",
				["detectVehicleDebuffs"] = false,
				["fgAlpha"] = 0.25,
				["pointH"] = 16.5000073432922,
				["backdropPadding"] = 16,
				["maxBars"] = 8,
				["ghost"] = false,
				["timeInset"] = 0,
				["labelColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["hideClock"] = true,
				["showNotBlizz"] = true,
				["detectCastable"] = false,
				["i_hideLabel"] = true,
				["pointXR"] = 0.320520780881246,
				["i_hideValue"] = false,
				["colorMSBT"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["showOOC"] = true,
				["alpha"] = 1,
				["hideIcon"] = false,
				["iconColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["targetFirst"] = false,
				["i_iconSize"] = 30,
				["hideValue"] = false,
				["timeAlpha"] = 1,
				["wrap"] = 8,
				["timeFormat"] = 23,
				["iconFont"] = "Expressway",
				["iconAlpha"] = 1,
				["detectBuffsMonitor"] = "player",
				["testLoop"] = false,
				["criticalMSBT"] = false,
				["iconMono"] = true,
				["detectBossBuffs"] = false,
				["iconThick"] = false,
				["anchorY"] = 0,
				["backdropColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["filterCooldownBars"] = false,
				["flashTime"] = 5,
				["casterTips"] = true,
				["detectOtherCooldowns"] = true,
				["detectSharedCrusader"] = true,
				["filterBuffTable"] = "PlayerExclusions",
				["detectDebuffs"] = true,
				["labelThick"] = false,
				["backdropPanel"] = "None",
				["detectInflictable"] = false,
				["fillBars"] = false,
				["detectWeaponBuffs"] = false,
				["labelWrap"] = false,
				["showArena"] = true,
				["anchorRow"] = false,
				["checkCondition"] = false,
				["timeShadow"] = false,
				["showBlizz"] = true,
				["expirePercentage"] = 0,
				["replay"] = false,
				["replayTime"] = 5,
				["pointY"] = 0.147685201877758,
				["timeFont"] = "Expressway",
				["backdropPadW"] = 0,
				["detectDispellable"] = false,
				["hideBar"] = false,
				["setOnlyLongDuration"] = false,
				["pulseEnd"] = false,
				["showTooltips"] = true,
				["i_showTooltips"] = true,
				["iconOffset"] = 7,
			},
		},
		["Conditions"] = {
			["HUNTER"] = {
				["Check Aspect!"] = {
					["tests"] = {
						["Player Status"] = {
							["level"] = 80,
							["levelRanged"] = 1,
							["minEclipsePower"] = 0,
						},
					},
				},
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
							["minHealth"] = 100,
							["minHolyPower"] = 1,
							["minEclipsePower"] = 0,
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
							["minHealth"] = 100,
							["minHolyPower"] = 1,
							["minEclipsePower"] = 0,
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
							["minHealth"] = 100,
							["minHolyPower"] = 1,
							["minEclipsePower"] = 0,
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
			["WARLOCK"] = {
				["No Demonic Empowerment"] = {
					["enabled"] = true,
					["testResult"] = true,
					["notify"] = true,
					["tests"] = {
						["Player Status"] = {
							["levelOffHand"] = 1,
							["minShards"] = 1,
							["minChi"] = 1,
							["levelMainHand"] = 1,
							["minShadowOrbs"] = 1,
							["minHealth"] = 100,
							["minHolyPower"] = 1,
							["enable"] = false,
							["minComboPoints"] = 5,
							["level"] = 85,
							["minPower"] = 100,
							["minLunarPower"] = 0,
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
					["associatedSpell"] = "Demonic Empowerment",
					["name"] = "No Demonic Empowerment",
					["dependencies"] = {
					},
					["result"] = true,
					["tooltip"] = true,
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
		},
		["Durations"] = {
			[61684] = 16,
			[193396] = 12,
			[32752] = 5,
			["Moderate Insight"] = 15,
			["Jade Spirit"] = 12,
			[20707] = 900,
			[194858] = 8,
			["Forbearance"] = 60,
			["Food"] = 20,
			[19832] = 90,
			["Anticipation"] = 15,
			[146218] = 20,
			["Windswept Pages"] = 20,
			[196606] = 15,
			["Arcane Missiles!"] = 20,
			[99506] = 5,
			["Revealing Strike"] = 15,
			["Paralytic Poison"] = 15,
			["Leeching Poison"] = 3600.022,
			["Shallow Insight"] = 15,
			[186289] = 10,
			["Recently Bandaged"] = 60,
			[689] = 5.448,
			[186258] = 9,
			["River's Song"] = 7,
			["Kidney Shot"] = 2,
			["Deserter"] = 900,
			["Enlightenment"] = 10,
			["First Aid"] = 8,
			[100555] = 40,
			["Adrenaline Rush"] = 20,
			["Tricks of the Trade"] = 6,
			["Cheap Shot"] = 4,
			[110660] = 5,
			["Cloak of Shadows"] = 5,
			[603] = 18.159,
			["Earthbind"] = 5,
			[45839] = 120,
			["Slice and Dice"] = 27,
			["Rupture"] = 12,
			["Combat Readiness"] = 20,
			["Dancing Steel"] = 12,
			["Vendetta"] = 20,
			[2479] = 30,
			[44867] = 60,
			[99390] = 180,
			[190927] = 3,
			[118922] = 8,
			[97128] = 900,
			["Grace"] = 15,
			["Vanish"] = 3,
			["Drink"] = 20,
			["Recuperate"] = 24,
			["Weakened Soul"] = 15,
			["Power Word: Shield"] = 15,
			[190931] = 12,
			["Blade Twisting"] = 8,
			["Sprint"] = 8,
			["Evasion"] = 15,
			["Hand of Protection"] = 10,
			["Resurrection Sickness"] = 600,
			[193440] = 2.724,
			["Frostbolt"] = 9,
			[98619] = 30,
			["Killing Spree"] = 2,
			["Harmony"] = 20,
			["Deadly Poison"] = 3600.022,
			[104773] = 8,
			["Eye of Vengeance"] = 10,
			[45348] = 180.064,
			[228128] = 60,
			[186257] = 3,
			[108416] = 20,
			["Hurricane"] = 12,
			["Blind"] = 60,
			["Blindside"] = 10,
			[99257] = 60,
			["Garrote"] = 18,
			["Arrow of Time"] = 20,
			["Plague of Ages"] = 9,
			["Deep Insight"] = 15,
			[13812] = 10,
			["Rejuvenation"] = 12.597,
			["Honorless Target"] = 30,
			[46021] = 60,
			["Paralysis"] = 4,
			[113942] = 90,
			[185855] = 12,
			[23958] = 10,
			},
			["muteSFX"] = true,
		}
		
		elseif RavenDB and IsAddonLoaded('Raven') then
		RavenDB["profiles"]["MaximumOverdrive - Bars"] = {
			["Durations"] = {
			["Evasion"] = 15,
			[193396] = 12,
			[32752] = 5,
			["Moderate Insight"] = 15,
			["Jade Spirit"] = 12,
			[194858] = 8,
			["Grace"] = 15,
			["Food"] = 20,
			[19832] = 90,
			["Anticipation"] = 15,
			[146218] = 20,
			["Windswept Pages"] = 20,
			[196606] = 15,
			["Arcane Missiles!"] = 20,
			["Revealing Strike"] = 15,
			["Paralytic Poison"] = 15,
			["Leeching Poison"] = 3600.022,
			["Shallow Insight"] = 15,
			[186289] = 10,
			["Recently Bandaged"] = 60,
			[689] = 5.448,
			[186258] = 9,
			["River's Song"] = 7,
			["Kidney Shot"] = 2,
			["Deserter"] = 900,
			["Enlightenment"] = 10,
			["First Aid"] = 8,
			["Adrenaline Rush"] = 20,
			["Tricks of the Trade"] = 6,
			["Cheap Shot"] = 4,
			["Vanish"] = 3,
			[603] = 18.159,
			["Earthbind"] = 5,
			[45839] = 120,
			["Slice and Dice"] = 27,
			["Rupture"] = 12,
			["Combat Readiness"] = 20,
			["Dancing Steel"] = 12,
			["Vendetta"] = 20,
			["Drink"] = 20,
			[44867] = 60,
			[221886] = 3,
			[46021] = 60,
			[61684] = 16,
			[2479] = 30,
			["Recuperate"] = 24,
			["Weakened Soul"] = 15,
			[118922] = 8,
			[190931] = 12,
			["Harmony"] = 20,
			["Sprint"] = 8,
			["Power Word: Shield"] = 15,
			["Hand of Protection"] = 10,
			["Resurrection Sickness"] = 600,
			[193440] = 2.724,
			["Frostbolt"] = 9,
			["Eye of Vengeance"] = 10,
			["Plague of Ages"] = 9,
			["Blade Twisting"] = 8,
			["Deadly Poison"] = 3600.022,
			[104773] = 8,
			["Cloak of Shadows"] = 5,
			[45348] = 180.064,
			[228128] = 60,
			[186257] = 3,
			[108416] = 20,
			["Hurricane"] = 12,
			["Blind"] = 60,
			["Blindside"] = 10,
			["Forbearance"] = 60,
			["Garrote"] = 18,
			["Arrow of Time"] = 20,
			[23958] = 10,
			["Killing Spree"] = 2,
			[13812] = 10,
			["Rejuvenation"] = 12.597,
			["Honorless Target"] = 30,
			["Deep Insight"] = 15,
			["Paralysis"] = 4,
			[113942] = 90,
			[185855] = 12,
			[190927] = 3,
		},
		["Conditions"] = {
			["HUNTER"] = {
				["Check Aspect!"] = {
					["tests"] = {
						["Player Status"] = {
							["level"] = 80,
							["levelRanged"] = 1,
							["minEclipsePower"] = 0,
						},
					},
				},
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
							["minHealth"] = 100,
							["minHolyPower"] = 1,
							["minEclipsePower"] = 0,
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
							["minHealth"] = 100,
							["minHolyPower"] = 1,
							["minEclipsePower"] = 0,
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
							["minHealth"] = 100,
							["minHolyPower"] = 1,
							["minEclipsePower"] = 0,
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
		},
		["BarGroups"] = {
			["PlayerDebuffs"] = {
				["timeAlign"] = "LEFT",
				["maxBars"] = 14,
				["detectDebuffsCastBy"] = "anyone",
				["spacingX"] = 14,
				["barHeight"] = 5,
				["configuration"] = 9,
				["showNoDuration"] = true,
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hideLabel"] = true,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["iconAlign"] = "RIGHT",
				["i_iconSize"] = 30,
				["useDefaultDimensions"] = false,
				["filterCooldownTable"] = "PlayerExclusions",
				["pointX"] = 0.190000015099843,
				["timeFormat"] = 23,
				["name"] = "PlayerDebuffs",
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["spacingY"] = 5,
				["hideSpark"] = false,
				["sor"] = "T",
				["i_spacingX"] = 3,
				["detectDebuffs"] = true,
				["iconOffset"] = 7,
				["wrapDirection"] = true,
				["wrap"] = 7,
				["pointH"] = 24.700009059906,
				["iconSize"] = 26,
				["timeSort"] = false,
				["filterBuffTable"] = "PlayerExclusions",
				["barWidth"] = 20,
				["scale"] = 0.95,
				["filterDebuffSpells"] = true,
				["pointW"] = 24.6999927520752,
				["iconInset"] = -15,
				["filterDebuffTable"] = "PlayerDebuffExclusions",
				["parentFrame"] = "RealUIPlayerFrame",
				["pointY"] = 0.162731513296793,
				["timeInset"] = 16,
				["i_spacingY"] = 15,
				["auto"] = true,
				["hideBar"] = true,
				["pointYT"] = 0.81439810535904,
				["iconOffsetX"] = 0,
				["bars"] = {
				},
				["pointXR"] = 0.797135405341784,
				["timeOffset"] = 14,
			},
			["PlayerBuffs"] = {
				["timeSort"] = false,
				["maxBars"] = 5,
				["playerSort"] = true,
				["spacingX"] = 8,
				["barHeight"] = 5,
				["configuration"] = 9,
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hideLabel"] = true,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["checkTimeLeft"] = true,
				["i_iconSize"] = 25,
				["useDefaultDimensions"] = false,
				["i_hideClock"] = false,
				["detectBuffsCastBy"] = "anyone",
				["pointX"] = 0.189270833333333,
				["anchorX"] = -63,
				["desaturate"] = true,
				["minimumTimeLeft"] = false,
				["name"] = "PlayerBuffs",
				["iconOffset"] = 7,
				["i_spacingY"] = 15,
				["minimumDuration"] = false,
				["filterDuration"] = 67,
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["spacingY"] = 7,
				["i_spacingX"] = 2,
				["hideBar"] = true,
				["hideSpark"] = false,
				["sor"] = "T",
				["filterBuffTable"] = "PlayerExclusions",
				["timeFormat"] = 23,
				["wrap"] = 5,
				["iconAlign"] = "RIGHT",
				["filterBuffList"] = {
				},
				["pointH"] = 28.7500021934509,
				["iconSize"] = 25,
				["anchorPoint"] = "LEFT",
				["scale"] = 1.15,
				["iconInset"] = -15,
				["auto"] = true,
				["detectBuffs"] = true,
				["pointW"] = 28.7499868392944,
				["filterBuffSpells"] = true,
				["filterDebuffTable"] = "PlayerExclusions",
				["parentFrame"] = "RealUIPlayerFrame",
				["pointY"] = 0.0628240852369052,
				["timeInset"] = 16,
				["pointXR"] = 0.795755215187868,
				["timeAlign"] = "LEFT",
				["filterTimeLeft"] = 67,
				["pointYT"] = 0.910555539352902,
				["iconOffsetX"] = 0,
				["bars"] = {
				},
				["barWidth"] = 20,
				["timeOffset"] = 14,
			},
			["Buffs"] = {
				["timeSort"] = false,
				["maxBars"] = 40,
				["spacingX"] = 8,
				["barHeight"] = 5,
				["configuration"] = 9,
				["showNoDuration"] = true,
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hideLabel"] = true,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["checkTimeLeft"] = true,
				["i_iconSize"] = 30,
				["useDefaultDimensions"] = false,
				["detectBuffsCastBy"] = "anyone",
				["filterCooldownTable"] = "ClassBuffs",
				["pointX"] = 0.9765625,
				["timeFormat"] = 23,
				["name"] = "Buffs",
				["iconOffset"] = 7,
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["spacingY"] = 5,
				["barWidth"] = 20,
				["i_spacingY"] = 15,
				["hideSpark"] = false,
				["sor"] = "T",
				["i_spacingX"] = 3,
				["filterBuffTable"] = "PlayerExclusions",
				["wrap"] = 20,
				["hideBar"] = true,
				["pointXR"] = 0.00625000794728597,
				["growDirection"] = false,
				["iconSize"] = 33,
				["pointH"] = 32.9999847412109,
				["timeInset"] = 16,
				["iconAlign"] = "RIGHT",
				["anchorPoint"] = "TOPRIGHT",
				["detectBuffs"] = true,
				["pointW"] = 32.9999847412109,
				["filterDebuffTable"] = "PlayerDebuffExclusions",
				["reverseSort"] = true,
				["auto"] = true,
				["pointY"] = 0.963888997835399,
				["anchorFrame"] = "RealUIPositionersBuffs",
				["timeAlign"] = "LEFT",
				["filterDuration"] = 60,
				["filterTimeLeft"] = 60,
				["pointYT"] = 0.00555545728391942,
				["iconOffsetX"] = 0,
				["bars"] = {
				},
				["timeOffset"] = 14,
				["iconInset"] = -15,
			},
			["TargetBuffs"] = {
				["filterBuffSpells"] = true,
				["maxBars"] = 5,
				["playerSort"] = true,
				["spacingX"] = 8,
				["barHeight"] = 5,
				["configuration"] = 9,
				["showNoDuration"] = true,
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hideLabel"] = true,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["iconAlign"] = "RIGHT",
				["i_iconSize"] = 30,
				["useDefaultDimensions"] = false,
				["detectBuffsMonitor"] = "target",
				["filterCooldownTable"] = "PlayerExclusions",
				["pointX"] = 0.679817708333333,
				["timeFormat"] = 23,
				["desaturate"] = true,
				["name"] = "TargetBuffs",
				["iconOffset"] = 7,
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["spacingY"] = 7,
				["timeAlign"] = "LEFT",
				["i_spacingX"] = 3,
				["hideSpark"] = false,
				["sor"] = "T",
				["filterBuffTable"] = "TargetExclusions",
				["wrap"] = 5,
				["pointXR"] = 0.305208358466625,
				["timeInset"] = 16,
				["detectBuffsCastBy"] = "anyone",
				["filterBuffList"] = {
				},
				["iconSize"] = 25,
				["desaturateFriend"] = true,
				["scale"] = 1.15,
				["filterBuffTypes"] = false,
				["pointW"] = 28.7499517440796,
				["detectBuffs"] = true,
				["auto"] = true,
				["i_spacingY"] = 15,
				["filterDebuffTable"] = "PlayerExclusions",
				["parentFrame"] = "RealUITargetFrame",
				["pointY"] = 0.0649537110452961,
				["barWidth"] = 20,
				["timeSort"] = false,
				["pointH"] = 28.7500021934509,
				["hideBar"] = true,
				["pointYT"] = 0.908425913544511,
				["iconOffsetX"] = 0,
				["bars"] = {
				},
				["timeOffset"] = 14,
				["iconInset"] = -15,
			},
			["TargetDebuffs"] = {
				["timeAlign"] = "LEFT",
				["maxBars"] = 14,
				["spacingX"] = 14,
				["barHeight"] = 5,
				["configuration"] = 9,
				["showNoDuration"] = true,
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["barColors"] = "Standard",
				["hideLabel"] = true,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["iconAlign"] = "RIGHT",
				["detectOtherDebuffs"] = false,
				["i_iconSize"] = 30,
				["useDefaultDimensions"] = false,
				["pointX"] = 0.67984375,
				["timeFormat"] = 23,
				["desaturate"] = true,
				["filterDebuffTypes"] = false,
				["name"] = "TargetDebuffs",
				["iconOffset"] = 7,
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["spacingY"] = 5,
				["barWidth"] = 20,
				["detectDebuffsMonitor"] = "target",
				["hideSpark"] = false,
				["sor"] = "T",
				["i_spacingX"] = 3,
				["detectDebuffs"] = true,
				["timeInset"] = 16,
				["filterBuffTable"] = "PlayerExclusions",
				["i_spacingY"] = 15,
				["pointH"] = 24.700009059906,
				["iconSize"] = 26,
				["timeSort"] = false,
				["wrap"] = 7,
				["pointXR"] = 0.307291653454304,
				["auto"] = true,
				["filterDebuffSpells"] = true,
				["pointW"] = 24.7000253677368,
				["iconColors"] = "Normal",
				["filterDebuffTable"] = "TargetExclusions",
				["parentFrame"] = "RealUITargetFrame",
				["pointY"] = 0.155694462042289,
				["filterDebuffList"] = {
				},
				["iconInset"] = -15,
				["scale"] = 0.95,
				["hideBar"] = true,
				["pointYT"] = 0.821435156613544,
				["iconOffsetX"] = 0,
				["bars"] = {
				},
				["wrapDirection"] = true,
				["timeOffset"] = 14,
				},
			},
			["muteSFX"] = true,
		}
		
		elseif RavenDB and IsAddonLoaded('Raven') then
		RavenDB["profiles"]["MaximumOverheals-Bars"] = { 
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
					["pointH"] = 32.9999847412109,
					["texture"] = "Blizzard",
					["parentFrame"] = "RealUIPlayerFrame",
					["iconInset"] = -15,
					["useDefaultFontsAndTextures"] = false,
					["showNoDuration"] = true,
					["name"] = "PlayerDebuffs",
					["timeOffset"] = 14,
					["timeSort"] = false,
					["spacingX"] = 8,
					["barHeight"] = 5,
					["auto"] = true,
					["pointYT"] = 0.0527776848435788,
					["i_iconSize"] = 30,
					["i_spacingX"] = 3,
					["bgtexture"] = "Blizzard",
					["pointW"] = 32.9999847412109,
					["iconOffsetX"] = 0,
					["hideLabel"] = true,
					["useDefaultDimensions"] = false,
					["spacingY"] = 5,
					["iconSize"] = 33,
					["filterDebuffTable"] = "PlayerDebuffExclusions",
					["labelFSize"] = 10,
					["filterCooldownTable"] = "PlayerExclusions",
					["timeFSize"] = 10,
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
					["fgSaturation"] = 1,
					["pointX"] = 0.976041666666667,
					["iconAlign"] = "RIGHT",
					["timeFont"] = "Expressway",
					["configuration"] = 9,
					["sor"] = "T",
					["fgAlpha"] = 0.5,
					["maxBars"] = 20,
					["timeInset"] = 16,
					["growDirection"] = false,
					["pointXR"] = 0.0067708412806193,
					["wrap"] = 20,
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
					["pointY"] = 0.91666677027574,
					["hideBar"] = true,
					["iconOffset"] = 7,
				},
				["PlayerBuffs"] = {
					["filterBuffSpells"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["pointH"] = 16.5000073432922,
					["texture"] = "Blizzard",
					["useDefaultFontsAndTextures"] = false,
					["name"] = "PlayerBuffs",
					["timeSort"] = false,
					["spacingX"] = 8,
					["anchorX"] = -63,
					["minimumDuration"] = false,
					["filterBuffList"] = {
					},
					["auto"] = true,
					["pointYT"] = 0.818703676412786,
					["i_iconSize"] = 25,
					["labelCenter"] = true,
					["i_spacingX"] = 2,
					["bgtexture"] = "Blizzard",
					["detectBuffs"] = true,
					["pointW"] = 251.899983215332,
					["iconOffsetX"] = 0,
					["anchorPoint"] = "LEFT",
					["useDefaultDimensions"] = false,
					["spacingY"] = 7,
					["testTimers"] = 8,
					["iconSize"] = 15,
					["filterDebuffTable"] = "PlayerExclusions",
					["playerSort"] = true,
					["labelFSize"] = 10,
					["checkTimeLeft"] = true,
					["i_hideClock"] = false,
					["filterCooldownTable"] = "ClassBuffs",
					["timeFSize"] = 10,
					["filterDuration"] = 67,
					["bars"] = {
					},
					["barWidth"] = 214,
					["timeAlign"] = "RIGHT",
					["i_spacingY"] = 15,
					["fgSaturation"] = 1,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointX"] = 0.189635434150696,
					["desaturate"] = true,
					["scale"] = 1.1,
					["iconInset"] = -15,
					["minimumTimeLeft"] = false,
					["sor"] = "T",
					["filterTimeLeft"] = 67,
					["fgAlpha"] = 0.25,
					["maxBars"] = 8,
					["pointXR"] = 0.679166657924652,
					["timeFont"] = "Expressway",
					["wrap"] = 8,
					["timeFormat"] = 23,
					["detectBuffsCastBy"] = "anyone",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterBuffTable"] = "PlayerExclusions",
					["pointY"] = 0.166018537283273,
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
					["timeSort"] = false,
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
					["timeAlign"] = "LEFT",
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["iconAlign"] = "RIGHT",
					["pointX"] = 0.9765625,
					["configuration"] = 9,
					["filterTimeLeft"] = 60,
					["sor"] = "T",
					["anchorFrame"] = "RealUIPositionersBuffs",
					["i_iconSize"] = 30,
					["maxBars"] = 20,
					["timeInset"] = 16,
					["growDirection"] = false,
					["pointXR"] = 0.00625000794728597,
					["iconInset"] = -15,
					["wrap"] = 20,
					["timeFormat"] = 23,
					["detectBuffsCastBy"] = "anyone",
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
					["barWidth"] = 20,
					["iconOffset"] = 7,
				},
				["TargetDebuffs"] = {
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["hideSpark"] = false,
					["texture"] = "Blizzard",
					["parentFrame"] = "RealUITargetFrame",
					["iconInset"] = -15,
					["useDefaultFontsAndTextures"] = false,
					["showNoDuration"] = true,
					["name"] = "TargetDebuffs",
					["timeSort"] = false,
					["spacingX"] = 8,
					["barColors"] = "Standard",
					["auto"] = true,
					["pointYT"] = 0.826851825481904,
					["i_iconSize"] = 30,
					["labelCenter"] = true,
					["i_spacingX"] = 3,
					["bgtexture"] = "Blizzard",
					["pointW"] = 251.899983215332,
					["iconOffsetX"] = 0,
					["detectOtherDebuffs"] = false,
					["useDefaultDimensions"] = false,
					["spacingY"] = 7,
					["iconSize"] = 15,
					["iconColors"] = "Normal",
					["filterDebuffTable"] = "TargetExclusions",
					["timeFont"] = "Expressway",
					["filterDebuffList"] = {
					},
					["labelFSize"] = 10,
					["timeFSize"] = 10,
					["bars"] = {
					},
					["barWidth"] = 214,
					["timeAlign"] = "RIGHT",
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointX"] = 0.679479166666667,
					["desaturate"] = true,
					["scale"] = 1.1,
					["filterDebuffTypes"] = false,
					["sor"] = "T",
					["detectDebuffsMonitor"] = "target",
					["fgAlpha"] = 0.25,
					["maxBars"] = 8,
					["pointH"] = 16.5000073432922,
					["pointXR"] = 0.189322925408681,
					["iconFont"] = "Expressway",
					["wrap"] = 8,
					["timeFormat"] = 23,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["filterBuffTable"] = "PlayerExclusions",
					["detectDebuffs"] = true,
					["fgSaturation"] = 1,
					["filterDebuffSpells"] = true,
					["pointY"] = 0.157870388214155,
					["iconOffset"] = 7,
				},
				["TargetBuffs"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["pointH"] = 27.5000020980835,
					["parentFrame"] = "RealUITargetFrame",
					["showNoDuration"] = true,
					["detectBuffsCastBy"] = "anyone",
					["name"] = "TargetBuffs",
					["spacingX"] = 8,
					["filterBuffList"] = {
					},
					["filterBuffTypes"] = false,
					["auto"] = true,
					["pointYT"] = 0.913425914197955,
					["labelCenter"] = true,
					["i_spacingX"] = 3,
					["detectBuffs"] = true,
					["pointW"] = 27.4999433517456,
					["iconOffsetX"] = 0,
					["hideLabel"] = true,
					["useDefaultDimensions"] = false,
					["spacingY"] = 7,
					["iconSize"] = 25,
					["playerSort"] = true,
					["filterCooldownTable"] = "PlayerExclusions",
					["bars"] = {
					},
					["timeAlign"] = "RIGHT",
					["i_spacingY"] = 15,
					["desaturate"] = true,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timeSort"] = false,
					["pointX"] = 0.681197916666667,
					["filterDebuffTable"] = "PlayerExclusions",
					["scale"] = 1.1,
					["filterBuffSpells"] = true,
					["configuration"] = 9,
					["sor"] = "T",
					["i_iconSize"] = 30,
					["maxBars"] = 14,
					["pointXR"] = 0.304479196170966,
					["iconInset"] = -15,
					["wrap"] = 7,
					["timeFormat"] = 23,
					["detectBuffsMonitor"] = "target",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterBuffTable"] = "TargetExclusions",
					["barWidth"] = 214,
					["pointY"] = 0.0611111180183827,
					["hideBar"] = true,
					["desaturateFriend"] = true,
					["iconOffset"] = 7,
				},
			},
			["Durations"] = {
				[61684] = 16,
				[193396] = 12,
				[32752] = 5,
				["Blade Twisting"] = 8,
				["Jade Spirit"] = 12,
				[20707] = 900,
				[194858] = 8,
				["Forbearance"] = 60,
				["Food"] = 20,
				[19832] = 90,
				["Anticipation"] = 15,
				[146218] = 20,
				["Windswept Pages"] = 20,
				[196606] = 15,
				["Arcane Missiles!"] = 20,
				[99506] = 5,
				["Revealing Strike"] = 15,
				["Paralytic Poison"] = 15,
				["Leeching Poison"] = 3600.022,
				["Shallow Insight"] = 15,
				[186289] = 10,
				["Recently Bandaged"] = 60,
				[689] = 5.448,
				[186258] = 9,
				["River's Song"] = 7,
				["Kidney Shot"] = 2,
				["Deserter"] = 900,
				["Enlightenment"] = 10,
				["First Aid"] = 8,
				[100555] = 40,
				["Adrenaline Rush"] = 20,
				["Tricks of the Trade"] = 6,
				["Cheap Shot"] = 4,
				[110660] = 5,
				["Vanish"] = 3,
				[603] = 18.159,
				["Earthbind"] = 5,
				[45839] = 120,
				["Slice and Dice"] = 27,
				["Rupture"] = 12,
				["Combat Readiness"] = 20,
				["Dancing Steel"] = 12,
				["Vendetta"] = 20,
				["Drink"] = 20,
				[44867] = 60,
				[99390] = 180,
				[23958] = 10,
				[2479] = 30,
				[97128] = 900,
				[118922] = 8,
				["Evasion"] = 15,
				[46021] = 60,
				["Recuperate"] = 24,
				["Weakened Soul"] = 15,
				["Honorless Target"] = 30,
				[190931] = 12,
				["Rejuvenation"] = 12.597,
				["Sprint"] = 8,
				[13812] = 10,
				["Hand of Protection"] = 10,
				["Resurrection Sickness"] = 600,
				[193440] = 2.724,
				["Frostbolt"] = 9,
				["Deep Insight"] = 15,
				["Killing Spree"] = 2,
				["Plague of Ages"] = 9,
				["Deadly Poison"] = 3600.022,
				[104773] = 8,
				["Garrote"] = 18,
				[45348] = 180.064,
				[228128] = 60,
				[186257] = 3,
				[108416] = 20,
				["Blind"] = 60,
				["Hurricane"] = 12,
				["Blindside"] = 10,
				[99257] = 60,
				["Eye of Vengeance"] = 10,
				["Arrow of Time"] = 20,
				["Harmony"] = 20,
				[98619] = 30,
				["Cloak of Shadows"] = 5,
				["Moderate Insight"] = 15,
				["Power Word: Shield"] = 15,
				["Grace"] = 15,
				["Paralysis"] = 4,
				[113942] = 90,
				[185855] = 12,
				[190927] = 3,
			},
			["muteSFX"] = true,
			["Conditions"] = {
				["HUNTER"] = {
					["Aspect Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["level"] = 80,
								["minEclipsePower"] = 0,
								["levelRanged"] = 1,
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
								["minEclipsePower"] = 0,
								["levelRanged"] = 1,
							},
						},
					},
					["No Pet!"] = {
						["tests"] = {
							["Player Status"] = {
								["levelRanged"] = 1,
								["level"] = 80,
								["minEclipsePower"] = 0,
							},
						},
					},
					["Trueshot Aura Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["level"] = 80,
								["minEclipsePower"] = 0,
								["levelRanged"] = 1,
							},
							["Spell Ready"] = {
								["gcd"] = false,
							},
						},
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
								["inCombat"] = 0,
								["checkLevel"] = true,
								["inArena"] = true,
								["inBattleground"] = true,
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
				["WARLOCK"] = {
					["No Demonic Empowerment"] = {
						["enabled"] = true,
						["notify"] = true,
						["tooltip"] = true,
						["associatedSpell"] = "Demonic Empowerment",
						["name"] = "No Demonic Empowerment",
						["dependencies"] = {
						},
						["tests"] = {
							["Player Status"] = {
							},
							["All Buffs"] = {
								["toggle"] = 0,
								["auras"] = {
									"Demonic Empowerment", -- [1]
								},
								["isMine"] = true,
								["unit"] = "pet",
							},
						},
					},
				},
				["SHAMAN"] = {
					["Weapon Buff Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["levelRanged"] = 1,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["minHealth"] = 100,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
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
								["levelRanged"] = 1,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["minHealth"] = 100,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
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
								["levelRanged"] = 1,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["minHealth"] = 100,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
				},
			}
		}
		
		if DBM_AllSavedOptions and IsAddonLoaded('DBM-Core') then
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
				}
				
				elseif DBM_AllSavedOptions and IsAddonLoaded('DBM-Core') then
				DBM_AllSavedOptions["profiles"]["MaximumOverheals"] = {
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
					["InfoFrameX"] = -248.999954223633,
					["RangeFrameX"] = 50,
					["AlwaysShowSpeedKillTimer"] = true,
					["RangeFrameY"] = -50,
					["FilterSayAndYell"] = false,
					["EnableModels"] = true,
					["SpecialWarningFlashAlph3"] = 0,
					["ArrowPoint"] = "TOP",
					["SWarnNameInNote"] = true,
					["FakeBWVersion"] = false,
					["InfoFramePoint"] = "BOTTOM",
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
					["InfoFrameY"] = 96.7601928710938,
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
					["ShowFlashFrame"] = true,
					["DontShowHealthFrame"] = false,
					["InfoFrameLocked"] = false,
					["SpamBlockBossWhispers"] = true,
					["SpecialWarningDuration"] = 2,
					["AlwaysShowHealthFrame"] = false,
					["AutoReplySound"] = true,
					["RangeFrameRadarX"] = 255.000137329102,
					["RangeFrameRadarY"] = 95.0002365112305,
					["LogOnlyRaidBosses"] = false,
					["DontShowPTCountdownText"] = false,
					["HUDSizeOverride"] = false,
					["WarningPoint"] = "TOP",
					["CountdownVoice2"] = "Kolt",
					["AutoAcceptGuildInvite"] = false,
					["SpecialWarningSound2"] = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg",
					["ArrowPosX"] = 0,
					["HUDSize1"] = 5,
					["AITimer"] = true,
					["SpecialWarningFlashDura3"] = 1,
					["MovieFilter"] = "AfterFirst",
					["HPFramePoint"] = "BOTTOMRIGHT",
					["SpecialWarningPoint"] = "TOP",
					["SpecialWarningSound4"] = "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg",
					["HealthFrameLocked"] = false,
					["SpecialWarningFlashDura5"] = 1,
					["DisableSFX"] = false,
					["AutologBosses"] = false,
					["SpecialWarningFlashDura4"] = 0.7,
					["HUDColor2"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["SpecialWarningFlashAlph2"] = 0.3,
					["SpecialWarningFlashCol3"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["WarningColors"] = {
						{
							["b"] = 0.941176470588235,
							["g"] = 0.8,
							["r"] = 0.411764705882353,
						}, -- [1]
						{
							["b"] = 0,
							["g"] = 0.949019607843137,
							["r"] = 0.949019607843137,
						}, -- [2]
						{
							["b"] = 0,
							["g"] = 0.501960784313726,
							["r"] = 1,
						}, -- [3]
						{
							["b"] = 0.101960784313725,
							["g"] = 0.101960784313725,
							["r"] = 1,
						}, -- [4]
					},
					["HideTooltips"] = false,
					["SWarningAlphabetical"] = true,
					["RangeFrameSound2"] = "none",
					["BlockNoteShare"] = false,
					["ShowPizzaMessage"] = true,
					["HUDTexture2"] = "highlight",
					["SpecialWarningSound5"] = "Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.ogg",
					["ModelSoundValue"] = "Short",
					["FilterSelfHud"] = true,
					["SpecialWarningY"] = 75,
					["FilterInterrupt"] = true,
					["RangeFrameRadarPoint"] = "BOTTOM",
					["DontShowInfoFrame"] = false,
					["AutoCorrectTimer"] = false,
					["DontRestoreRange"] = false,
					["RangeFrameUpdates"] = "Average",
					["CountdownVoice3v2"] = "HoTS_R",
					["RoleSpecAlert"] = true,
					["WarningY"] = 260,
					["CustomSounds"] = 0,
					["DontPlayPTCountdown"] = false,
					["SpecialWarningFlashRepeat3"] = true,
					["ShortTimerText"] = true,
					["WhisperStats"] = false,
					["VoiceOverSpecW2"] = "DefaultOnly",
					["WarningX"] = 0,
					["HUDAlpha3"] = 0.5,
					["SpecialWarningFlashAlph5"] = 0.5,
					["HPFrameMaxEntries"] = 5,
					["HealthFrameWidth"] = 200,
					["RangeFrameSound1"] = "none",
					["WarningIconLeft"] = false,
					["RangeFrameLocked"] = false,
					["HPFrameY"] = 257,
					["WarningFontSize"] = 20.8266906738281,
					["HUDAlpha2"] = 0.5,
					["SpecialWarningFlashDura2"] = 0.4,
					["LastRevision"] = 0,
					["HUDColor3"] = {
						1, -- [1]
						0.5, -- [2]
						0, -- [3]
					},
					["SettingsMessageShown"] = true,
					["PGMessageShown"] = false,
					["SpecialWarningFlashCol4"] = {
						1, -- [1]
						0, -- [2]
						1, -- [3]
					},
					["DontShowFlexMessage"] = false,
					["FilterInterruptNoteName"] = false,
					["DontSetIcons"] = false,
					["BigBrotherAnnounceToRaid"] = false,
					["SpecialWarningFlashRepeat4"] = false,
					["CountdownVoice"] = "Corsica",
					["HideBossEmoteFrame"] = true,
					["WarningFontShadow"] = true,
					["SpecialWarningFlashRepeat2"] = false,
					["WarningDuration"] = 4,
					["SpecialWarningFlashRepeat5"] = true,
					["AutoRespond"] = true,
					["HealthFrameGrowUp"] = false,
					["DontPlayCountdowns"] = false,
					["RangeFrameFrames"] = "radar",
					["HUDTexture1"] = "highlight",
					["ShowBigBrotherOnCombatStart"] = false,
					["HUDSize3"] = 5,
					["HUDAlphaOverride"] = false,
					["SpecialWarningFlashAlph1"] = 0.3,
					["ShowDefeatMessage"] = true,
					["FilterTankSpec"] = true,
					["DontShowRangeFrame"] = false,
					["HUDSize4"] = 5,
					["InfoFrameShowSelf"] = false,
					["SpecialWarningFont"] = "Fonts\\FRIZQT__.TTF",
					["DisableStatusWhisper"] = false,
					["DontShowUserTimers"] = false,
					["DontShowBossTimers"] = false,
					["SpecialWarningFontStyle"] = "THICKOUTLINE",
					["HUDTexture4"] = "highlight",
					["HUDColorOverride"] = false,
					["HUDColor4"] = {
						0, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["WorldBossNearAlert"] = false,
					["DontShowBossAnnounces"] = false,
					["ShowEngageMessage"] = true,
					["SpecialWarningFlashRepeatAmount"] = 2,
					["AutoAcceptFriendInvite"] = false,
					["WarningIconChat"] = true,
					["RaidWarningSound"] = "",
					["HideGuildChallengeUpdates"] = true,
					["DontShowCTCount"] = false,
					["DontSendYells"] = false,
					["HUDAlpha4"] = 0.5,
					["AdvancedAutologBosses"] = false,
					["SpecialWarningFlashRepeat1"] = false,
					["SpecialWarningFlashAlph4"] = 0.4,
					["DontRestoreIcons"] = false,
					["Enabled"] = true,
					["HUDColor1"] = {
						1, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["BCTWMessageShown"] = false,
					["ArrowPosY"] = -150,
					["ShowGuildMessages"] = true,
					["SpecialWarningSound3"] = "Sound\\Creature\\KilJaeden\\KILJAEDEN02.ogg",
					["ShowWarningsInChat"] = true,
					["NewsMessageShown"] = 5,
					["StripServerName"] = true,
					["SpecialWarningSound"] = "Sound\\Spells\\PVPFlagTaken.ogg",
					["LatencyThreshold"] = 250,
					["HPFrameX"] = -334.999755859375,
					["ForumsMessageShown"] = 15061,
					["AFKHealthWarning"] = false,
					["CATATWMessageShown"] = false,
					["HelpMessageVersion"] = 2,
				}
				Eb.DBM_AllSavedOptions:SetProfile("MaximumOverdrive")
			end
		end
	end
end

--I need help below setting up the tables to call for the info above based on their table numbers.


local OverdriveUIInstallTable = {
		["Name"] = "|cff9482c9Overdrive UI|r",
		["Title"] = L["|cff9482c9Overdrive UI|r Installation"],
		["tutorialImage"] = [[Interface\AddOns\ElvUI_OverdriveUI\media\textures\OverdriveUI_Banner]],
		["Pages"] = {
			[1] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(T.format(L["Welcome to |cff9482c9Overdrive UI|r version %s!"], OUI.version))
				_G["PluginInstallFrame"].Desc1:SetText(L["OUI_INSTALL_WELCOME"])
				_G["PluginInstallFrame"].Desc2:SetText("")
				_G["PluginInstallFrame"].Desc3:SetText(L["Please press the continue button to go onto the next step."])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript("OnClick", InstallComplete)
				_G["PluginInstallFrame"].Option1:SetText(L["Skip Process"])
			end,
			[2] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(L["Overdrive UI Layout"])
				_G["PluginInstallFrame"].Desc1:SetText(L["OUI_LAYOUT_INSTALL"])
				_G["PluginInstallFrame"].Desc2:SetText(L["This will move your Minimap and set up your bags and a few other small functions that make Overdrive UI a much more plesant experience.."])
				_G["PluginInstallFrame"].Desc3:SetText(L["Importance: |cffFF0000Low|r"])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript('OnClick', function() SetupOUILayout(true); end) 
				_G["PluginInstallFrame"].Option1:SetText("Set Layout")
			end,
			[3] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(L["Overdrive UI Action Bars"])
				_G["PluginInstallFrame"].Desc1:SetText(L["ACtion Bars in |cff9482c9Overdrive UI|r is to be set up based on your spec and can be changed in the ElvUI Profiles."])
				_G["PluginInstallFrame"].Desc2:SetText()
				_G["PluginInstallFrame"].Desc3:SetText(L["Importance: |cffFF0000High|r"])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript('OnClick', function() SetupActionbars(DPS); end)
				_G["PluginInstallFrame"].Option1:SetText("DPS")

				_G["PluginInstallFrame"].Option2:Show()
				_G["PluginInstallFrame"].Option2:SetScript('OnClick', function() SetupActionbars(TANK); end)
				_G["PluginInstallFrame"].Option2:SetText("TANK")
				
				_G["PluginInstallFrame"].Option3:Show()
				_G["PluginInstallFrame"].Option3:SetScript('OnClick', function() SetupActionbars(HEALER); end)
				_G["PluginInstallFrame"].Option3:SetText("HEALER")
			end,
			[4] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(L["Setup Addon Profiles - DBM"])
				_G["PluginInstallFrame"].Desc1:SetText(L["Creates DBM Profiles Based on the Spec you Choose."])
				_G["PluginInstallFrame"].Desc2:SetText()
				_G["PluginInstallFrame"].Desc3:SetText(L["Importance: |cffD3CF00High|r"])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript('OnClick', function() Eb.DBM_AllSavedOptions:SetProfile("MaximumOverdrive"); end)
					
				_G["PluginInstallFrame"].Option1:SetText("DPS/TANK")

				_G["PluginInstallFrame"].Option2:Show()
				_G["PluginInstallFrame"].Option2:SetScript('OnClick', function() Eb.DBM_AllSavedOptions:SetProfile("MaximumOverheals"); end)
				_G["PluginInstallFrame"].Option2:SetText("HEALER")
			end,
			[5] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(L["Setup Addon Profiles - Raven"])
				_G["PluginInstallFrame"].Desc1:SetText(L["Creates Raven Buff/Debuff Bars Based on the Spec you Choose."])
				_G["PluginInstallFrame"].Desc2:SetText()
				_G["PluginInstallFrame"].Desc3:SetText(L["Importance: |cffD3CF00High|r"])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript('OnClick', function() Eb.Raven.db:SetProfile("MaximumOverdrive"); end)	
				_G["PluginInstallFrame"].Option1:SetText("DPS/TANK")

				_G["PluginInstallFrame"].Option2:Show()
				_G["PluginInstallFrame"].Option2:SetScript('OnClick', function() Eb.Raven.db:SetProfile("MaximumOverdrive-Bars"); end)
				_G["PluginInstallFrame"].Option2:SetText("DPS/TANK-with Bars")
				
				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript('OnClick', function() Eb.Raven.db:SetProfile("MaximumOverheals"); end)
				_G["PluginInstallFrame"].Option1:SetText(HEALER)

				_G["PluginInstallFrame"].Option2:Show()
				_G["PluginInstallFrame"].Option2:SetScript('OnClick', function() Eb.Raven.db:SetProfile("MaximumOverheals-Bars"); end)
				_G["PluginInstallFrame"].Option2:SetText("HEALER-with Bars")	
			end,
			[6] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(L["Setup Addon Profiles - xCT+"])
				_G["PluginInstallFrame"].Desc1:SetText(L["Creates xCT+ Profiles for Combat Text."])
				_G["PluginInstallFrame"].Desc2:SetText()
				_G["PluginInstallFrame"].Desc3:SetText(L["Importance: |cffD3CF00Medium|r"])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript('OnClick', function() Eb.xCT_Plus.db:SetProfile("MaximumOverdrive"); end)
					
				_G["PluginInstallFrame"].Option1:SetText("SET COMBAT TEXTS")
			end,
			[7] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(L["Setup Addon Profiles - Skada"])
				_G["PluginInstallFrame"].Desc1:SetText(L["Creates Skada Profiles Based on the Spec you Choose."])
				_G["PluginInstallFrame"].Desc2:SetText()
				_G["PluginInstallFrame"].Desc3:SetText(L["Importance: |cffD3CF00Low|r"])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript('OnClick', function() Eb.Skada.db:SetProfile("MaximumOverdrive"); end)
					
				_G["PluginInstallFrame"].Option1:SetText("DPS/TANK")

				_G["PluginInstallFrame"].Option2:Show()
				_G["PluginInstallFrame"].Option2:SetScript('OnClick', function() Eb.Skada.db:SetProfile("MaximumOverheals"); end)
				_G["PluginInstallFrame"].Option2:SetText("HEALER")
			end,
			[8] = function()
				_G["PluginInstallFrame"].SubTitle:SetText(L["Installation Complete"])
				_G["PluginInstallFrame"].Desc1:SetText(L["You are now finished with the installation process. If you are in need of technical support please visit us at http://www.tukui.org."])
				_G["PluginInstallFrame"].Desc2:SetText(L["Please click the button below so you can setup variables and ReloadUI."])

				_G["PluginInstallFrame"].Option1:Show()
				_G["PluginInstallFrame"].Option1:SetScript("OnClick", InstallComplete)
				_G["PluginInstallFrame"].Option1:SetText(L["Finished"])
			end,
		},
		["StepTitles"] = {
		[1] = START,
		[2] = L["OverdriveUI Layout"],
		[3] = L["Unit Frames"],
		[4] = L["Addon Profiles - DBM"],
		[5] = L["Addon Profiles - Raven"],
		[6] = L["Addon Profiles - xCT+"],
		[7] = L["Addon Profiles - Skada"],
		[8] = L["Finished"],
		},
		["StepTitlesColorSelected"] = {.53,.53,.93},
	}
end
	
local function InstallComplete()
	E.private.OUI.install_complete = GetAddOnMetadata("OverdriveUI", "Version")

	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end

	ReloadUI()
end



