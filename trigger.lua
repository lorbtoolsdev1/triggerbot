local enabled = true
local toggle = Enum.KeyCode.F
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

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
        local hint = Instance.new("Hint", game.CoreGui)
        hint.Text = "Lorb Trigger: " .. tostring(enabled)
        wait(1.5)
        hint:Destroy()
    end
end)  