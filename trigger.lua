local enabled = true
local toggle = Enum.KeyCode.F
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- Function to send a notification
local function sendNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 2; -- Default duration is 2 seconds
    })
end

runService.RenderStepped:Connect(function()
    if enabled then
        local target = mouse.Target
        if target and target.Parent then
            local success, humanoid = pcall(function()
                return target.Parent:FindFirstChildOfClass("Humanoid")
            end)
            
            if success and humanoid and humanoid.Health > 0 then
                mouse1press()
                repeat
                    runService.RenderStepped:Wait()
                until not humanoid or humanoid.Health <= 0
                mouse1release()
            end
        end
    end
end)

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == toggle then
        enabled = not enabled
        if enabled then
            sendNotification("Trigger Status", "Enabled", 2)
        else
            sendNotification("Trigger Status", "Disabled", 2)
        end
    end
end)
