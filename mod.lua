-- Various mod-specific game states.
-- (it's probably a good idea to not split everything into their
-- own states)
---@alias WiiStates
---| "HealthAndSafety" # The "warning - health and safety" screen that is seen on boot

---@type table<WiiStates, table>
Mod.States = {}

function Mod:init()
    Mod.States = {
        ["HealthAndSafety"] = HealthAndSafetyScreen
    }

    ---@diagnostic disable-next-line: redundant-return-value
    Utils.hook(Game, "save", function() return {} end)
end

function Mod:postInit()
    Game.state = nil
    self:setState("HealthAndSafety")
end

--- Switches the Gamestate to the given one.
---@param state table|WiiStates The gamestate to switch to.
---@param ... any Arguments passed to the gamestate.
function Mod:setState(state, ...)
    if type(state) == "string" then
        Gamestate.switch(Mod.States[state] or Kristal.States[state], ...)
    else
        Gamestate.switch(state, ...)
    end
end

-- Whether to use US-ENG-style HAS screen or not.
-- For some reason, USA Wii consoles are the only ones where the warning screen
-- was all white instead of colored
function Mod:isAmerican()
    local locale
    if love.system.getOS() == "Windows" then
        -- On MS-Win LOCALE is probably not set normally
        locale = os.setlocale("")
        local start = locale:find("_")
        local end_str = locale:find("%.", start+1)
        return locale:sub(start+1, end_str-1) == "United States"
    end

    locale = os.getenv("LC_ALL") or os.getenv("LANG")
    return locale:match("%a%a.(%a%a)") == "US"
end