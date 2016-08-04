--Plugins pass their info using the table like:
--[[ 
	addon = {
		Title = "Your Own Title",
		Name = "AddOnName",
		tutorialImage = "TexturePath",
		Pages = {
			[1] = function1,
			[2] = function2,
			[3] = function3,
		},
		StepTitles = {
			[1] = "Title 1",
			[2] = "Title 2",
			[3] = "Title 3",
		},
		StepTitlesColor = {r,g,b},
		StepTitlesColorSelected = {r,g,b},
	}
	Title is wat displayed on top of the window. By default it's ""ElvUI Plugin Installation""
	Name is how your installation will be showin in "pending list", Default is "Unknown"
	tutorialImage is a path to your own texture to use in frame. if not specified, then it will use ElvUI's one
	Pages is a table to set up pages of your install where numbers are representing actual pages' order and function is what previously was used to set layout. For example
		function function1()
			PluginInstallFrame.SubTitle:SetText("Title Text")
			PluginInstallFrame.Desc1:SetText("Desc 1 Tet")
			PluginInstallFrame.Desc2:SetText("Desc 2 Tet")
			PluginInstallFrame.Desc3:SetText("Desc 3 Tet")

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() <Do Some Stuff> end)
			PluginInstallFrame.Option1:SetText("Text 1")

			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() <Do Some Other Stuff> end)
			PluginInstallFrame.Option2:SetText("Text 2")
		end
	StepTitles - a table to specify "titles" for your install steps. If specified and number of lines here = number of pages then you'll get an additional frame to the right of main frame
	with a list of steps (current one being highlighted), clicking on those will open respective step. BenikUI style of doing stuff.
	StepTitlesColor - a table with color values to color "titles" when they are not active
	StepTitlesColorSelected - a table with color values to color "titles" when they are active
]]

local E, L, V, P, G, _ = unpack(select(2, ...)); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local PI = E:NewModule("PluginInstaller")

--Cache global variables
--Lua functions
local _G = _G
local pairs, tinsert, tremove, unpack = pairs, tinsert, tremove, unpack

--WoW API / Variables
local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local PlaySoundFile = PlaySoundFile
local UIFrameFadeOut = UIFrameFadeOut
local CreateAnimationGroup = CreateAnimationGroup
local CONTINUE, PREVIOUS, UNKNOWN = CONTINUE, PREVIOUS, UNKNOWN
local DPS, TANK, HEALER = DPS, TANK, HEALER


--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: PluginInstallFrame

--Installation Functions

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



PI.Installs = {}
local f
local BUTTON_HEIGHT = 20

local function ResetAll()
	f.Next:Disable()
	f.Prev:Disable()
	f.Option1:Hide()
	f.Option1:SetScript("OnClick", nil)
	f.Option1:SetText("")
	f.Option2:Hide()
	f.Option2:SetScript('OnClick', nil)
	f.Option2:SetText('')
	f.Option3:Hide()
	f.Option3:SetScript('OnClick', nil)
	f.Option3:SetText('')
	f.Option4:Hide()
	f.Option4:SetScript('OnClick', nil)
	f.Option4:SetText('')
	f.SubTitle:SetText("")
	f.Desc1:SetText("")
	f.Desc2:SetText("")
	f.Desc3:SetText("")
	f.Desc4:SetText("")
	f:Size(550, 400)
	if f.StepTitles then
		for i = 1, #f.side.Lines do f.side.Lines[i].text:SetText("") end
	end
end

local function SetPage(PageNum, PrevPage)
	f.CurrentPage = PageNum
	f.PrevPage = PrevPage
	ResetAll()
	f.Status.anim.progress:SetChange(PageNum)
	f.Status.anim.progress:Play()
	
	local r, g, b = E:ColorGradient(f.CurrentPage / f.MaxPage, 1, 0, 0, 1, 1, 0, 0, 1, 0)
	f.Status:SetStatusBarColor(r, g, b)

	if PageNum == f.MaxPage then
		f.Next:Disable()
	else
		f.Next:Enable()
	end

	if PageNum == 1 then
		f.Prev:Disable()
	else
		f.Prev:Enable()
	end

	f.Pages[f.CurrentPage]()
	f.Status.text:SetText(f.CurrentPage.." / "..f.MaxPage)
	if f.StepTitles then 
		for i = 1, #f.side.Lines do
			local b = f.side.Lines[i]
			local color
			b.text:SetText(f.StepTitles[i])
			if i == f.CurrentPage then
				color = f.StepTitlesColorSelected or {.09,.52,.82}
			else
				color = f.StepTitlesColor or {1,1,1}
			end
			b.text:SetTextColor(color[1] or color.r,color[2] or color.g,color[3] or color.b)
		end
	end
end

local function NextPage()
	if f.CurrentPage ~= f.MaxPage then
		f.CurrentPage = f.CurrentPage + 1
		SetPage(f.CurrentPage, f.CurrentPage - 1)
	end
end

local function PreviousPage()
	if f.CurrentPage ~= 1 then
		f.CurrentPage = f.CurrentPage - 1
		SetPage(f.CurrentPage, f.CurrentPage + 1)
	end
end

function PI:CreateStepComplete()
	local imsg = CreateFrame("Frame", "PluginInstallStepComplete", E.UIParent)
	imsg:Size(418, 72)
	imsg:Point("TOP", 0, -190)
	imsg:Hide()
	imsg:SetScript('OnShow', function(self)
		if self.message then
			PlaySoundFile([[Sound\Interface\LevelUp.wav]])
			self.text:SetText(self.message)
			UIFrameFadeOut(self, 3.5, 1, 0)
			E:Delay(4, function() self:Hide() end)
			self.message = nil
		else
			self:Hide()
		end
	end)

	imsg.firstShow = false

	imsg.bg = imsg:CreateTexture(nil, 'BACKGROUND')
	imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
	imsg.bg:SetPoint('BOTTOM')
	imsg.bg:Size(326, 103)
	imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
	imsg.bg:SetVertexColor(1, 1, 1, 0.6)

	imsg.lineTop = imsg:CreateTexture(nil, 'BACKGROUND')
	imsg.lineTop:SetDrawLayer('BACKGROUND', 2)
	imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
	imsg.lineTop:SetPoint("TOP")
	imsg.lineTop:Size(418, 7)
	imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

	imsg.lineBottom = imsg:CreateTexture(nil, 'BACKGROUND')
	imsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
	imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
	imsg.lineBottom:SetPoint("BOTTOM")
	imsg.lineBottom:Size(418, 7)
	imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

	imsg.text = imsg:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
	imsg.text:Point("BOTTOM", 0, 12)
	imsg.text:SetTextColor(1, 0.82, 0)
	imsg.text:SetJustifyH("CENTER")
end

function PI:CreateFrame()
	f = CreateFrame("Button", "PluginInstallFrame", E.UIParent)
	f.SetPage = SetPage
	f:Size(550, 400)
	f:SetTemplate("Transparent")
	f:SetPoint("CENTER")
	f:SetFrameStrata('TOOLTIP')

	f.Title = f:CreateFontString(nil, 'OVERLAY')
	f.Title:FontTemplate(nil, 17, nil)
	f.Title:Point("TOP", 0, -5)

	f.Next = CreateFrame("Button", "PluginInstallNextButton", f, "UIPanelButtonTemplate")
	f.Next:StripTextures()
	f.Next:SetTemplate("Default", true)
	f.Next:Size(110, 25)
	f.Next:Point("BOTTOMRIGHT", -5, 5)
	f.Next:SetText(CONTINUE)
	f.Next:Disable()
	f.Next:SetScript("OnClick", NextPage)
	E.Skins:HandleButton(f.Next, true)

	f.Prev = CreateFrame("Button", "PluginInstallPrevButton", f, "UIPanelButtonTemplate")
	f.Prev:StripTextures()
	f.Prev:SetTemplate("Default", true)
	f.Prev:Size(110, 25)
	f.Prev:Point("BOTTOMLEFT", 5, 5)
	f.Prev:SetText(PREVIOUS)
	f.Prev:Disable()
	f.Prev:SetScript("OnClick", PreviousPage)
	E.Skins:HandleButton(f.Prev, true)

	f.Status = CreateFrame("StatusBar", "PluginInstallStatus", f)
	f.Status:SetFrameLevel(f.Status:GetFrameLevel() + 2)
	f.Status:CreateBackdrop("Default")
	f.Status:SetStatusBarTexture(E["media"].normTex)
	f.Status:SetStatusBarColor(unpack(E["media"].rgbvaluecolor))
	f.Status:Point("TOPLEFT", f.Prev, "TOPRIGHT", 6, -2)
	f.Status:Point("BOTTOMRIGHT", f.Next, "BOTTOMLEFT", -6, 2)
	-- Setup StatusBar Animation
	f.Status.anim = CreateAnimationGroup(f.Status)
	f.Status.anim.progress = f.Status.anim:CreateAnimation("Progress")
	f.Status.anim.progress:SetSmoothing("Out")
	f.Status.anim.progress:SetDuration(.3)

	f.Status.text = f.Status:CreateFontString(nil, 'OVERLAY')
	f.Status.text:FontTemplate()
	f.Status.text:SetPoint("CENTER")

	f.Option1 = CreateFrame("Button", "PluginInstallOption1Button", f, "UIPanelButtonTemplate")
	f.Option1:StripTextures()
	f.Option1:Size(160, 30)
	f.Option1:Point("BOTTOM", 0, 45)
	f.Option1:SetText("")
	f.Option1:Hide()
	E.Skins:HandleButton(f.Option1, true)

	f.Option2 = CreateFrame("Button", "PluginInstallOption2Button", f, "UIPanelButtonTemplate")
	f.Option2:StripTextures()
	f.Option2:Size(110, 30)
	f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45)
	f.Option2:SetText("")
	f.Option2:Hide()
	f.Option2:SetScript('OnShow', function() f.Option1:SetWidth(110); f.Option1:ClearAllPoints(); f.Option1:Point('BOTTOMRIGHT', f, 'BOTTOM', -4, 45) end)
	f.Option2:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45) end)
	E.Skins:HandleButton(f.Option2, true)

	f.Option3 = CreateFrame("Button", "PluginInstallOption3Button", f, "UIPanelButtonTemplate")
	f.Option3:StripTextures()
	f.Option3:Size(100, 30)
	f.Option3:Point('LEFT', f.Option2, 'RIGHT', 4, 0)
	f.Option3:SetText("")
	f.Option3:Hide()
	f.Option3:SetScript('OnShow', function() f.Option1:SetWidth(100); f.Option1:ClearAllPoints(); f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0); f.Option2:SetWidth(100); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOM', f, 'BOTTOM', 0, 45)  end)
	f.Option3:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
	E.Skins:HandleButton(f.Option3, true)

	f.Option4 = CreateFrame("Button", "PluginInstallOption4Button", f, "UIPanelButtonTemplate")
	f.Option4:StripTextures()
	f.Option4:Size(100, 30)
	f.Option4:Point('LEFT', f.Option3, 'RIGHT', 4, 0)
	f.Option4:SetText("")
	f.Option4:Hide()
	f.Option4:SetScript('OnShow', function()
		f.Option1:Width(100)
		f.Option2:Width(100)

		f.Option1:ClearAllPoints();
		f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0);
		f.Option2:ClearAllPoints();
		f.Option2:Point('BOTTOMRIGHT', f, 'BOTTOM', -4, 45)
	end)
	f.Option4:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
	E.Skins:HandleButton(f.Option4, true)

	f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
	f.SubTitle:FontTemplate(nil, 15, nil)
	f.SubTitle:Point("TOP", 0, -40)

	f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
	f.Desc1:FontTemplate()
	f.Desc1:Point("TOPLEFT", 20, -75)
	f.Desc1:Width(f:GetWidth() - 40)

	f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
	f.Desc2:FontTemplate()
	f.Desc2:Point("TOP", f.Desc1, "BOTTOM", 0, -20)
	f.Desc2:Width(f:GetWidth() - 40)

	f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
	f.Desc3:FontTemplate()
	f.Desc3:Point("TOP", f.Desc2, "BOTTOM", 0, -20)
	f.Desc3:Width(f:GetWidth() - 40)

	f.Desc4 = f:CreateFontString(nil, 'OVERLAY')
	f.Desc4:FontTemplate()
	f.Desc4:Point("TOP", f.Desc3, "BOTTOM", 0, -20)
	f.Desc4:Width(f:GetWidth() - 40)

	local close = CreateFrame("Button", "PluginInstallCloseButton", f, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", f, "TOPRIGHT")
	close:SetScript("OnClick", function() f:Hide() end)
	E.Skins:HandleCloseButton(close)

	f.pending = CreateFrame("Frame", "PluginInstallPendingButton", f)
	f.pending:Size(20, 20)
	f.pending:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -8)
	f.pending:SetScript("OnEnter", function(self) _G["GameTooltip"]:SetOwner(self, "ANCHOR_BOTTOMLEFT", E.PixelMode and -7 or -9); PI:PendingList(); _G["GameTooltip"]:Show() end)
	f.pending:SetScript("OnLeave", function() _G["GameTooltip"]:Hide() end)
	f.pending.tex = f.pending:CreateTexture(nil, 'OVERLAY')
	f.pending.tex:Point('TOPLEFT', f.pending, 'TOPLEFT', 2, -2)
	f.pending.tex:Point('BOTTOMRIGHT', f.pending, 'BOTTOMRIGHT', -2, 2)
	f.pending.tex:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-NewFeatureIcon]])
	f.pending:CreateBackdrop("Transparent")

	f.tutorialImage = f:CreateTexture('PluginInstallTutorialImage', 'OVERLAY')
	f.tutorialImage:Size(256, 128)
	f.tutorialImage:Point('BOTTOM', 0, 70)

	f.side = CreateFrame("Frame", 'PluginInstallTitleFrame', f)
	f.side:SetTemplate('Transparent')
	f.side:SetPoint("TOPLEFT", f, "TOPRIGHT", E.PixelMode and 1 or 3, 0)
	f.side:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", E.PixelMode and 1 or 3, 0)
	f.side:Width(140)
	f.side.text = f.side:CreateFontString(nil, "OVERLAY")
	f.side.text:SetPoint("TOP", f.side, "TOP", 0, -4)
	f.side.text:SetFont(E["media"].normFont, 18, "OUTLINE")
	f.side.text:SetText(L["Steps"])
	f.side.Lines = {} --Table to keep shown lines
	f.side:Hide()
	for i = 1, 18 do
		local button = CreateFrame("Button", nil, f)
		if i == 1 then
			button:SetPoint("TOP", f.side.text, "BOTTOM", 0, -6)
		else
			button:SetPoint("TOP", f.side.Lines[i - 1], "BOTTOM")
		end
		button:SetSize(130, BUTTON_HEIGHT)
		button.text = button:CreateFontString(nil, "OVERLAY")
		button.text:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		button.text:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
		button.text:SetFont(E["media"].normFont, 14, "OUTLINE")
		button:SetScript("OnClick", function() if i <= f.MaxPage then SetPage(i, f.CurrentPage) end end)
		button.text:SetText("")
		f.side.Lines[i] = button
		button:Hide()
	end

	f:Hide()
	
	f:SetScript("OnHide", function() PI:CloseInstall() end)
end

function PI:Queue(addon)
	local queue = true
	for k, v in pairs(self.Installs) do
		if v.Name == addon.Name then queue = false end
	end

	if queue then tinsert(self.Installs, #(self.Installs)+1, addon); self:RunInstall() end
end

function PI:CloseInstall()
	tremove(self.Installs, 1)
	f.side:Hide()
	for i = 1, #f.side.Lines do
		f.side.Lines[i].text:SetText("")
		f.side.Lines[i]:Hide()
	end
	if #(self.Installs) > 0 then E:Delay(1, function() PI:RunInstall() end) end
end

function PI:RunInstall()
	if not E.private.install_complete then return end
	if self.Installs[1] and not PluginInstallFrame:IsShown() and not (_G["ElvUIInstallFrame"] and _G["ElvUIInstallFrame"]:IsShown()) then
		f.StepTitles = nil
		f.StepTitlesColor = nil
		f.StepTitlesColorSelected = nil
		local db = self.Installs[1]
		f.CurrentPage = 0
		f.MaxPage = #(db.Pages)

		f.Title:SetText(db.Title or L["ElvUI Plugin Installation"])
		f.Status:SetMinMaxValues(0, f.MaxPage)
		f.Status.text:SetText(f.CurrentPage.." / "..f.MaxPage)
		f.tutorialImage:SetTexture(db.tutorialImage or [[Interface\AddOns\ElvUI\media\textures\logo.tga]])

		f.Pages = db.Pages

		PluginInstallFrame:Show()
		f:SetPoint("CENTER")
		if db.StepTitles and #db.StepTitles == f.MaxPage then
			f.StepTitles = db.StepTitles
			f.side:Show()
			for i = 1, #f.side.Lines do
				if db.StepTitles[i] then f.side.Lines[i]:Show() end
			end
			f:SetPoint("CENTER", E.UIParent, "CENTER", -70, 0)
			f.StepTitlesColor = db.StepTitlesColor
			f.StepTitlesColorSelected = db.StepTitlesColorSelected
		end
		NextPage()
	end
	if #(self.Installs) > 1 then
		f.pending:Show()
		E:Flash(f.pending, 0.53, true)
	else
		f.pending:Hide()
		E:StopFlash(f.pending)
	end
end

function PI:PendingList()
	_G["GameTooltip"]:AddLine(L["List of installations in queue:"], 1, 1, 1)
	_G["GameTooltip"]:AddLine(" ")
	for i = 1, #(self.Installs) do
		_G["GameTooltip"]:AddDoubleLine(i..". "..(self.Installs[i].Name or UNKNOWN), i == 1 and "|cff00FF00"..L["In Progress"].."|r" or "|cffFF0000"..L["Pending"].."|r")
	end
end

function PI:Initialize()
	PI:CreateStepComplete()
	PI:CreateFrame()
end

E:RegisterModule(PI:GetName())