--[[
		DO NOT SHARE THIS AT ALL OR IT MIGHT LEAD TO YOUR IP BEING PULLED
			THIS IS A PRIVATE SCRIPT SOURCE AND ONLY AVAILABLE FOR USE OF THESE USERS ON DISCORD
					[ commaplove , bigboytimme , bolovard , discornaccount1 , w1asp , 1known , magreborn ]
]] --

-- [[ Eror Fix ]]--
getexecutorname = getexecutorname or function()
        return "MockExecutor"
    end
identifyexecutor = identifyexecutor or function()
        return "MockExecutor"
    end
isluau = isluau or function()
        return true
    end
getsenv = getsenv or function()
        return {}
    end
Drawing =
    Drawing or
    {
        new = function()
            return {}
        end,
        Fonts = {}
    }
getrawmetatable = getrawmetatable or function()
        return {}
    end
hookmetamethod = hookmetamethod or function()
        return function()
        end
    end
checkcaller = checkcaller or function()
        return false
    end
gethwid = gethwid or function()
        return "MOCK-HWID"
    end
spoofhwid = spoofhwid or function()
    end
getidentity = getidentity or function()
        return 6
    end
getthreadidentity = getthreadidentity or function()
        return 6
    end
is_sirhurt_closure = is_sirhurt_closure or function()
        return false
    end
is_synapse_function = is_synapse_function or function()
        return false
    end
is_krnl_closure = is_krnl_closure or function()
        return false
    end
SENTINEL_LOADED = SENTINEL_LOADED or false
syn =
    syn or
    {
        crypt = {
            encrypt = function()
            end,
            decrypt = function()
            end
        },
        request = function()
        end
    }
KRNL_LOADED = KRNL_LOADED or false
http_request = http_request or function()
        return {StatusCode = 200, Body = ""}
    end
queue_on_teleport = queue_on_teleport or function()
    end
secure_call = secure_call or function()
    end

--[[ xUNC ]]
local xUNC = {}
local Detter = {}

local discordEmoji = "🌐"

local function send_notification(title, text, duration)
    pcall(
        function()
            game:GetService("StarterGui"):SetCore(
                "SendNotification",
                {
                    Title = title,
                    Text = text,
                    Duration = duration or 5
                }
            )
        end
    )
end

local function finish()
    task.wait(0.855)
    send_notification("✅ xUNC/Detter", "Test complete! Check console for results.", 5)
end

local function localmop()
    local id = "?"
    pcall(
        function()
            if type(getidentity) == "function" then
                local result = getidentity()
                if type(result) == "number" then
                    id = tostring(result)
                end
            elseif type(getthreadidentity) == "function" then
                local result = getthreadidentity()
                if type(result) == "number" then
                    id = tostring(result)
                end
            end
        end
    )
    return id
end

local function getCategoryEmoji(category)
    local emojiMap = {
        ["injection"] = "💉",
        ["memory"] = "🧠",
        ["execution"] = "⚡",
        ["environment"] = "🌐",
        ["signatures"] = "🔍",
        ["stability"] = "🛡️",
        ["hooks"] = "🪝",
        ["vm"] = "🖥️",
        ["sandbox"] = "🏝️",
        ["analysis"] = "🔬",
        ["behavior"] = "👾",
        ["patterns"] = "🧩",
        ["security"] = "🔒",
        ["performance"] = "🚀",
        ["compatibility"] = "🤝"
    }
    return emojiMap[category:lower()] or "✨"
end

local function sendToDiscord(webhookUrl, data)
    local function getSafeValue(t, ...)
        local keys = {...}
        local current = t
        for _, key in ipairs(keys) do
            if type(current) == "table" and current[key] ~= nil then
                current = current[key]
            else
                return nil
            end
        end
        return current
    end

    local sandboxLevel = "?"
    pcall(
        function()
            sandboxLevel = tostring(localmop())
        end
    )

    local executorName =
        getSafeValue(data, "executorName") or getSafeValue(data, "environment", "executorName") or "Unknown"
    local dllName = getSafeValue(data, "dllInfo", "name") or "UNKNOWN"
    local dllConfidence = getSafeValue(data, "dllInfo", "confidence") or 0
    local score = getSafeValue(data, "rating", "score") or 0
    local level = getSafeValue(data, "rating", "level") or "F"
    local tierName = getSafeValue(data, "rating", "tierName") or "Unknown"
    local percentile = getSafeValue(data, "comparison", "percentile") or 0
    local stability = getSafeValue(data, "rating", "stabilityScore") or 0
    local isRobloxGUI = getSafeValue(data, "guiInfo", "isRobloxGUI") and "YES" or "NO"
    local guiName = getSafeValue(data, "guiInfo", "guiName") or "N/A"
    local guiType = getSafeValue(data, "guiInfo", "guiType") or "N/A"
    local fingerprint = getSafeValue(data, "fingerprint", "hash") or "N/A"
    local xuncVersion = getSafeValue(data, "version") or "1.0.0"
    local detterVersion = getSafeValue(data, "guiInfo", "detterVersion") or "1.0.0"
    local robloxWebVersion = getSafeValue(data, "robloxVersions", "webVersion") or "Unknown"
    local robloxWindowsVersion = getSafeValue(data, "robloxVersions", "windowsVersion") or "Check Microsoft Store"
    local robloxMacVersion = getSafeValue(data, "robloxVersions", "macVersion") or "Check Mac App Store"
    local robloxPlatform = getSafeValue(data, "robloxVersions", "platform") or "Unknown"

    local embed = {
        {
            title = "xUNC/Detter Analysis Results",
            color = 15105570,
            fields = {
                {
                    name = "Executor Info",
                    value = string.format(
                        "**Executor Name:** %s\n**DLL Identification:** %s (confidence: %d%%)\n**Level:** %s",
                        executorName,
                        dllName,
                        math.floor(dllConfidence * 100),
                        sandboxLevel
                    ),
                    inline = false
                },
                {
                    name = "Scores",
                    value = string.format(
                        "**Final Score:** %.1f/100\n**Tier:** %s (%s)\n**Percentile:** %.1f%%\n**Stability:** %.1f/100",
                        score,
                        level,
                        tierName,
                        percentile,
                        stability
                    ),
                    inline = false
                },
                {
                    name = "GUI Info",
                    value = string.format(
                        "**Running from Roblox GUI:** %s\n**GUI Name:** %s\n**GUI Type:** %s",
                        isRobloxGUI,
                        guiName,
                        guiType
                    ),
                    inline = false
                },
                {
                    name = "Roblox Version Info",
                    value = string.format(
                        "**Web Version:** %s\n**Windows App Version:** %s\n**Mac App Version:** %s\n**Platform:** %s",
                        robloxWebVersion,
                        robloxWindowsVersion,
                        robloxMacVersion,
                        robloxPlatform
                    ),
                    inline = false
                },
                {
                    name = "Fingerprint",
                    value = string.format("```%s```", fingerprint),
                    inline = false
                }
            },
            footer = {
                text = string.format(
                    "xUNC v%s | Detter v%s | %s",
                    xuncVersion,
                    detterVersion,
                    os.date("%Y-%m-%d %H:%M:%S")
                )
            }
        }
    }

    local payload = {
        embeds = embed
    }

    local success, response = false, "No HTTP methods available"

    if not success then
        success, response =
            pcall(
            function()
                local jsonPayload = game:GetService("HttpService"):JSONEncode(payload)
                return game:GetService("HttpService"):PostAsync(webhookUrl, jsonPayload)
            end
        )
        if not success then
            print("❌ Standard HttpService failed: " .. tostring(response))
        end
    end

    if not success and syn and syn.request then
        success, response =
            pcall(
            function()
                return syn.request(
                    {
                        Url = webhookUrl,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = game:GetService("HttpService"):JSONEncode(payload)
                    }
                )
            end
        )
        if not success then
            print("❌ Synapse request failed: " .. tostring(response))
        end
    end

    if not success and http_request then
        success, response =
            pcall(
            function()
                return http_request(
                    {
                        Url = webhookUrl,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = game:GetService("HttpService"):JSONEncode(payload)
                    }
                )
            end
        )
        if not success then
            print("❌ http_request failed: " .. tostring(response))
        end
    end

    if success then
        print("✅ Results sent to Discord webhook successfully")
    else
        print("❌ All HTTP methods failed. Last error: " .. tostring(response))
    end
end

Detter.version = "1.0.2"
Detter.isRobloxGUI = false
Detter.guiName = nil
Detter.executeButton = nil
Detter.executionMethod = nil
Detter.executionRating = nil
Detter.guiElements = {}
Detter.heuristicScore = 0
Detter.guiComplexity = 0
Detter.guiSecurityFlags = {}
Detter.scriptOrigins = {}

Detter.executionBenchmarks = {
    ["TextButton.Activated"] = {security = 80, speed = 70, stability = 90, gui_origin = 100},
    ["TextButton.MouseButton1Click"] = {security = 80, speed = 70, stability = 90, gui_origin = 100},
    ["RemoteEvent.OnClientEvent"] = {security = 75, speed = 65, stability = 85, gui_origin = 90},
    ["GuiButton:Fire()"] = {security = 70, speed = 75, stability = 80, gui_origin = 95},
    ["PlayerGui Child Added"] = {security = 65, speed = 60, stability = 75, gui_origin = 85},
    ["loadstring"] = {security = 20, speed = 95, stability = 60, gui_origin = 5},
    ["coroutine.wrap"] = {security = 50, speed = 80, stability = 70, gui_origin = 10},
    ["task.defer"] = {security = 60, speed = 70, stability = 85, gui_origin = 15},
    ["getfenv/setfenv"] = {security = 10, speed = 90, stability = 40, gui_origin = 0},
    ["hookfunction"] = {security = 5, speed = 85, stability = 30, gui_origin = 0},
    ["require"] = {security = 95, speed = 50, stability = 95, gui_origin = 0},
    ["ModuleScript"] = {security = 90, speed = 55, stability = 92, gui_origin = 0},
    ["Script.Run"] = {security = 85, speed = 60, stability = 90, gui_origin = 0},
    ["LocalScript.Run"] = {security = 75, speed = 65, stability = 85, gui_origin = 30},
    ["Unknown"] = {security = 10, speed = 50, stability = 50, gui_origin = 0}
}

Detter.guiBenchmarks = {
    ["🔹 Infinite Yield"] = {score = 95, tier = "S", signature = {elements = 15, scripts = 8, obfuscation = 3}},
    ["🔹 CMD-X"] = {score = 93, tier = "S", signature = {elements = 14, scripts = 7, obfuscation = 2}},
    ["🔹 Ro-Ware"] = {score = 90, tier = "S", signature = {elements = 13, scripts = 6, obfuscation = 1}},
    ["🔹 Owl Hub"] = {score = 88, tier = "S-", signature = {elements = 12, scripts = 5, obfuscation = 1}},
    ["🔹 Dark Dex"] = {score = 87, tier = "A+", signature = {elements = 11, scripts = 4, obfuscation = 0}},
    ["🔹 SimpleSpy"] = {score = 85, tier = "A", signature = {elements = 10, scripts = 3, obfuscation = 0}},
    ["🔹 Hydroxide"] = {score = 83, tier = "A", signature = {elements = 9, scripts = 3, obfuscation = 0}},
    ["🔹 Dex Explorer"] = {score = 82, tier = "A-", signature = {elements = 8, scripts = 2, obfuscation = 0}},
    ["🔹 Sentinel"] = {score = 80, tier = "A-", signature = {elements = 7, scripts = 2, obfuscation = 0}},
    ["🔹 Custom GUI"] = {score = 78, tier = "B+", signature = {elements = 6, scripts = 1, obfuscation = 0}},
    ["🔹 Universal GUI"] = {score = 75, tier = "B", signature = {elements = 5, scripts = 1, obfuscation = 0}},
    ["🔹 Basic Admin"] = {score = 70, tier = "B-", signature = {elements = 4, scripts = 1, obfuscation = 0}},
    ["🔹 JJSploit GUI"] = {score = 68, tier = "B-", signature = {elements = 3, scripts = 1, obfuscation = 0}},
    ["🔹 Krnl UI"] = {score = 65, tier = "B-", signature = {elements = 2, scripts = 1, obfuscation = 0}},
    ["🔹 Generic GUI"] = {score = 55, tier = "C+", signature = {elements = 1, scripts = 1, obfuscation = 0}},
    ["🔹 Legacy Dex"] = {score = 50, tier = "C", signature = {elements = 1, scripts = 0, obfuscation = 0}},
    ["🔹 Simple Admin"] = {score = 45, tier = "C-", signature = {elements = 0, scripts = 0, obfuscation = 0}},
    ["🔹 Unknown GUI"] = {score = 40, tier = "D", signature = {elements = 0, scripts = 0, obfuscation = 0}},
    ["🔹 Old Script GUI"] = {score = 35, tier = "D-", signature = {elements = 0, scripts = 0, obfuscation = 0}},
    ["🔹 Placeholder GUI"] = {score = 30, tier = "D-", signature = {elements = 0, scripts = 0, obfuscation = 0}},
    ["🔹 Roblox Studio"] = {score = 99, tier = "DEV", signature = {elements = 20, scripts = 10, obfuscation = 5}},
    ["🔹 Synapse X UI"] = {score = 85, tier = "A", signature = {elements = 10, scripts = 4, obfuscation = 2}},
    ["🔹 Script-Ware UI"] = {score = 82, tier = "A-", signature = {elements = 9, scripts = 3, obfuscation = 1}},
    ["🔹 Mobile GUI"] = {score = 60, tier = "C+", signature = {elements = 5, scripts = 2, obfuscation = 0}}
}

Detter.securityPatterns = {
    {"checkcaller", "Anti-Exploit", 85},
    {"secure_call", "Secure Execution", 90},
    {"newcclosure", "Closure Protection", 80},
    {"hookfunction", "Function Hooking", 10},
    {"setidentity", "Identity Masking", 75},
    {"getconnections", "Signal Analysis", 60},
    {"firesignal", "Signal Spoofing", 30},
    {"getrawmetatable", "Metatable Access", 50},
    {"setreadonly", "Memory Protection", 70},
    {"islclosure", "Closure Check", 65},
    {"is_synapse_function", "Executor Check", 40},
    {"debug.getupvalue", "Debug Access", 20},
    {"getgenv", "Environment Access", 15},
    {"getreg", "Registry Access", 25},
    {"getgc", "Garbage Collection", 35}
}

Detter.originPatterns = {
    {"game:GetService%(%'Players'%).LocalPlayer", "LocalPlayer", 30},
    {"game:GetService%(%'ReplicatedStorage'%)", "ReplicatedStorage", 25},
    {"game:GetService%(%'ServerScriptService'%)", "ServerScriptService", 20},
    {"game:GetService%(%'ServerStorage'%)", "ServerStorage", 15},
    {"game:GetService%(%'Workspace'%)", "Workspace", 10},
    {"game:GetService%(%'Lighting'%)", "Lighting", 5},
    {"game:HttpService", "HttpService", 40},
    {"require%(", "ModuleScript", 50},
    {"loadstring%(", "Dynamic Code", 60},
    {"coroutine%.wrap%(", "Coroutine", 45},
    {"task%.spawn%(", "Task Scheduler", 35},
    {"pcall%(", "Protected Call", 55}
}

if script:IsDescendantOf(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")) then
    Detter.isRobloxGUI = true
    local screenGui = script:FindFirstAncestorOfClass("ScreenGui")
    if screenGui then
        Detter.guiName = screenGui.Name
        Detter:scanGuiStructure(screenGui)

        for _, benchmarkName in pairs(Detter.guiBenchmarks) do
            local cleanName = benchmarkName:gsub("🔹 ", "")
            if string.find(screenGui.Name:lower(), cleanName:lower()) then
                Detter.guiName = benchmarkName
                break
            end
        end
    end
end

function Detter:scanGuiStructure(gui)
    local elementCount = 0
    local scriptCount = 0
    local obfuscationFlags = 0
    local securityFlags = {}
    local origins = {}

    for _, descendant in ipairs(gui:GetDescendants()) do
        elementCount = elementCount + 1

        if descendant:IsA("LocalScript") or descendant:IsA("Script") or descendant:IsA("ModuleScript") then
            scriptCount = scriptCount + 1
            local source = descendant.Source

            for _, pattern in ipairs(self.securityPatterns) do
                if string.find(source, pattern[1]) then
                    securityFlags[pattern[2]] = (securityFlags[pattern[2]] or 0) + 1
                end
            end

            for _, pattern in ipairs(self.originPatterns) do
                if string.find(source, pattern[1]) then
                    origins[pattern[2]] = (origins[pattern[2]] or 0) + 1
                end
            end

            if string.find(source, "\\x") or string.find(source, "\\u") then
                obfuscationFlags = obfuscationFlags + 1
            end
        end
    end

    self.guiElements = {
        totalElements = elementCount,
        totalScripts = scriptCount,
        obfuscationLevel = obfuscationFlags,
        securityFlags = securityFlags,
        scriptOrigins = origins
    }

    self.guiComplexity = math.floor((elementCount * 0.4) + (scriptCount * 0.6))
end

function Detter:calculateHeuristicScore()
    local score = 0

    if self.guiType and self.guiBenchmarks[self.guiType] then
        score = score + (self.guiBenchmarks[self.guiType].score * 0.3)
    end

    if self.executionRating then
        score = score + (self.executionRating.score * 0.4)
    end

    score = score + (self.guiComplexity * 0.2)

    local securityModifier = 1
    for flag, count in pairs(self.guiElements.securityFlags) do
        for _, pattern in ipairs(self.securityPatterns) do
            if flag == pattern[2] then
                securityModifier = securityModifier + (pattern[3] * count * 0.01)
            end
        end
    end

    score = score * securityModifier
    self.heuristicScore = math.min(100, math.floor(score))
end

function Detter:findExecuteButton()
    if not self.isRobloxGUI then
        return
    end

    local gui = script:FindFirstAncestorOfClass("ScreenGui")
    if not gui then
        return
    end

    local commonNames = {
        ExecuteButton = 0.95,
        Execute = 0.93,
        ExecButton = 0.92,
        Exec = 0.91,
        RunScript = 0.9,
        Run = 0.89,
        ScriptButton = 0.88,
        Load = 0.87,
        Start = 0.86,
        Fire = 0.85,
        ex = 0.8,
        exe = 0.8,
        executer = 0.78,
        runbtn = 0.75,
        RunButton = 0.85,
        ScriptBtn = 0.84,
        LoadBtn = 0.83,
        StartBtn = 0.82,
        ExecuteBtn = 0.81,
        Launch = 0.8,
        LaunchScript = 0.79,
        Activate = 0.78,
        Enable = 0.77,
        Play = 0.76,
        Exploit = 0.75,
        ExploitButton = 0.74,
        Hack = 0.73,
        HackButton = 0.72,
        Cheat = 0.71,
        Eval = 0.7,
        Evaluate = 0.69,
        Call = 0.68,
        RunCode = 0.67,
        ExecuteCode = 0.66,
        Go = 0.65,
        OK = 0.64,
        Confirm = 0.63,
        Proceed = 0.62,
        Continue = 0.61,
        btn = 0.6,
        X = 0.59,
        _ = 0.58,
        Run_ = 0.57,
        EX_ = 0.56,
        Inject = 0.55,
        InjectButton = 0.54
    }

    local candidates = {}
    local lowerNameCache = {}

    for _, descendant in ipairs(gui:GetDescendants()) do
        if descendant:IsA("TextButton") or descendant:IsA("ImageButton") then
            local score = 0
            local nameLower = lowerNameCache[descendant.Name] or string.lower(descendant.Name)
            lowerNameCache[descendant.Name] = nameLower

            for name, weight in pairs(commonNames) do
                if string.find(nameLower, string.lower(name)) then
                    score = score + weight
                    break
                end
            end

            local siblings = descendant.Parent:GetChildren()
            for _, sibling in ipairs(siblings) do
                if sibling:IsA("TextBox") or sibling:IsA("TextLabel") then
                    local siblingText = string.lower(sibling.Text or sibling.Name or "")
                    if
                        string.find(siblingText, "execute") or string.find(siblingText, "run") or
                            string.find(siblingText, "script")
                     then
                        score = score + 0.3
                    end
                end
            end

            if descendant:FindFirstChild("UICorner") then
                score = score + 0.05
            end
            if descendant:FindFirstChild("UIStroke") then
                score = score + 0.05
            end
            if descendant.BackgroundColor3 == Color3.fromRGB(25, 25, 25) then
                score = score + 0.1
            end

            if score > 0.5 then
                table.insert(candidates, {element = descendant, score = score})
            end
        elseif
            descendant:IsA("RemoteEvent") and
                (string.find(string.lower(descendant.Name), "execute") or
                    string.find(string.lower(descendant.Name), "fire"))
         then
            table.insert(candidates, {element = descendant, score = 0.85, isRemote = true})
        elseif descendant:IsA("BindableEvent") and string.find(string.lower(descendant.Name), "execute") then
            table.insert(candidates, {element = descendant, score = 0.8, isBindable = true})
        end
    end

    table.sort(
        candidates,
        function(a, b)
            return a.score > b.score
        end
    )

    if #candidates > 0 and candidates[1].score >= 0.6 then
        self.executeButton = candidates[1].element
        self.executionMethod =
            candidates[1].isRemote and "RemoteEvent" or candidates[1].isBindable and "BindableEvent" or nil
        print(
            "→ 🔍 Found execute button: " ..
                candidates[1].element.Name .. " (Score: " .. string.format("%.2f", candidates[1].score) .. ")"
        )
    else
        print("→ 🚫 No execute button found")
    end
end

function Detter:analyzeExecutionMethod()
    if not self.executeButton then
        self.executionMethod = "Unknown"
        return
    end

    local scriptSource
    local function getScriptSource(obj)
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("LocalScript") or child:IsA("Script") then
                local success, src =
                    pcall(
                    function()
                        return child.Source
                    end
                )
                if success then
                    return src
                end
            end
        end
        return nil
    end

    scriptSource = getScriptSource(self.executeButton)
    if not scriptSource then
        local clickDetector = self.executeButton:FindFirstChildOfClass("ClickDetector")
        if clickDetector then
            scriptSource = getScriptSource(clickDetector)
        end
    end

    if scriptSource then
        local sourceLower = string.lower(scriptSource)
        local methods = {
            {"secure_call", "secure_call"},
            {"loadstring", "loadstring"},
            {"task%.defer", "task.defer"},
            {"coroutine%.wrap", "coroutine.wrap"},
            {"require", "require"},
            {"pcall%(loadstring%)", "pcall(loadstring)"},
            {"getfenv", "getfenv/setfenv"},
            {"setfenv", "getfenv/setfenv"},
            {"hookfunction", "hookfunction"},
            {"firesignal", "firesignal"},
            {"newcclosure", "newcclosure"},
            {"checkcaller", "checkcaller"},
            {"setclipboard", "clipboard_access"},
            {"getconnections", "signal_analysis"},
            {"setreadonly", "memory_protection"},
            {"getrawmetatable", "metatable_access"}
        }

        for _, method in ipairs(methods) do
            if string.find(sourceLower, method[1]) then
                self.executionMethod = method[2]
                break
            end
        end

        if not self.executionMethod then
            if string.find(sourceLower, "game:getservice%(.-%)%.players%.localplayer") then
                self.executionMethod = "LocalPlayer Script"
            elseif string.find(sourceLower, "game:getservice%(.-%)%.replicatedstorage") then
                self.executionMethod = "ReplicatedStorage Script"
            elseif string.find(sourceLower, "firesignal") then
                self.executionMethod = "Signal Firing"
            end
        end

        self.executionMethod = self.executionMethod or "Unknown"
    else
        self.executionMethod = self.executionMethod or "Unknown"
    end

    print("→ 🔍 Detected Execution Method: " .. self.executionMethod)
end

function Detter:rateExecution()
    if not self.executionMethod then
        self.executionMethod = "Unknown"
    end

    local benchmark = self.executionBenchmarks[self.executionMethod] or self.executionBenchmarks["Unknown"]
    local security = benchmark.security
    local speed = benchmark.speed
    local stability = benchmark.stability
    local finalScore = (security * 0.5) + (speed * 0.3) + (stability * 0.2)

    local tiers = {
        {90, "S", "Elite"},
        {80, "A", "Advanced"},
        {70, "B", "Standard"},
        {60, "C", "Basic"}
    }

    local tier, tierName = "D", "Unsafe"
    for _, t in ipairs(tiers) do
        if finalScore >= t[1] then
            tier, tierName = t[2], t[3]
            break
        end
    end

    self.executionRating = {
        method = self.executionMethod,
        security = security,
        speed = speed,
        stability = stability,
        score = finalScore,
        tier = tier,
        tierName = tierName
    }

    print(string.format("→ ⚡ Execution Rating: %s (%.1f/100)", tier, finalScore))
    print(string.format("→ 🔒 Security: %d/100 | ⏱️ Speed: %d/100 | 🛡️ Stability: %d/100", security, speed, stability))
end

function Detter:identifyGUI()
    if not self.isRobloxGUI or not self.guiName then
        self.guiType = "Unknown"
        return
    end

    local guiNameLower = string.lower(self.guiName)
    self.guiType = "Custom GUI"

    for name, _ in pairs(self.guiBenchmarks) do
        local cleanName = string.lower(name:gsub("🔹 ", ""))
        if string.find(guiNameLower, cleanName) then
            self.guiType = name
            break
        elseif string.find(cleanName, guiNameLower) then
            self.guiType = name
            break
        end
    end

    if self.guiType == "Custom GUI" then
        if string.find(guiNameLower, "admin") then
            self.guiType = "🔹 Basic Admin"
        elseif string.find(guiNameLower, "dex") then
            self.guiType = "🔹 Dex Explorer"
        elseif string.find(guiNameLower, "spy") then
            self.guiType = "🔹 SimpleSpy"
        elseif string.find(guiNameLower, "exploit") then
            self.guiType = "🔹 Generic GUI"
        end
    end
end

function Detter:analyzeSecurityFeatures()
    if not self.guiElements.securityFlags or not next(self.guiElements.securityFlags) then
        print("→ 🔓 No security features detected")
        return
    end

    print("→ 🔐 Detected Security Features:")
    for flag, count in pairs(self.guiElements.securityFlags) do
        print(string.format("   - %s (x%d)", flag, count))
    end
end

function Detter:analyzeScriptOrigins()
    if not self.guiElements.scriptOrigins or not next(self.guiElements.scriptOrigins) then
        print("→ 🌐 No script origins detected")
        return
    end

    print("→ 🌍 Detected Script Origins:")
    for origin, count in pairs(self.guiElements.scriptOrigins) do
        print(string.format("   - %s (x%d)", origin, count))
    end
end

function Detter:analyzeGUI()
    if not self.isRobloxGUI then
        return
    end

    print("\n🔍 DETTER :: GUI Execution Analysis")
    self:findExecuteButton()
    self:analyzeExecutionMethod()
    self:rateExecution()
    self:identifyGUI()
    self:analyzeSecurityFeatures()
    self:analyzeScriptOrigins()
    self:calculateHeuristicScore()

    if self.guiType ~= "Custom GUI" and self.guiType ~= "Unknown" then
        local benchmark = self.guiBenchmarks[self.guiType]
        if benchmark then
            print(
                string.format(
                    "→ 🏆 Known GUI Benchmark: %s (%s - %d/100)",
                    self.guiType,
                    benchmark.tier,
                    benchmark.score
                )
            )
        end
    end

    print(string.format("→ 🧠 Heuristic Score: %d/100", self.heuristicScore))
    print(string.format("→ 🏗️ GUI Complexity: %d/100", self.guiComplexity))
    print(
        string.format(
            "→ 📊 Total Elements: %d | Scripts: %d",
            self.guiElements.totalElements,
            self.guiElements.totalScripts
        )
    )
end

function Detter:integrateWithxUNC(xUNCResults)
    if
        not self.executionRating or not xUNCResults or not xUNCResults.rating or not xUNCResults.environment or
            not xUNCResults.dllInfo
     then
        return
    end

    local combinedScore = (self.executionRating.score * 0.6) + (xUNCResults.rating.score * 0.4)
    self.metaHookCapability = xUNCResults.environment.hasAdvancedMeta or false
    self.executorName = xUNCResults.dllInfo.name ~= "UNKNOWN" and xUNCResults.dllInfo.name or nil

    if xUNCResults.environment.hasAdvancedMeta then
        self.heuristicScore = math.min(100, self.heuristicScore + 5)
    end
end

xUNC.version = "1.0.7"

xUNC.functions = {
    -- Tier 5: Critical Exploit Functions (Massive score multipliers)
    {name = "hookmetamethod", category = "metatables", weight = 5.0, type = "multiplier"},
    {name = "getrawmetatable", category = "metatables", weight = 4.5, type = "multiplier"},
    {name = "setrawmetatable", category = "metatables", weight = 4.8, type = "multiplier"},
    {name = "getgc", category = "memory", weight = 4.7, type = "multiplier"},
    {name = "getscriptclosure", category = "memory", weight = 4.3, type = "multiplier"},
    -- Tier 4: Advanced Exploit Functions (Large score additions)
    {name = "hookfunction", category = "environments", weight = 3.8, type = "add"},
    {name = "replaceclosure", category = "metatables", weight = 3.7, type = "add"},
    {name = "debug.getregistry", category = "debug", weight = 3.9, type = "add"},
    {name = "getsenv", category = "environments", weight = 3.5, type = "add"},
    {name = "decompile", category = "execution", weight = 3.6, type = "add"},
    -- Tier 3: Core Exploit Functions (Medium score additions)
    {name = "getconnections", category = "connections", weight = 2.8, type = "add"},
    {name = "firesignal", category = "connections", weight = 2.7, type = "add"},
    {name = "getconstants", category = "memory", weight = 2.5, type = "add"},
    {name = "getupvalues", category = "memory", weight = 2.4, type = "add"},
    {name = "setupvalue", category = "environments", weight = 2.6, type = "add"},
    -- Tier 2: Standard Exploit Functions (Small score additions)
    {name = "loadstring", category = "execution", weight = 1.8, type = "add"},
    {name = "secure_call", category = "execution", weight = 1.9, type = "add"},
    {name = "queue_on_teleport", category = "execution", weight = 1.7, type = "add"},
    {name = "checkcaller", category = "execution", weight = 1.6, type = "add"},
    {name = "getnamecallmethod", category = "metatables", weight = 1.8, type = "add"},
    -- Tier 1: Basic Functions (Tiny score additions)
    {name = "getgenv", category = "memory", weight = 0.5, type = "add"},
    {name = "getrenv", category = "memory", weight = 0.5, type = "add"},
    {name = "rconsoleprint", category = "execution", weight = 0.3, type = "add"},
    {name = "identifyexecutor", category = "execution", weight = 0.2, type = "add"},
    {name = "isluau", category = "execution", weight = 0.1, type = "add"}
}

xUNC.securityFunctions = {
    -- Critical Security Breaches (Huge multipliers)
    {name = "crypt.encrypt", category = "crypt", weight = 4.9, type = "multiplier"},
    {name = "crypt.decrypt", category = "crypt", weight = 4.9, type = "multiplier"},
    {name = "setidentity", category = "system", weight = 4.5, type = "multiplier"},
    {name = "gethwid", category = "system", weight = 4.3, type = "multiplier"},
    -- Advanced Security Functions
    {name = "request", category = "network", weight = 3.5, type = "add"},
    {name = "websocketconnect", category = "network", weight = 3.6, type = "add"},
    {name = "fireproximityprompt", category = "game", weight = 3.2, type = "add"},
    {name = "firetouchinterest", category = "game", weight = 3.4, type = "add"},
    -- Input Functions
    {name = "keypress", category = "input", weight = 2.5, type = "add"},
    {name = "mousemoveabs", category = "input", weight = 2.3, type = "add"},
    {name = "sendkeyevent", category = "input", weight = 2.4, type = "add"},
    -- System Functions
    {name = "setfpscap", category = "system", weight = 1.8, type = "add"},
    {name = "setclipboard", category = "clipboard", weight = 1.5, type = "add"},
    {name = "getclipboard", category = "clipboard", weight = 1.3, type = "add"}
}

xUNC.fileSystemFunctions = {
    -- Critical File Operations
    {name = "writefile", category = "filesystem", weight = 3.8, type = "add"},
    {name = "readfile", category = "filesystem", weight = 3.5, type = "add"},
    {name = "delfile", category = "filesystem", weight = 3.2, type = "add"},
    {name = "makefolder", category = "filesystem", weight = 2.8, type = "add"},
    -- Standard File Operations
    {name = "listfiles", category = "filesystem", weight = 2.0, type = "add"},
    {name = "copyfile", category = "filesystem", weight = 1.8, type = "add"},
    {name = "renamefile", category = "filesystem", weight = 1.7, type = "add"},
    -- Basic Checks
    {name = "isfile", category = "filesystem", weight = 0.8, type = "add"},
    {name = "isfolder", category = "filesystem", weight = 0.7, type = "add"}
}

xUNC.debugFunctions = {
    -- Advanced Debugging
    {name = "getconstant", category = "debug", weight = 3.2, type = "add"},
    {name = "setconstant", category = "debug", weight = 3.4, type = "add"},
    {name = "getproto", category = "debug", weight = 3.5, type = "add"},
    {name = "getlocal", category = "debug", weight = 2.8, type = "add"},
    -- Standard Debugging
    {name = "getinfo", category = "debug", weight = 2.0, type = "add"},
    {name = "traceback", category = "debug", weight = 1.5, type = "add"},
    {name = "getstack", category = "debug", weight = 1.8, type = "add"}
}

xUNC.networkFunctions = {
    -- Advanced Networking
    {name = "http_request", category = "network", weight = 3.7, type = "add"},
    {name = "websocket_send", category = "network", weight = 3.5, type = "add"},
    {name = "websocket_receive", category = "network", weight = 3.5, type = "add"},
    {name = "getipaddress", category = "network", weight = 3.2, type = "add"},
    {name = "getmacaddress", category = "network", weight = 3.2, type = "add"},
    -- Standard Networking
    {name = "httpget", category = "network", weight = 2.5, type = "add"},
    {name = "httppost", category = "network", weight = 2.6, type = "add"}
}

xUNC.renderFunctions = {
    -- Advanced Rendering
    {name = "Drawing.new", category = "render", weight = 3.0, type = "add"},
    {name = "setrenderproperty", category = "render", weight = 2.8, type = "add"},
    {name = "getrenderproperty", category = "render", weight = 2.7, type = "add"},
    -- Basic Rendering
    {name = "Drawing.Fonts", category = "render", weight = 1.5, type = "add"}
}

xUNC.scoring = {
    baseScore = 50,
    multiplierEffect = 2,
    tierWeights = {
        ["multiplier"] = 10.0,
        ["add"] = 1.0
    }
}

xUNC.dllHints = {
    "synapse",
    "syn",
    "synx",
    "krnl",
    "fluxus",
    "flux",
    "electron",
    "Drift",
    "drift",
    "DriftAPI",
    "swiss",
    "delta",
    "scriptware",
    "script-ware",
    "sw",
    "valyse",
    "intelli",
    "darkfus",
    "swift",
    "xeno",
    "oxygen",
    "oxygenu",
    "arceus",
    "sirhurt",
    "sentinel",
    "proto",
    "calamari",
    "temple",
    "jjsploit",
    "trigon",
    "evon",
    "celestial",
    "comet",
    "dansploit",
    "furk",
    "hydrogen",
    "nihon",
    "vega",
    "coco",
    "deltaX",
    "nexus",
    "anemo",
    "stormX",
    "venix",
    "yuno",
    "lyna",
    "neon",
    "shadeX",
    "ultraX",
    "raven",
    "alpine",
    "inferno",
    "helios",
    "terra",
    "aeon",
    "fluxteam",
    "veil",
    "zen",
    "noir",
    "zenith",
    "soulin",
    "solara",
    "wave",
    "zorara",
    "vanity",
    "awp",
    "codex",
    "kiwi",
    "redfox",
    "intersect",
    "eulen",
    "phoenix",
    "nova",
    "lunar",
    "astral",
    "vortex",
    "nebula",
    "zephyr",
    "prism",
    "aurora",
    "galaxy",
    "spectra",
    "void",
    "ember",
    "radiant",
    "lumin",
    "nyx",
    "orion",
    "cosmo",
    "strix",
    "falcon",
    "umbra",
    "krypton",
    "sigma",
    "epsilon",
    "omega",
    "vertex",
    "arcane",
    "blaze",
    "titan",
    "quantum",
    "horizon",
    "pulse",
    "fusion",
    "gravity",
    "mystic",
    "luna",
    "solar",
    "eclipse",
    "meteor",
    "spark",
    "chrono",
    "aether",
    "vapor",
    "glitch",
    "phantom",
    "shadow",
    "dusk",
    "dawn",
    "frost",
    "ignite",
    "storm",
    "bolt",
    "surge",
    "rift",
    "haze",
    "neo",
    "cipher",
    "vibe",
    "fluxor",
    "synergy",
    "aphex",
    "novo",
    "kryon",
    "lux",
    "vanta",
    "zest",
    "bloom",
    "crux",
    "faze",
    "orbit",
    "vector",
    "nerve",
    "primo",
    "axis",
    "luster",
    "zeno",
    "alpha",
    "beta",
    "gamma",
    "theta",
    "kappa",
    "lambda",
    "omicron",
    "rho",
    "tau",
    "phi",
    "chi",
    "psi",
    "zeta",
    "iota",
    "mu",
    "nu",
    "xi",
    "pi",
    "sigmaX",
    "deltaZ",
    "omegaX"
}

xUNC.executorBenchmarks = {
    ["🧸 Synapse X"] = {score = 98.5, tier = "S+"},
    ["🧸 Script-Ware"] = {score = 97.0, tier = "S+"},
    ["🧸 KRNL"] = {score = 92.5, tier = "S"},
    ["🧸 Fluxus"] = {score = 84.0, tier = "A+"},
    ["🧸 Solara"] = {score = 88.0, tier = "A+"},
    ["🧸 Wave"] = {score = 86.5, tier = "A+"},
    ["🧸 Soulin"] = {score = 83.5, tier = "A-"},
    ["🧸 ProtoSmasher"] = {score = 80.0, tier = "A-"},
    ["🧸 SirHurt"] = {score = 75.0, tier = "B+"},
    ["🧸 Delta"] = {score = 76.0, tier = "B+"},
    ["🧸 Oxygen U"] = {score = 78.5, tier = "B+"},
    ["🧸 Codex"] = {score = 73.0, tier = "B"},
    ["🧸 Temple"] = {score = 72.0, tier = "B"},
    ["🧸 Electron"] = {score = 70.0, tier = "B"},
    ["🧸 Nihon"] = {score = 69.5, tier = "B-"},
    ["🧸 Trigon"] = {score = 68.5, tier = "B-"},
    ["🧸 Kiwi X"] = {score = 67.0, tier = "B-"},
    ["🧸 RedFox"] = {score = 66.0, tier = "C+"},
    ["🧸 Calamari"] = {score = 65.0, tier = "C+"},
    ["🧸 Arceus X"] = {score = 64.0, tier = "C+"},
    ["🧸 Anemo"] = {score = 63.0, tier = "C"},
    ["🧸 Evon"] = {score = 62.0, tier = "C"},
    ["🧸 Intersect"] = {score = 60.0, tier = "C"},
    ["🧸 Valyse"] = {score = 59.0, tier = "C-"},
    ["🧸 JJSploit"] = {score = 58.0, tier = "C-"},
    ["🧸 Celestial"] = {score = 55.5, tier = "C-"},
    ["🧸 EasySploit"] = {score = 54.0, tier = "D+"},
    ["🧸 Eulen"] = {score = 53.0, tier = "D+"},
    ["🧸 Hydrogen"] = {score = 52.0, tier = "D+"},
    ["🧸 Frost"] = {score = 50.0, tier = "D"},
    ["🧸 Dansploit"] = {score = 49.0, tier = "D"},
    ["🧸 WRD API"] = {score = 48.0, tier = "D"},
    ["🧸 Furk OS"] = {score = 46.5, tier = "D-"},
    ["🧸 Skisploit"] = {score = 45.0, tier = "D-"},
    ["🧸 WeAreDevs"] = {score = 44.0, tier = "D-"},
    ["🧸 Generic"] = {score = 42.0, tier = "F"},
    ["🧸 Ypsilon"] = {score = 40.0, tier = "F"},
    ["🧸 Phoenix"] = {score = 87.5, tier = "A+"},
    ["🧸 Nebula"] = {score = 85.0, tier = "A+"},
    ["🧸 Vortex"] = {score = 82.0, tier = "A"},
    ["🧸 Lunar"] = {score = 79.0, tier = "B+"},
    ["🧸 Aurora"] = {score = 77.5, tier = "B+"},
    ["🧸 Zephyr"] = {score = 74.0, tier = "B"},
    ["🧸 Prism"] = {score = 71.0, tier = "B"},
    ["🧸 Nova"] = {score = 68.0, tier = "B-"},
    ["🧸 Orion"] = {score = 65.5, tier = "C+"},
    ["🧸 Spectra"] = {score = 61.0, tier = "C"},
    ["🧸 Umbra"] = {score = 57.0, tier = "C-"},
    ["🧸 Krypton"] = {score = 51.0, tier = "D+"},
    ["🧸 Sigma"] = {score = 47.0, tier = "D-"},
    ["🧸 Epsilon"] = {score = 43.0, tier = "D-"},
    ["🧸 Omega"] = {score = 41.0, tier = "F"}
}

function xUNC:checkFunctionSet(functionSet, setName)
    print(("\n🔍 Checking %s..."):format(setName))
    local passed = 0
    local totalWeight = 0
    local weightedPass = 0
    local results = {}
    local categoryResults = {}

    for _, fnData in ipairs(functionSet) do
        if not categoryResults[fnData.category] then
            categoryResults[fnData.category] = {
                total = 0,
                passed = 0,
                weight = 0,
                weightedPass = 0
            }
        end
        categoryResults[fnData.category].total = categoryResults[fnData.category].total + 1
        categoryResults[fnData.category].weight = categoryResults[fnData.category].weight + fnData.weight
    end

    for _, fnData in ipairs(functionSet) do
        local fn = fnData.name
        local weight = fnData.weight
        local category = fnData.category

        local ok, result =
            pcall(
            function()
                if category == "debug" then
                    return type(debug) == "table" and type(debug[fn]) == "function"
                elseif category == "render" and fn:find("%.") then
                    local parts = {}
                    for part in fn:gmatch("[^%.]+") do
                        table.insert(parts, part)
                    end
                    local obj = _G[parts[1]]
                    for i = 2, #parts do
                        obj = obj[parts[i]]
                    end
                    return type(obj) == "function" or type(obj) == "table"
                elseif category == "crypt" and fn:find("%.") then
                    local parts = {}
                    for part in fn:gmatch("[^%.]+") do
                        table.insert(parts, part)
                    end
                    local obj = _G[parts[1]]
                    for i = 2, #parts do
                        obj = obj[parts[i]]
                    end
                    return type(obj) == "function"
                else
                    return type(getfenv()[fn]) == "function" or type(getfenv()[fn]) == "table"
                end
            end
        )

        local status = false
        if ok and result then
            passed = passed + 1
            weightedPass = weightedPass + weight
            categoryResults[category].passed = categoryResults[category].passed + 1
            categoryResults[category].weightedPass = categoryResults[category].weightedPass + weight
            status = true
            print(("✅ %s : FOUND (weight: %.1f)"):format(fn, weight))
        else
            print(("🚫 %s : missing or invalid (weight: %.1f)"):format(fn, weight))
        end

        results[fn] = {
            available = status,
            category = category,
            weight = weight
        }

        totalWeight = totalWeight + weight
    end

    local percentPassed = #functionSet > 0 and (passed / #functionSet) * 100 or 0
    local weightedScore = totalWeight > 0 and (weightedPass / totalWeight) * 100 or 0

    print(("→ %s passed: %d/%d (%.1f%%)"):format(setName, passed, #functionSet, percentPassed))
    print(("→ Weighted score: %.2f/%.2f (%.1f%%)"):format(weightedPass, totalWeight, weightedScore))

    print("\n📊 Category breakdown:")
    for category, data in pairs(categoryResults) do
        local categoryPercentage = data.total > 0 and (data.passed / data.total) * 100 or 0
        local categoryWeightedPercentage = data.weight > 0 and (data.weightedPass / data.weight) * 100 or 0
        print(
            ("  %s: %d/%d (%.1f%%), weighted: %.1f%%"):format(
                category,
                data.passed,
                data.total,
                categoryPercentage,
                categoryWeightedPercentage
            )
        )
    end

    return {
        passed = passed,
        total = #functionSet,
        weightedPass = weightedPass,
        totalWeight = totalWeight,
        results = results,
        categoryResults = categoryResults,
        percentPassed = percentPassed,
        weightedScore = weightedScore
    }
end

function xUNC:detectEnvironment()
    print("\n🔍 Detecting environment features...")
    local features = {}

    pcall(
        function()
            local executorName =
                getexecutorname and getexecutorname() or identifyexecutor and identifyexecutor() or "Unknown"
            features.executorName = executorName
            print(("→ ✅ Executor name: %s"):format(executorName))

            features.isLuau = type(isluau) == "function" and isluau() or false
            print(("→ ✅ Luau environment: %s"):format(features.isLuau and "YES" or "NO"))

            features.isSS = false
            pcall(
                function()
                    features.isSS =
                        type(getsenv) == "function" and
                        pcall(
                            function()
                                return #getsenv(script) > 0
                            end
                        )
                end
            )
            print(("→ ✅ Server-side capabilities: %s"):format(features.isSS and "YES" or "NO"))

            features.hasUI = type(Drawing) == "table" and type(Drawing.new) == "function"
            print(("→ ✅ Drawing library: %s"):format(features.hasUI and "YES" or "NO"))

            features.hasAdvancedMeta = false
            pcall(
                function()
                    local mt = getrawmetatable(game)
                    features.hasAdvancedMeta = type(mt) == "table" and type(hookmetamethod) == "function"
                end
            )
            print(("→ ✅ Advanced metamethod support: %s"):format(features.hasAdvancedMeta and "YES" or "NO"))

            features.isSecure = type(checkcaller) == "function"
            print(("→ ✅ Secure environment: %s"):format(features.isSecure and "YES" or "NO"))

            features.hasHWIDSpoofing = type(gethwid) == "function" or type(spoofhwid) == "function"
            print(("→ ✅ HWID spoofing: %s"):format(features.hasHWIDSpoofing and "YES" or "NO"))

            features.sandboxLevel = 0
            pcall(
                function()
                    local getIdent = getidentity or getthreadidentity
                    if getIdent then
                        features.sandboxLevel = getIdent() or 0
                    end
                end
            )
            print(("→ ✅ Sandbox level: %d"):format(features.sandboxLevel))

            features.compatLayers = {}
            if type(is_sirhurt_closure) == "function" and is_sirhurt_closure() then
                table.insert(features.compatLayers, "sirhurt")
            end
            if type(is_synapse_function) == "function" and is_synapse_function() then
                table.insert(features.compatLayers, "synapse")
            end
            if type(is_krnl_closure) == "function" and is_krnl_closure() then
                table.insert(features.compatLayers, "krnl")
            end
            if #features.compatLayers > 0 then
                print(("→ ✅ Compatibility layers: %s"):format(table.concat(features.compatLayers, ", ")))
            else
                print("→ 🚫 No compatibility layers detected")
            end
        end
    )

    return features
end

function xUNC:estimateDLL()
    print("\n✅ Estimating DLL/executor type...")
    local result = {
        name = "UNKNOWN",
        confidence = 0,
        matches = {}
    }

    local executorName = ""
    local detectionMethod = "none"
    pcall(
        function()
            if getexecutorname then
                executorName = getexecutorname()
                detectionMethod = "getexecutorname()"
            elseif identifyexecutor then
                executorName = identifyexecutor()
                detectionMethod = "identifyexecutor()"
            elseif SENTINEL_LOADED then
                executorName = "Sentinel"
                detectionMethod = "global variable"
            elseif syn and syn.crypt and type(syn.crypt.encrypt) == "function" then
                executorName = "Synapse X"
                detectionMethod = "module structure"
            elseif KRNL_LOADED then
                executorName = "KRNL"
                detectionMethod = "global variable"
            end
        end
    )

    if executorName == "" then
        print("🚫 Executor name is blank → DLL = UNKNOWN")
        return result
    end

    local name = string.lower(executorName)
    print(("→ ✅ Executor detection reports: %q (method: %s)"):format(executorName, detectionMethod))

    local bestMatch = nil
    local bestScore = 0

    for _, hint in ipairs(self.dllHints) do
        local score = 0
        if name == string.lower(hint) then
            score = 1.0
        elseif name:find(string.lower(hint)) then
            score = 0.8
        elseif string.lower(hint):find(name) then
            score = 0.6
        else
            local nameLen = #name
            local hintLen = #hint
            local matchCount = 0
            for i = 1, math.min(nameLen, hintLen) do
                if name:sub(i, i) == hint:sub(i, i) then
                    matchCount = matchCount + 1
                end
            end
            score = matchCount / math.max(nameLen, hintLen)
        end

        if score > 0.3 then
            table.insert(result.matches, {hint = hint, similarity = score})
        end
        if score > bestScore then
            bestScore = score
            bestMatch = hint:upper()
        end
    end

    if bestMatch then
        print(("✅ Best match: %q with confidence %.1f%%"):format(bestMatch, bestScore * 100))
        result.name = bestMatch
        result.confidence = bestScore
    else
        print("🚫 No known hints matched → DLL = GENERIC")
        result.name = "GENERIC"
        result.confidence = 0
    end

    return result
end

function xUNC:checkDebugger()
    local debuggerPresent = false
    pcall(function()
        if debug.getinfo(1, "n").name ~= "checkDebugger" then
            debuggerPresent = true
        end
    end)
    if debuggerPresent then
        warn("⚠️ Debugger detected!")
    end
    return debuggerPresent
end

local function VerifyScript()
    local expectedURL = "https://raw.githubusercontent.com/LoafyHehe/02374yhbrjdklGYUGE73t21wsfe/main/xUNC.luau"
    local success, liveScript =
        pcall(
        function()
            return game:HttpGet(expectedURL, true)
        end
    )

    if not success then
        warn("⚠️ Could not verify script (HTTP failed). Continuing anyway...")
        return true
    end

    if liveScript ~= script.Source then
        warn("❌ CRITICAL: Script does not match GitHub version! Possible tampering.")
        script:Destroy()
        return false
    end

    return true
end

if not VerifyScript() then
    return
end

function xUNC:rateLevel(
    coreResults,
    securityResults,
    fsResults,
    debugResults,
    networkResults,
    renderResults,
    envFeatures)
    print("\n🔍 Calculating comprehensive level rating...")

    local categoryWeights = {
        core = 0.35,
        security = 0.20,
        filesystem = 0.15,
        debug = 0.15,
        network = 0.10,
        render = 0.05
    }

    local stabilityModifiers = {
        ["hookmetamethod"] = -10,
        ["setrawmetatable"] = -5,
        ["loadstring"] = -5,
        ["http_request"] = -3
    }

    local categoryScores = {}
    local stabilityScore = 100

    for fn, modifier in pairs(stabilityModifiers) do
        if
            (coreResults.results[fn] and coreResults.results[fn].available) or
                (securityResults.results[fn] and securityResults.results[fn].available) or
                (networkResults.results[fn] and networkResults.results[fn].available)
         then
            stabilityScore = stabilityScore + modifier
        end
    end
    stabilityScore = math.max(0, math.min(100, stabilityScore))

    categoryScores.core = coreResults.weightedScore
    print(
        ("→ ✅ Core functions weighted score: %.2f/100 × %.2f = %.2f"):format(
            coreResults.weightedScore,
            categoryWeights.core,
            coreResults.weightedScore * categoryWeights.core
        )
    )

    categoryScores.security = securityResults.weightedScore
    print(
        ("→ ✅ Security functions weighted score: %.2f/100 × %.2f = %.2f"):format(
            securityResults.weightedScore,
            categoryWeights.security,
            securityResults.weightedScore * categoryWeights.security
        )
    )

    categoryScores.filesystem = fsResults.weightedScore
    print(
        ("→ ✅ Filesystem functions weighted score: %.2f/100 × %.2f = %.2f"):format(
            fsResults.weightedScore,
            categoryWeights.filesystem,
            fsResults.weightedScore * categoryWeights.filesystem
        )
    )

    categoryScores.debug = debugResults.weightedScore
    print(
        ("→ ✅ Debug functions weighted score: %.2f/100 × %.2f = %.2f"):format(
            debugResults.weightedScore,
            categoryWeights.debug,
            debugResults.weightedScore * categoryWeights.debug
        )
    )

    categoryScores.network = networkResults.weightedScore
    print(
        ("→ ✅ Network functions weighted score: %.2f/100 × %.2f = %.2f"):format(
            networkResults.weightedScore,
            categoryWeights.network,
            networkResults.weightedScore * categoryWeights.network
        )
    )

    categoryScores.render = renderResults.weightedScore
    print(
        ("→ ✅ Render functions weighted score: %.2f/100 × %.2f = %.2f"):format(
            renderResults.weightedScore,
            categoryWeights.render,
            renderResults.weightedScore * categoryWeights.render
        )
    )

    local featureScore = 0
    if envFeatures.isLuau then
        featureScore = featureScore + 15
    end
    if envFeatures.hasUI then
        featureScore = featureScore + 20
    end
    if envFeatures.hasAdvancedMeta then
        featureScore = featureScore + 25
    end
    if envFeatures.isSecure then
        featureScore = featureScore + 20
    end
    if envFeatures.hasHWIDSpoofing then
        featureScore = featureScore + 10
    end
    if envFeatures.sandboxLevel >= 6 then
        featureScore = featureScore + 10
    end
    featureScore = math.min(100, featureScore)

    local finalScore = featureScore * 0.05
    for category, score in pairs(categoryScores) do
        finalScore = finalScore + (score * categoryWeights[category])
    end
    finalScore = finalScore * (stabilityScore / 100)
    print(("→ ✅ Stability score: %.2f/100"):format(stabilityScore))
    print(("→ ✅ Final weighted score: %.2f/100"):format(finalScore))

    local level, tierName
    if finalScore >= 95 then
        level = "S+"
        tierName = "Ultra Premium Elite"
    elseif finalScore >= 90 then
        level = "S"
        tierName = "Premium Elite"
    elseif finalScore >= 85 then
        level = "A+"
        tierName = "Superior Elite"
    elseif finalScore >= 80 then
        level = "A"
        tierName = "Elite"
    elseif finalScore >= 75 then
        level = "A-"
        tierName = "Advanced Professional"
    elseif finalScore >= 70 then
        level = "B+"
        tierName = "Professional"
    elseif finalScore >= 65 then
        level = "B"
        tierName = "Intermediate Advanced"
    elseif finalScore >= 60 then
        level = "B-"
        tierName = "Intermediate"
    elseif finalScore >= 55 then
        level = "C+"
        tierName = "Standard Plus"
    elseif finalScore >= 50 then
        level = "C"
        tierName = "Standard"
    elseif finalScore >= 45 then
        level = "C-"
        tierName = "Basic Plus"
    elseif finalScore >= 40 then
        level = "D+"
        tierName = "Basic"
    elseif finalScore >= 35 then
        level = "D"
        tierName = "Minimal Plus"
    elseif finalScore >= 30 then
        level = "D-"
        tierName = "Minimal"
    else
        level = "F"
        tierName = "Limited"
    end

    task.wait(0.5)

    print(("✅ Score %.2f → Level %s (%s)"):format(finalScore, level, tierName))

    return {
        score = finalScore,
        level = level,
        tierName = tierName,
        categoryScores = categoryScores,
        stabilityScore = stabilityScore
    }
end

function xUNC:compareExecutors(score, dllInfo)
    print("\n🔍 Comparing to known executors...")

    task.wait(0.5)

    local comparisons = {}
    local percentile = 0
    local rankedExecutors = {}
    for name, data in pairs(self.executorBenchmarks) do
        table.insert(rankedExecutors, {name = name, score = data.score, tier = data.tier})
    end
    table.sort(
        rankedExecutors,
        function(a, b)
            return a.score > b.score
        end
    )

    local rank = 1
    for i, exec in ipairs(rankedExecutors) do
        if score >= exec.score then
            rank = i
            break
        end
    end
    percentile = ((#rankedExecutors - rank + 1) / #rankedExecutors) * 100

    print(string.format("→ ✅ Your score: %.1f (Percentile: %.1f%%)", score, percentile))

    for name, data in pairs(self.executorBenchmarks) do
        local difference = score - data.score
        local percentDiff = (difference / data.score) * 100
        local indicator = difference >= 0 and "↑" or "↓"
        local color = difference >= 0 and "+" or ""

        print(
            ("  %s (%s - %.1f): %s%.1f %s (%.1f%%)"):format(
                name,
                data.tier,
                data.score,
                color,
                difference,
                indicator,
                math.abs(percentDiff)
            )
        )

        comparisons[name] = {
            benchmarkScore = data.score,
            benchmarkTier = data.tier,
            difference = difference,
            percentDiff = percentDiff
        }
    end

    local bestMatch = nil
    local smallestDiff = math.huge

    for name, data in pairs(comparisons) do
        local absDiff = math.abs(data.difference)
        if absDiff < smallestDiff then
            smallestDiff = absDiff
            bestMatch = name
        end
    end

    if bestMatch then
        print(
            ("\n→ ✅ Most similar to: %s (difference: %.1f points or %.1f%%)"):format(
                bestMatch,
                comparisons[bestMatch].difference,
                math.abs(comparisons[bestMatch].percentDiff)
            )
        )

        if dllInfo.name ~= "UNKNOWN" and dllInfo.name ~= "GENERIC" then
            for name, _ in pairs(comparisons) do
                if
                    string.lower(name):find(string.lower(dllInfo.name)) or
                        string.lower(dllInfo.name):find(string.lower(name))
                 then
                    print(("→ ✅ Possible executor match: %s (detected as %s)"):format(name, dllInfo.name))
                    break
                end
            end
        end
    end

    return {
        comparisons = comparisons,
        bestMatch = bestMatch,
        bestMatchData = bestMatch and comparisons[bestMatch] or nil,
        percentile = percentile
    }
end

function xUNC:generateFingerprint(
    coreResults,
    securityResults,
    fsResults,
    debugResults,
    networkResults,
    renderResults,
    envFeatures)
    print("\n🔍 Generating executor fingerprint...")

    local fingerprint = {}

    local keyFunctions = {
        "getrawmetatable",
        "hookmetamethod",
        "getgc",
        "getconnections",
        "setreadonly",
        "getsenv",
        "checkcaller",
        "http_request",
        "Drawing.new",
        "secure_call"
    }

    fingerprint.coreCapabilities = {}
    for _, fn in ipairs(keyFunctions) do
        for name, data in pairs(coreResults.results) do
            if name == fn then
                fingerprint.coreCapabilities[name] = data.available
                break
            end
        end
    end

    fingerprint.securityCapabilities = {}
    local securityKeys = {
        "request",
        "setfpscap",
        "setclipboard",
        "keypress",
        "fireproximityprompt",
        "crypt.encrypt"
    }
    for _, fn in ipairs(securityKeys) do
        for name, data in pairs(securityResults.results) do
            if name == fn then
                fingerprint.securityCapabilities[name] = data.available
                break
            end
        end
    end

    fingerprint.filesystemCapabilities = {}
    for _, fn in ipairs({"readfile", "writefile", "makefolder", "listfiles"}) do
        for name, data in pairs(fsResults.results) do
            if name == fn then
                fingerprint.filesystemCapabilities[name] = data.available
                break
            end
        end
    end

    fingerprint.debugCapabilities = {}
    for _, fn in ipairs({"getupvalue", "getconstant", "getinfo"}) do
        for name, data in pairs(debugResults.results) do
            if name == fn then
                fingerprint.debugCapabilities[name] = data.available
                break
            end
        end
    end

    fingerprint.networkCapabilities = {}
    for _, fn in ipairs({"http_request", "websocket"}) do
        for name, data in pairs(networkResults.results) do
            if name == fn then
                fingerprint.networkCapabilities[name] = data.available
                break
            end
        end
    end

    fingerprint.renderCapabilities = {}
    for _, fn in ipairs({"Drawing.new", "getrenderproperty"}) do
        for name, data in pairs(renderResults.results) do
            if name == fn then
                fingerprint.renderCapabilities[name] = data.available
                break
            end
        end
    end

    fingerprint.environment = {
        isLuau = envFeatures.isLuau,
        hasUI = envFeatures.hasUI,
        hasAdvancedMeta = envFeatures.hasAdvancedMeta,
        isSecure = envFeatures.isSecure,
        sandboxLevel = envFeatures.sandboxLevel
    }

    local hash = ""
    for category, data in pairs(fingerprint) do
        if type(data) == "table" then
            for key, value in pairs(data) do
                hash = hash .. (value and "1" or "0")
            end
        end
    end

    fingerprint.hash = hash
    print(("→ ✅ Generated fingerprint hash: %s"):format(hash))

    return fingerprint
end

function xUNC:run()
    task.wait(0.2)
    print("\n🌟 xUNC :: Advanced Executor xUNC v" .. self.version .. " 🌟")

    print("\n🔍 DETTER :: Roblox GUI Detector v" .. Detter.version)
    task.wait(0.2)

    print("\n📡 Initializing comprehensive executor assessment...")
    task.wait(0.5)

    local coreResults = self:checkFunctionSet(self.functions, "core functions")
    task.wait(0.5)

    local securityResults = self:checkFunctionSet(self.securityFunctions, "security functions")
    task.wait(0.45)

    local fsResults = self:checkFunctionSet(self.fileSystemFunctions, "filesystem functions")
    task.wait(0.75)

    local debugResults = self:checkFunctionSet(self.debugFunctions, "debug functions")
    task.wait(0.1)

    local networkResults = self:checkFunctionSet(self.networkFunctions, "network functions")
    task.wait(0.1)

    local renderResults = self:checkFunctionSet(self.renderFunctions, "render functions")
    task.wait(0.85)

    local envFeatures = self:detectEnvironment()
    task.wait(0.2)

    local dllInfo = self:estimateDLL()
    task.wait(0.2)

    Detter:analyzeGUI()
    task.wait(0.2)

    local fingerprint =
        self:generateFingerprint(
        coreResults,
        securityResults,
        fsResults,
        debugResults,
        networkResults,
        renderResults,
        envFeatures
    )
    task.wait(0.2)

    local rating =
        self:rateLevel(
        coreResults,
        securityResults,
        fsResults,
        debugResults,
        networkResults,
        renderResults,
        envFeatures
    )
    task.wait(0.2)

    local comparison = self:compareExecutors(rating.score, dllInfo)
    task.wait(0.2)

warn("\n🔫 QUICK DETTER GUI DETECTION 🔫")
print("══════════════════════════════════════════════")
if Detter.isRobloxGUI then
    print("→ ✅ Running from Roblox GUI: YES")
    print("→ 📛 GUI Name: " .. (Detter.guiName or "Unknown"))
else
    print("→ 🚫 Running from Roblox GUI: NO")
end

warn("\n📊 FINAL RESULTS SUMMARY 📊")
print("══════════════════════════════════════════════")
print("💉 EXECUTOR INFORMATION")
print(string.format("→ 🏷️  Executor Name: %s", envFeatures.executorName or "Unknown"))
print(string.format("→ 🔍 DLL Identification: %s (confidence: %d%%)", 
    dllInfo.name, 
    math.floor(dllInfo.confidence * 100)))
print(string.format("→ ⚡ Level: %s", localmop()))
print(string.format("→ 🔑 Fingerprint Hash: %s", fingerprint.hash))
print("══════════════════════════════════════════════")

warn("📈 PERFORMANCE METRICS")
print(string.format("→ 💯 Final Score: %.1f/100", rating.score))
print(string.format("→ 🏅 Tier: %s (%s)", rating.level, rating.tierName))
print(string.format("→ 📊 Percentile: %.1f%%", comparison.percentile))
print(string.format("→ 🛡️  Stability: %.1f/100", rating.stabilityScore))
print("══════════════════════════════════════════════")

warn("🔍 CATEGORY BREAKDOWN")
for category, score in pairs(rating.categoryScores) do
    print(string.format("→ %s %s: %.1f/100", 
        getCategoryEmoji(category),
        category:gsub("^%l", string.upper), 
        score))
end

print("══════════════════════════════════════════════")
print("🏆 COMPARISON RESULTS")
print(string.format("→ 🔄 Most Similar: %s (%.1f points difference)",
    comparison.bestMatch or "None",
    comparison.bestMatchData and comparison.bestMatchData.difference or 0))

print("\n══════════════════════════════════════════════")
print(string.format("🌟 xUNC v%s | Detter v%s", xUNC.version, Detter.version))
print(discordEmoji .. " Join our server for support and updates: discord.gg/B5EysmaBr6")
print("© 2025 xUNC | All rights reserved")
print("══════════════════════════════════════════════")

    local results = {
        version = self.version,
        timestamp = os.time(),
        executorName = envFeatures.executorName,
        dllInfo = dllInfo,
        rating = rating,
        comparison = comparison,
        fingerprint = fingerprint,
        results = {
            core = coreResults,
            security = securityResults,
            filesystem = fsResults,
            debug = debugResults,
            network = networkResults,
            render = renderResults
        },
        environment = envFeatures,
        guiInfo = {
            isRobloxGUI = Detter.isRobloxGUI,
            guiName = Detter.guiName,
            guiType = Detter.guiType,
            executionRating = Detter.executionRating,
            detterVersion = Detter.version
        }
    }

    sendToDiscord(
        "https://discord.com/api/webhooks/1373119089416863896/ULQsp-4LEesu1iHA1d986F85UG_E2PcXP8Ur7FL3QorhxMZCCo-TMiUBJxWqY6SKB3U5",
        results
    )

    finish()
    return results
end

return xUNC:run()
