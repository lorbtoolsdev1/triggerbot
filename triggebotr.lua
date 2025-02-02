local enabled = true
local toggle = Enum.KeyCode.F
local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local starterGui = game:GetService("StarterGui")

local lastShotTime = 0  -- Stores the last time a shot was fired

-- Function to show a notification message
local function notify(message)
    pcall(function()
        starterGui:SetCore("SendNotification", {
            Title = "Auto Shoot",
            Text = message,
            Duration = 1.5
        })
    end)
end

-- Auto-shoot logic with delay
runService.Heartbeat:Connect(function()
    if enabled then
        local currentTime = tick()
        if currentTime - lastShotTime >= 2 then  -- 2-second delay between shots
            local target = mouse.Target
            if target and target.Parent then
                local success, humanoid = pcall(function()
                    return target.Parent:FindFirstChildOfClass("Humanoid")
                end)

                if success and humanoid and humanoid.Health > 0 then
                    lastShotTime = currentTime  -- Update last shot time
                    mouse1press()
                    task.wait(0.1)  -- Simulate brief shooting action
                    mouse1release()
                    task.wait(2)  -- Delay before shooting again
                end
            end
        end
    end
end)

-- Toggle auto-shoot on key press
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == toggle and not gameProcessed then
        enabled = not enabled
        notify("Auto Shoot: " .. (enabled and "Enabled ✅" or "Disabled ❌"))
    end
end)
