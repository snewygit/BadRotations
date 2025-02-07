local rotationName = "SnewyDisc"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Cooldown
    local CooldownModes = {
        [1] = {mode = "On", value = 2, overlay = "Cooldowns Enabled", tip = "Includes Cooldowns.", highlight = 1, icon = br.player.spell.divineStar},
        [2] = {mode = "Off", value = 3, overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.divineStar}
    };
    br.ui:createToggle(CooldownModes, "Cooldown", 1, 0)
    
    -- Defensive
    local DefensiveModes = {
        [1] = {mode = "On", value = 1, overlay = "Defensive Enabled", tip = "Includes Defensives.", highlight = 1, icon = br.player.spell.powerWordBarrier},
        [2] = {mode = "Off", value = 2, overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.powerWordBarrier}
    };
    br.ui:createToggle(DefensiveModes, "Defensive", 2, 0)
    
    -- Dispel
    local DispelModes = {
        [1] = {mode = "On", value = 1, overlay = "Dispels Enabled", tip = "Includes Dispels.", highlight = 1, icon = br.player.spell.purify},
        [2] = {mode = "Off", value = 2, overlay = "Dispels Disabled", tip = "No Dispels will be used.", highlight = 0, icon = br.player.spell.purify}
    }
    br.ui:createToggle(DispelModes, "Dispel", 3, 0)
    
    -- Interrupt
    local InterruptModes = {
        [1] = {mode = "On", value = 1, overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.psychicScream},
        [2] = {mode = "Off", value = 2, overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.psychicScream}
    };
    br.ui:createToggle(InterruptModes, "Interrupt", 4, 0)
end -- End createToggles

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable
    
    local function generalOptions()
        local section = br.ui:createSection(br.ui.window.profile, "General")
        br.ui:createSpinner(section, "Pre-Pull Timer", 2, 1, 10, 1, "Desired time to start Pre-Pull.")
        br.ui:createSpinner(section, "Heal Out of Combat", 90, 1, 100, 1, "Health Percentage to heal Out of Combat.")
        br.ui:createCheckbox(section, "Power Word: Fortitude", "Use Power Word: Fortitude on party.")
        br.ui:createSpinner(section, "Power Word: Shield (Body and Soul)", 1, 0, 100, 1, "Use Power Word: Shield (Body and Soul) after past seconds of moving.")
        br.ui:createSpinner(section, "Angelic Feather", 1, 0, 100, 1, "Use Angelic Feather after past seconds of moving.")
        br.ui:createSpinner(section, "Fade", 100, 0, 100, 1, "Health Percentage to use Fade when we have aggro.")
        br.ui:createDropdown(section, "Dispel Magic", {"Target", "Auto"}, 1, "Use Dispel Magic on current or dynamic Target.")
        br.ui:createDropdown(section, "Purify", {"Target", "Auto"}, 1, "Use Purify on current or dynamic Target.")
        br.ui:checkSectionState(section)
        -- Interrupts
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        br.ui:createCheckbox(section, "Shining Force", "Use Shining Force to interrupt.")
        br.ui:createCheckbox(section, "Psychic Scream", "Use Psychic Scream to interrupt.")
        if br.player.race == "Pandaren" then br.ui:createCheckbox(section, "Quaking Palm", "Use Quaking Palm to interrupt.") end
        br.ui:createSpinner(section, "Interrupt At", 85, 0, 95, 5, "|cffFFBB00Cast Percentage to use at.")
        br.ui:checkSectionState(section)
    end -- End generalOptions
    
    local function healingOptions()
        local section = br.ui:createSection(br.ui.window.profile, "Healing")
        br.ui:createDropdown(section, "Atonement Ramp Key", br.dropOptions.Toggle, 6, "Key to press to spam atonements on party.")
        br.ui:createSpinnerWithout(section, "Atonement Tank", 95, 0, 100, 1, "Tank Health Percentage to use Power Word: Shield and Power Word: Radiance at.")
        br.ui:createSpinnerWithout(section, "Atonement Party", 90, 0, 100, 1, "Party Health Percentage to use Power Word: Shield and Power Word: Radiance at.")
        br.ui:createCheckbox(section, "Atonement Ramp DBM", "Use Power Word: Shield to spam atonements based on dbm timers.")
        br.ui:createSpinner(section, "Maximum Atonements", 3, 1, 40, 1, "Maximum Atonements to use at.")
        br.ui:createSpinner(section, "Maximum Rapture Atonements", 3, 1, 40, 1, "Maximum Atonements during Rapture to use at.")
        br.ui:createSpinner(section, "Shadow Mend", 65, 0, 100, 5, "Health Percentage to use at.")
        br.ui:createSpinner(section, "Penance Heal", 60, 0, 100, 5, "Health Percentage to use at.")
        br.ui:createSpinner(section, "Pain Suppression Tank", 30, 0, 100, 5, "Health Percentage to use at.")
        br.ui:createSpinner(section, "Pain Suppression Party", 30, 0, 100, 5, "Health Percentage to use at.")
        br.ui:createSpinner(section, "Power Word: Radiance", 70, 0, 100, 5, "Health Percentage to use at.")
        br.ui:createSpinnerWithout(section, "Power Word: Radiance Targets", 3, 0, 40, 1, "Minimum Power Word: Radiance Targets to use at.")
        br.ui:createSpinner(section, "Shadow Covenant", 85, 0, 100, 5, "Health Percentage to use at.")
        br.ui:createSpinnerWithout(section, "Shadow Covenant Targets", 4, 0, 40, 1, "Minimum Shadow Covenant Targets to use at.")
        br.ui:checkSectionState(section)
    end -- End healingOptions
    
    local function damageOptions()
        local section = br.ui:createSection(br.ui.window.profile, "Damage")
        br.ui:createSpinner(section, "Shadow Word: Pain Targets", 3, 0, 20, 1, "Maximum Shadow Word: Pain Targets to use at.")
        br.ui:createSpinner(section, "Purge the Wicked Targets", 3, 0, 20, 1, "Maximum Purge the Wicked Targets to use at.")
        br.ui:createCheckbox(section, "Explosive Rotation", "Use Shadow Word: Pain or Purge the Wicked at explosives.")
        br.ui:createCheckbox(section, "Schism", "Use Schism.")
        br.ui:createCheckbox(section, "Mindgames", "Use Mindgames.")
        br.ui:createCheckbox(section, "Unholy Nova", "Use Unholy Nova.")
        br.ui:createCheckbox(section, "Penance", "Use Penance.")
        br.ui:createCheckbox(section, "Power Word: Solace", "Use Power Word: Solace.")
        br.ui:createCheckbox(section, "Mind Blast", "Use Mind Blast.")
        br.ui:createCheckbox(section, "Smite", "Use Smite")
        br.ui:createSpinner(section, "Mind Sear", 3, 1, 50, 1, "Minimum Mind Sear Units to use at.")
        br.ui:createSpinner(section, "Mind Sear Prioritize", 5, 1, 50, 1, "Minimum Mind Sear Units to prioritize use at.")
        br.ui:createSpinnerWithout(section, "Mind Sear Health", 80, 0, 100, 1, "Minimum Health Percentage to use at.")
        br.ui:createCheckbox(section, "Shadow Word: Death", "Use Shadow Word: Death.")
        br.ui:createSpinner(section, "Mindbender", 80, 0, 100, 1, "Mana Percentage to use at.")
        br.ui:createSpinner(section, "Shadowfiend", 80, 0, 100, 1, "Mana Percentage to use at.")
        br.ui:checkSectionState(section)
    end -- End damageOptions
    
    local function cooldownOptions()
        local section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        br.ui:createCheckbox(section, "Racial", "Use Racial.")
        br.ui:createSpinner(section, "Rapture", 60, 0, 100, 1, "Health Percentage to use at.")
        br.ui:createSpinnerWithout(section, "Rapture Targets", 3, 0, 40, 1, "Minimum Targets to use at.")
        br.ui:createCheckbox(section, "Rapture when Innervated", "Use Rapture when Innervated.")
        br.ui:createSpinner(section, "Evangelism", 70, 0, 100, 1, "Health Percentage to use at.")
        br.ui:createSpinnerWithout(section, "Evangelism Targets", 3, 0, 40, 1, "Minimum Targets to use at.")
        br.ui:createSpinnerWithout(section, "Evangelism Atonements", 3, 0, 40, 1, "Minimum Atonements to use at.")
        br.ui:createSpinner(section, "Trinket 1", 70, 0, 100, 1, "Health Percentage to use at.")
        br.ui:createSpinnerWithout(section, "Trinket 1 Targets", 3, 1, 40, 1, "Minimum Trinket 1 Targets to use at.")
        br.ui:createDropdown(section, "Trinket 1 Mode", {"Enemy", "Friend"}, 1, "Use Trinket 1 on enemy or on friend.")
        br.ui:createSpinner(section, "Trinket 2", 70, 0, 100, 1, "Health Percentage to use at.")
        br.ui:createSpinnerWithout(section, "Trinket 2 Targets", 3, 1, 40, 1, "Minimum Trinket 2 Targets to use at.")
        br.ui:createDropdown(section, "Trinket 2 Mode", {"Enemy", "Friend"}, 1, "Use Trinket 2 on enemy or on friend.")
        br.ui:checkSectionState(section)
    end -- End cooldownOptions
    
    local function defensiveOptions()
        local section = br.ui:createSection(br.ui.window.profile, "Defensive")
        br.ui:createSpinner(section, "Desperate Prayer", 40, 0, 100, 1, "Health Percentage to use at.")
        br.ui:createSpinner(section, "Healthstone", 35, 0, 100, 1, "Health Percentage to use at.")
        if br.player.race == "Draenei" then br.ui:createSpinner(section, "Gift of the Naaru", 50, 0, 100, 1, "Health Percentage to use at.") end
        br.ui:checkSectionState(section)
    end -- End defensiveOptions
    
    optionTable = {
        {
            [1] = "General",
            [2] = generalOptions,
        },
        {
            [1] = "Healing",
            [2] = healingOptions
        },
        {
            [1] = "Damage",
            [2] = damageOptions
        },
        {
            [1] = "Cooldowns",
            [2] = cooldownOptions
        },
        {
            [1] = "Defensive",
            [2] = defensiveOptions
        }
    }
    return optionTable
end -- End createOptions

--------------
--- Locals ---
--------------
-- BR API Locals
local buff
local cast
local covenant
local cd
local charges
local debuff
local enemies
local friends
local gcdMax
local inCombat
local mode
local moving
local race
local spell
local talent
local ui
local unit
local units
local var
-- Other Locals
local atonementsCount
local hp
local innervated
local inRaid
local lowestUnit
local nonAtonementsCount
local mana
local mindSearUnit
local mindSearUnitsCount
local purgeTheWickedUnit
local purgeTheWickedCount
local schismUnit
local shadowWordPainCount
local tanks
local thisUnit
local encounterSpellIDs = {
    {322773}, -- De Other Side | Hakkar the Soulflayer | Blood Barrier
    {323687}, -- De Other Side | Dealer Xy'exa | Arcane Lightning
    {326171}, -- De Other Side | Mueh'zala | Shatter Reality
    {333787}, -- De Other Side | Trash | Rage
    {319941}, -- Halls of Atonement | Echelon | Stone Shattering Leap
    {323650}, -- Halls of Atonement | Aleez | Haunting Fixation
    {323393}, -- Halls of Atonement | Lord Chamberlain | Ritual of Woe
    {326409}, -- Halls of Atonement | Trash | Thrash
    {322450}, -- Mists of Tirna Scithe | Tred`ova | Consumption
    {324909}, -- Mists of Tirna Scithe | Trash | Furious Thrashing
    {324527}, -- Plaguefall | Globgrog | Plaguestomp
    {322232}, -- Plaguefall | Margrave Stradama | Infectious Rain
    {328177}, -- Plaguefall | Trash | Fungistorm
    {319713}, -- Sanguine Depths | Kryxis the Voracious | Juggernaut Rush
    {319685}, -- Sanguine Depths | Kryxis the Voracious | Severing Smash
    {325360}, -- Sanguine Depths | Grand Proctor Beryllia | Rite of Supremacy
    {322903}, -- Sanguine Depths | General Kaal | Gloom Squall
    {334625}, -- Spires of Ascension | Devos | Abyssal Detonation
    {335141}, -- The Necrotic Wake | Trash | Dark Shroud
    {319626}, -- Theater of Pain | Kul'tharok | Phantasmal Parasite
    {334945}, -- Castle Nathria | Huntsman Altimore | Vicious Lunge
    {334860}, -- Castle Nathria | Huntsman Altimore | Crushing Stone
    {334522}, -- Castle Nathria | Hungering Destroyer | Consume
    {325361}, -- Castle Nathria | Artificer Xy'mox | Glyph of Destruction
    {328789}, -- Castle Nathria | Artificer Xy'mox | Annihilate
    {325877}, -- Castle Nathria | Sun King's Salvation | Ember Blast
    {325384}, -- Castle Nathria | Lady Inerva Darkvein | Change of Heart
    {346657}, -- Castle Nathria | The Council of Blood | Prideful Eruption
    {346681}, -- Castle Nathria | The Council of Blood | Soul Spikes
    {331209}, -- Castle Nathria | Sludgefist | Hateful Gaze
    {332687}, -- Castle Nathria | Sludgefist | Colossal Roar
    {342544}, -- Castle Nathria | Stone Legion Generals | Pulverizing Meteor
    {326851}, -- Castle Nathria | Sire Denathrius | Blood Price
    {330627}, -- Castle Nathria | Sire Denathrius | Hand of Destruction
    {332619}, -- Castle Nathria | Sire Denathrius | Shattering Pain
}
local tankEncountSpellIDs = {
    {322736}, -- De Other Side | Hakkar the Soulflayer | Piercing Barb
    {327646}, -- De Other Side | Mueh'zala | Soulcrusher
    {322936}, -- Halls of Atonement | Halkias | Crumbling Slam
    {329321}, -- Halls of Atonement | Trash | Jagged Swipe
    {340208}, -- Mists of Tirna Scithe | Trash | Shred Armor
    {319650}, -- Sanguine Depths | Kryxis the Voracious | Vicious Headbutt
    {325254}, -- Sanguine Depths | Grand Proctor Beryllia | Iron Spikes
    {335308}, -- Sanguine Depths | Trash | Crushing Strike
    {321178}, -- Sanguine Depths | Trash | Slam
    {320966}, -- Spires of Ascension | Kin-Tara | Overhead Slash
    {324608}, -- Spires of Ascension | Oryphrion | Charged Stomp
    {320655}, -- The Necrotic Wake | Blightbone | Crunch
    {334488}, -- The Necrotic Wake | Surgeon Stitchflesh | Sever Flesh
    {323515}, -- Theater of Pain | Gorechop | Hateful Strike
    {320644}, -- Theater of Pain | Xav the Unfallen | Brutal Combo
    {324079}, -- Theater of Pain | Mordretha | Reaping Scythe
    {328887}, -- Castle Nathria | Shriekwing | Exsanguinating Bite
    {334971}, -- Castle Nathria | Huntsman Altimore | Jagged Claws
    {334797}, -- Castle Nathria | Huntsman Altimore | Rip Soul
    {326455}, -- Castle Nathria | Sun King's Salvation | Fiery Strike
    {325440}, -- Castle Nathria | Sun King's Salvation | Vanquishing Strike
    {341621}, -- Castle Nathria | Lady Inerva Darkvein | Expose Desires
    {346690}, -- Castle Nathria | The Council of Blood | Duelist's Riposte
    {346790}, -- Castle Nathria | The Council of Blood | Sintouched Blade
    {334929}, -- Castle Nathria | Stone Legion Generals | Serrated Swipe
}

-----------------
--- Functions ---
-----------------
local function ttd(u)
    local ttdSec = unit.ttd(u)
    if ttdSec == nil or ttdSec < 0 then
        return 999
    end
    return ttdSec
end

--------------------
--- Action Lists ---
--------------------
local actionList = {}

-- Action List - PreCombat
actionList.PreCombat = function()
    if ui.checked("Pre-Pull Timer") and ui.pullTimer() <= ui.value("Pre-Pull Timer") then
        if unit.valid("target") then
            if ui.checked("Schism") and talent.schism and not moving and ui.pullTimer() <= cast.time.schism() then
                if cast.schism("target") then return true end
            elseif ui.checked("Smite") and not moving and ui.pullTimer() <= cast.time.smite() then
                if cast.smite("target") then return true end
            end
        end
    end
end -- End Action List - PreCombat

-- Action List - Extra
actionList.Extra = function()
    if ui.checked("Power Word: Fortitude") then
        for i = 1, #friends do
            thisUnit = friends[i].unit
            if not buff.powerWordFortitude.exists(thisUnit, "any") and unit.distance(thisUnit) < 40 and not unit.deadOrGhost(thisUnit) then
                if cast.powerWordFortitude() then return true end
            end
        end
    end
    if br.IsMovingTime(ui.value("Power Word: Shield (Body and Soul)")) then
        if ui.checked("Power Word: Shield (Body and Soul)") and talent.bodyAndSoul and not debuff.weakenedSoul.exists("player") and not buff.soulshape.exists() then
            if cast.powerWordShield("player") then return true end
        end
    end
    if br.IsMovingTime(ui.value("Angelic Feather")) then
        if ui.checked("Angelic Feather") and talent.angelicFeather and not buff.angelicFeather.exists("player") and not buff.soulshape.exists() then
            if cast.angelicFeather("player") then return true end
        end
    end
    if ui.checked("Atonement Ramp Key") and br.SpecificToggle("Atonement Ramp Key") and not br._G.GetCurrentKeyBoardFocus() then
        for i = 1, #friends do
            thisUnit = friends[i].unit
            if not buff.atonement.exists(thisUnit) then
                if nonAtonementsCount >= ui.value("Power Word: Radiance Targets") and not moving and charges.powerWordRadiance.count() >= 1 then
                    if cast.powerWordRadiance(thisUnit) then return true end
                elseif not debuff.weakenedSoul.exists(thisUnit) and ((not (ui.checked("Evangelism") and talent.evangelism and atonementsCount <= ui.value("Evangelism Atonements"))) or (not (ui.checked("Spirit Shell") and talent.spiritShell and atonementsCount <= ui.value("Spirit Shell Atonements"))) or charges.powerWordRadiance.count() < 1) then
                    if cast.powerWordShield(thisUnit) then return true end
                end
            end
        end
    end
end -- End Action List Extra

-- Action List - Dispel
actionList.Dispel = function()
    if mode.dispel == 1 then
        if ui.checked("Dispel Magic") then
            if ui.value("Dispel Magic") == 1 then
                if unit.valid("target") and br.canDispel("target", spell.dispelMagic) then
                    if cast.dispelMagic("target") then return true end
                end
            elseif ui.value("Dispel Magic") == 2 then
                for i = 1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if br.canDispel(thisUnit, spell.dispelMagic) then
                        if cast.dispelMagic(thisUnit) then return true end
                    end
                end
            end
        end
        if ui.checked("Purify") then
            if ui.value("Purify") == 1 then
                if unit.exists("target") and br.canDispel("target", spell.purify) then
                    if cast.purify("target") then return true end
                end
            elseif ui.value("Purify") == 2 then
                for i = 1, #friends do
                    thisUnit = friends[i].unit
                    if br.canDispel(thisUnit, spell.purify) then
                        if cast.purify(thisUnit) then return true end
                    end
                end
            end
        end
    end
end -- End Action List - Dispel

-- Action List - Interrrupt
actionList.Interrupt = function()
    if ui.useInterrupt() then
        for i = 1, #enemies.yards40 do
            thisUnit = enemies.yards40[i]
            if unit.interruptable(thisUnit, ui.value("Interrupt At")) then
                if ui.checked("Shining Force") and unit.distance(thisUnit) < 10 then
                    if cast.shiningForce() then return true end
                end
                if ui.checked("Psychic Scream") and unit.distance(thisUnit) < 8 then
                    if cast.psychicScream() then return true end
                end
                if ui.checked("Quaking Palm") and unit.distance(thisUnit) < 5 then
                    if cast.quakingPalm(thisUnit) then return true end
                end
            end
        end
    end
end -- End Action List - Interrupt

-- Action List - Defensive
actionList.Defensive = function()
    if ui.useDefensive() then
        if ui.checked("Fade") and hp <= ui.value("Fade") then
            for i = 1, #enemies.yards30 do
                thisUnit = enemies.yards30[i]
                if unit.isTanking(thisUnit) and unit.inCombat(thisUnit) then
                    cast.fade()
                end
            end
        end
        if ui.checked("Healthstone") and hp <= ui.value("Healthstone") and inCombat and (br.hasItem(5512) and br.canUseItem(5512)) then
            br.useItem(5512)
        end
        if ui.checked("Gift of the Naaru") and hp <= ui.value("Gift of the Naaru") and inCombat and race == "Draenei" then
            if cast.giftOfTheNaaru() then return true end
        end
        if ui.checked("Desperate Prayer") and hp <= ui.value("Desperate Prayer") then
            if cast.desperatePrayer() then return true end
        end
    end
end -- End Action List - Defensive

-- Action List - Cooldown
actionList.Cooldown = function()
    if ui.checked("Pain Suppression Tank") then
        for i = 1, #tanks do
            thisUnit = tanks[i].unit
            if unit.hp(thisUnit) <= ui.value("Pain Suppression Tank") then
                if cast.painSuppression(thisUnit) then return end
            end
        end
    end
    if ui.checked("Pain Suppression Party") then
        for i = 1, #friends do
            thisUnit = friends[i].unit
            if unit.hp(thisUnit) <= ui.value("Pain Suppression Party") then
                if cast.painSuppression(thisUnit) then return end
            end
        end
    end
    if ui.useCDs() then
        if (race == "Troll" or race == "Orc" or race == "MagharOrc" or race == "DarkIronDwarf" or race == "LightforgedDraenei") or (mana < 70 and race == "BloodElf") then
            if race == "LightforgedDraenei" then
                if cast.racial("target", "ground") then return true end
            else
                if cast.racial("player") then return true end
            end
        end
        if ui.checked("Trinket 1") and br.canTrinket(13) then
            if ui.value("Trinket 1 Mode") == 1 and mindSearUnitsCount >= ui.value("Trinket 1 Targets") then
                if schismUnit ~= nil then
                    br.useItem(13, schismUnit)
                elseif schismUnit == nil then
                    br.useItem(13)
                end
            elseif ui.value("Trinket 1 Mode") == 2 and br.getLowAllies(ui.value("Trinket 1")) >= ui.value("Trinket 1 Targets") then
                if unit.hp(lowestUnit) <= ui.value("Trinket 1") then
                    br.useItem(13, lowestUnit)
                end
            end
        end
        if ui.checked("Trinket 2") and br.canTrinket(14) then
            if ui.value("Trinket 2 Mode") == 1 and mindSearUnitsCount >= ui.value("Trinket 1 Targets") then
                if schismUnit ~= nil then
                    br.useItem(14, schismUnit)
                elseif schismUnit == nil then
                    br.useItem(14)
                end
            elseif ui.value("Trinket 2 Mode") == 2 and br.getLowAllies(ui.value("Trinket 2")) >= ui.value("Trinket 2 Targets") then
                if unit.hp(lowestUnit) <= ui.value("Trinket 2") then
                    br.useItem(14, lowestUnit)
                end
            end
        end
        if ui.checked("Rapture when Innervated") and innervated then
            if talent.spiritShell then
                if cast.spiritShell() then return true end
            else
                if cast.rapture() then return true end
            end
        end
        if ui.checked("Rapture") and br.getLowAllies(ui.value("Rapture")) >= ui.value("Rapture Targets") then
            if talent.spiritShell then
                if cast.spiritShell() then return true end
            else
                if cast.rapture() then return true end
            end
        end
    end
end -- End Action List - Cooldown

-- Action List - Healing
actionList.Healing = function()
    if ui.checked("Atonement Ramp DBM") then
        for i = 1, #encounterSpellIDs do
            if br.DBM:getTimer(encounterSpellIDs[i]) < 5 then
                for j = 1, #friends do
                    thisUnit = friends[j].unit
                    if not buff.atonement.exists(thisUnit) then
                        if nonAtonementsCount >= ui.value("Power Word: Radiance Targets") and not moving and charges.powerWordRadiance.count() >= 1 then
                            if cast.powerWordRadiance(thisUnit) then return true end
                        elseif not debuff.weakenedSoul.exists(thisUnit) and ((not (ui.checked("Evangelism") and talent.evangelism and atonementsCount <= ui.value("Evangelism Atonements"))) or (not (ui.checked("Spirit Shell") and talent.spiritShell and atonementsCount <= ui.value("Spirit Shell Atonements"))) or charges.powerWordRadiance.count() < 1) then
                            if cast.powerWordShield(thisUnit) then return true end
                        end
                    end
                end
            end
        end
        for i = 1, #tankEncountSpellIDs do
            if br.DBM:getTimer(tankEncountSpellIDs[i]) < 3 then
                for j = 1, #tanks do
                    thisUnit = tanks[j].unit
                    if not buff.atonement.exists(thisUnit) and not debuff.weakenedSoul.exists(thisUnit) then
                        if cast.powerWordShield(thisUnit) then return true end
                    end
                end
            end
        end
    end
    if buff.rapture.exists("player") or buff.spiritShell.exists("player") then
        if ui.checked("Maximum Rapture Atonements") then
            for i = 1, #friends do
                thisUnit = friends[i].unit
                if atonementsCount < ui.value("Maximum Rapture Atonements") or (unit.role(thisUnit) == "TANK") then
                    if (not buff.atonement.exists(thisUnit) and not debuff.weakenedSoul.exists(thisUnit)) or buff.powerWordShield.remain(thisUnit) < 1 then
                        if cast.powerWordShield(thisUnit) then return true end
                    end
                end
            end
            if atonementsCount >= ui.value("Maximum Rapture Atonements") and ((not buff.atonement.exists(lowestUnit) and not debuff.weakenedSoul.exists(lowestUnit)) or buff.powerWordShield.remain(lowestUnit) < 1) then
                if cast.powerWordShield(lowestUnit) then return true end
            end
        else
            for i = 1, #friends do
                thisUnit = friends[i].unit
                if not buff.atonement.exists(thisUnit) and not debuff.weakenedSoul.exists(thisUnit) then
                    if cast.powerWordShield(thisUnit) then return true end
                end
            end
            for i = 1, #friends do
                thisUnit = friends[i].unit
                if buff.powerWordShield.remain(thisUnit) < 1 then
                    if cast.powerWordShield(thisUnit) then return true end
                end
            end
        end
    end
    if ui.checked("Power Word: Radiance") and nonAtonementsCount >= ui.value("Power Word: Radiance Targets") and not cast.last.powerWordRadiance() and charges.powerWordRadiance.count() >= 1 then
        if br.getLowAllies(ui.value("Power Word: Radiance")) >= ui.value("Power Word: Radiance Targets") then
            for i = 1, #friends do
                thisUnit = friends[i].unit
                if unit.hp(thisUnit) <= ui.value("Power Word: Radiance") and not moving then
                    if cast.powerWordRadiance(thisUnit) then return true end
                end
            end
        end
    end
    if ui.checked("Evangelism") and talent.evangelism and atonementsCount >= ui.value("Evangelism Atonements") and not buff.rapture.exists("player") then
        if br.getLowAllies(ui.value("Evangelism")) >= ui.value("Evangelism Targets") then
            if cast.evangelism() then return true end
        end
    end
    if ui.checked("Shadow Covenant") and talent.shadowCovenant then
        if br.getLowAllies(ui.value("Shadow Covenant")) >= ui.value("Shadow Covenant Targets") then
            if cast.shadowCovenant(lowestUnit) then return true end
        end
    end
    if ui.checked("Penance Heal") then
        if unit.hp(lowestUnit) < ui.value("Penance Heal") and talent.contrition and atonementsCount >= 3 then
            if cast.penance(lowestUnit) then return true end
        end
        if ui.checked("Heal Out of Combat") and not inCombat and unit.hp(lowestUnit) <= ui.value("Heal Out of Combat") then
            if cast.penance(lowestUnit) then return true end
        end
    end
    if ui.checked("Shadow Mend") and not moving then
        for i = 1, #friends do
            thisUnit = friends[i].unit
            if unit.hp(thisUnit) <= ui.value("Shadow Mend") and (not buff.atonement.exists(thisUnit) or not inRaid) then
                if cast.shadowMend(thisUnit) then return true end
            end
            if ui.checked("Heal Out of Combat") and not inCombat and unit.hp(lowestUnit) <= ui.value("Heal Out of Combat") then
                if cast.shadowMend(lowestUnit) then return true end
            end
        end
    end
    for i = 1, #tanks do
        thisUnit = tanks[i].unit
        if (unit.hp(thisUnit) <= ui.value("Atonement Tank")) and not buff.atonement.exists(thisUnit) and not debuff.weakenedSoul.exists(thisUnit) then
            if cast.powerWordShield(thisUnit) then return true end
        end
    end
    for i = 1, #friends do
        thisUnit = friends[i].unit
        if unit.hp(thisUnit) <= ui.value("Atonement Party") and not buff.atonement.exists(thisUnit) and not debuff.weakenedSoul.exists(thisUnit) and (atonementsCount < ui.value("Maximum Atonements") or not ui.checked("Maximum Atonements")) then
            if cast.powerWordShield(thisUnit) then return true end
        end
    end
end -- End Action List - Healing

-- Action List - Damage
actionList.Damage = function()
    if ui.checked("Explosive Rotation") and unit.isExplosive(units.dyn40) then
        if talent.purgeTheWicked then
            if cast.purgeTheWicked(units.dyn40) then return true end
        else
            if cast.shadowWordPain(units.dyn40) then return true end
        end
    end
    if ui.checked("Mind Sear Prioritize") and not cast.current.mindSear() then
        if mindSearUnitsCount >= ui.value("Mind Sear Prioritize") and unit.hp(lowestUnit) > ui.value("Mind Sear Health") then
            if cast.mindSear(mindSearUnit) then return true end
        end
    end
    if ui.checked("Power Word: Solace") and talent.powerWordSolace then
        if schismUnit ~= nil then
            if cast.powerWordSolace(schismUnit) then return true end
        elseif schismUnit == nil then
            if cast.powerWordSolace() then return true end
        end
    end
    if ui.checked("Shadow Word: Death") then
        for i = 1, #enemies.yards40 do
            thisUnit = enemies.yards40[i]
            if unit.hp(thisUnit) <= 20 then
                if cast.shadowWordDeath(thisUnit) then return true end
            end
        end
    end
    if ui.checked("Purge the Wicked Targets") and talent.purgeTheWicked and purgeTheWickedCount < ui.value("Purge the Wicked Targets") and (cd.penance.remain() > gcdMax or purgeTheWickedCount == 0) then
        if unit.valid("target") and not debuff.purgeTheWicked.exists("target") and ttd() > 6 then
            if cast.purgeTheWicked("target") then return true end
        end
        for i = 1, #enemies.yards40 do
            thisUnit = enemies.yards40[i]
            if debuff.purgeTheWicked.remain(thisUnit) < 6 and ttd(thisUnit) > 6 and not br._G.UnitIsOtherPlayersPet(thisUnit) then
                if cast.purgeTheWicked(thisUnit) then return true end
            end
        end
    end
    if ui.checked("Shadow Word: Pain Targets") and not talent.purgeTheWicked and shadowWordPainCount < ui.value("Shadow Word: Pain Targets") and (cd.penance.remain() > gcdMax or shadowWordPainCount == 0) then
        if unit.valid("target") and not debuff.shadowWordPain.exists("target") and ttd() > 6 then
            if cast.shadowWordPain("target") then return true end
        end
        for i = 1, #enemies.yards40 do
            thisUnit = enemies.yards40[i]
            if debuff.purgeTheWicked.remain(thisUnit) < 4.8 and ttd(thisUnit) > 6 and not br._G.UnitIsOtherPlayersPet(thisUnit) then
                if cast.shadowWordPain(thisUnit) then return true end
            end
        end
    end
    if ui.checked("Mindbender") and talent.mindbender and mana <= ui.value("Mindbender") then
        if schismUnit ~= nil and ttd(schismUnit) > 9 then
            if cast.mindbender(schismUnit) then return true end
        elseif ttd(units.dyn40) > 9 and not unit.isExplosive(units.dyn40) then
            if cast.mindbender(units.dyn40) then return true end
        end
    end
    if ui.checked("Shadowfiend") and not talent.mindbender and mana <= ui.value("Shadowfiend") then
        if schismUnit ~= nil and ttd(schismUnit) > 9 then
            if cast.shadowfiend(schismUnit) then return true end
        elseif ttd(units.dyn40) > 9 and not unit.isExplosive(units.dyn40) then
            if cast.shadowfiend(units.dyn40) then return true end
        end
    end
    if ui.checked("Schism") and talent.schism and not moving and cd.penance.remain() <= gcdMax + 1 and ttd(units.dyn40) > 7 and not unit.isExplosive(units.dyn40) then
        if cast.schism(units.dyn40) then return true end
    end
    if ui.checked("Mindgames") and covenant.venthyr.active and not moving then
        if schismUnit ~= nil and ttd(schismUnit) > 7 then
            if cast.mindgames(schismUnit) then return true end
        elseif ttd(units.dyn40) > 9 and not unit.isExplosive(units.dyn40) then
            if cast.mindgames(units.dyn40) then return true end
        end
    end
    if ui.checked("Unholy Nova") and covenant.necrolord.active then
        if schismUnit ~= nil and ttd(schismUnit) > 7 and not unit.moving(schismUnit) then
            if cast.unholyNova(schismUnit) then return true end
        elseif ttd(units.dyn40) > 9 and not unit.moving(units.dyn40) and not unit.isExplosive(units.dyn40) then
            if cast.unholyNova(units.dyn40) then return true end
        end
    end
    if ui.checked("Penance") then
        if schismUnit ~= nil and ttd(schismUnit) > 2.5 then
            if cast.penance(schismUnit) then return true end
        elseif purgeTheWickedUnit ~= nil and ttd(purgeTheWickedUnit) > 2.5 and unit.facing(purgeTheWickedUnit) then
            if cast.penance(purgeTheWickedUnit) then return true end
        elseif ttd(units.dyn40) > 2.5 then
            if cast.penance(units.dyn40) then return true end
        end
    end
    if ui.checked("Mind Sear") and not moving and not cast.current.mindSear() then
        if mindSearUnitsCount >= ui.value("Mind Sear") and unit.hp(lowestUnit) > ui.value("Mind Sear Health") then
            if cast.mindSear(mindSearUnit) then return true end
        end
    end
    if ui.checked("Mind Blast") and not moving then
        if schismUnit ~= nil then
            if cast.mindBlast(schismUnit) then return true end
        else
            if cast.mindBlast(units.dyn40) then return true end
        end
    end
    if ui.checked("Smite") and not moving and not cast.current.mindSear() then
        if schismUnit ~= nil then
            if cast.smite(schismUnit) then return true end
        else
            if cast.smite(units.dyn40) then return true end
        end
    end
    if ui.checked("Purge the Wicked Targets") and talent.purgeTheWicked and cd.penance.remain() > gcdMax then
        if unit.valid("target") and not debuff.purgeTheWicked.exists("target") then
            if cast.purgeTheWicked("target") then return true end
        end
        for i = 1, #enemies.yards40 do
            thisUnit = enemies.yards40[i]
            if not br._G.UnitIsOtherPlayersPet(thisUnit) then
                if cast.purgeTheWicked(thisUnit) then return true end
            end
        end
    end
    if ui.checked("Shadow Word: Pain Targets") and not talent.purgeTheWicked and cd.penance.remain() > gcdMax then
        if unit.valid("target") and not debuff.shadowWordPain.exists("target") then
            if cast.shadowWordPain("target") then return true end
        end
        for i = 1, #enemies.yards40 do
            thisUnit = enemies.yards40[i]
            if not br._G.UnitIsOtherPlayersPet(thisUnit) then
                if cast.shadowWordPain(thisUnit) then return true end
            end
        end
    end
end -- End Action List - Damage

----------------
--- ROTATION ---
----------------
local function runRotation()
    -- BR API Locals
    buff = br.player.buff
    cast = br.player.cast
    covenant = br.player.covenant
    cd = br.player.cd
    charges = br.player.charges
    debuff = br.player.debuff
    enemies = br.player.enemies
    friends = br.friend
    gcdMax = br.player.gcdMax
    inCombat = br.player.inCombat
    mode = br.player.ui.mode
    moving = br.player.moving
    race = br.player.race
    spell = br.player.spell
    talent = br.player.talent
    ui = br.player.ui
    unit = br.player.unit
    units = br.player.units
    var = br.player.variables
    
    -- Custom Variables
    units.get(40)
    enemies.get(30)
    enemies.get(40)

    -- Other Locals
    atonementsCount = buff.atonement.count()
    hp = unit.hp("player")
    innervated = buff.innervate.exists("player")
    inRaid = br.player.instance == "raid"
    lowestUnit = friends[1].unit
    nonAtonementsCount = 0
    mana = br.player.power.mana.percent()
    mindSearUnit = nil
    mindSearUnitsCount = 0
    purgeTheWickedUnit = nil
    purgeTheWickedCount = debuff.purgeTheWicked.count()
    schismUnit = nil
    shadowWordPainCount = debuff.shadowWordPain.count()
    tanks = br.getTanksTable()
    thisUnit = nil
    if unit.exists("target") then
        mindSearUnitsCount = #enemies.get(10, "target")
        mindSearUnit = "target"
    end
    local thisGroupCount
    for i = 1, #enemies.yards40 do
        thisUnit = enemies.yards40[i]
        thisGroupCount = #enemies.get(10, thisUnit)
        if thisGroupCount > mindSearUnitsCount then
            mindSearUnitsCount = thisGroupCount
            mindSearUnit = thisUnit
        end
        if debuff.schism.exists(thisUnit) and ttd(thisUnit) > 2 and unit.facing(thisUnit) and not br._G.UnitIsOtherPlayersPet(thisUnit) then
            schismUnit = thisUnit
        end
        if debuff.purgeTheWicked.exists(thisUnit) and ttd(thisUnit) > 2 and unit.facing(thisUnit) and not br._G.UnitIsOtherPlayersPet(thisUnit) then
            purgeTheWickedUnit = thisUnit
        end
    end
    for i = 1, #friends do
        thisUnit = friends[i].unit
        if not buff.atonement.exists(thisUnit) then
            nonAtonementsCount = nonAtonementsCount + 1
        end
    end
    
    -- Begin Profile
    if var.profileStop == nil then var.profileStop = false end
    if not inCombat and not unit.exists("target") and var.profileStop then
        var.profileStop = false
    elseif (inCombat and var.profileStop) or ui.pause() or unit.mounted() or unit.flying() or unit.taxi() or ui.mode.rotation == 4 or cast.current.penance() then
        return true
    else
        if actionList.Dispel() then return true end
        if actionList.Extra() then return true end
        if not inCombat then
            if actionList.PreCombat() then return true end
            if ui.checked("Heal Out of Combat") then
                if actionList.Healing() then return true end
            end
        else
            if actionList.Defensive() then return true end
            if actionList.Interrupt() then return true end
            if actionList.Cooldown() then return true end
            if actionList.Healing() then return true end
            if actionList.Damage() then return true end
        end
    end
end -- End runRotation

local id = 256
if br.rotations[id] == nil then br.rotations[id] = {} end
br._G.tinsert(br.rotations[id], {
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
