local enabled = true
local toggle = Enum.KeyCode.F
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
game:GetService("RunService").RenderStepped:Connect(function()
    if mouse.Target.Parent:FindFirstChildOfClass("Humanoid") and mouse.Target.Parent:FindFirstChildOfClass("Humanoid").Health > 0 and game:GetService("Players"):GetPlayerFromCharacter(mouse.Target.Parent).Team ~= game:GetService("Players").LocalPlayer.Team and enabled then
        mouse1press()
        repeat
            game:GetService("RunService").RenderStepped:Wait()
        until not mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
        mouse1release()
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i,gp)
    if i.KeyCode == toggle then
        enabled = not enabled
        local hint = Instance.new("Hint",game.CoreGui)
        hint.Text = "Toggled: "..tostring(enabled)
        wait(1.5)
        hint:Destroy()
    end
end)