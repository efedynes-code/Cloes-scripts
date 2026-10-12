-- Cloes MM2 + Muscle Legends Menü v5.0
-- By Cloes

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "CLOES MENÜ | MM2 & Muscle Legends",
   LoadingTitle = "Cloes yükleniyor...",
   LoadingSubtitle = "By Cloes",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Cloes",
      FileName = "CloesMenu"
   },
   KeySystem = false
})

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- ============ MM2 SEKMESİ ============
local MM2Tab = Window:CreateTab("MM2", 4483362458)

MM2Tab:CreateSection("Genel")

MM2Tab:CreateButton({
   Name = "Coin Farm (Otomatik Para)",
   Callback = function()
       local farm = true
       task.spawn(function()
           while farm do
               task.wait(0.5)
               for _, v in pairs(workspace:GetChildren()) do
                   if v:IsA("BasePart") and (v.Name == "Coin" or v.Name == "Cash" or v.Name == "Money") then
                       root.CFrame = v.CFrame
                       task.wait(0.1)
                   end
               end
           end
       end)
   end,
})

MM2Tab:CreateButton({
   Name = "Kill All (Sadece Murder)",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
               if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                   v.Character.Humanoid.Health = 0
               end
           end
       end
   end,
})

MM2Tab:CreateToggle({
   Name = "Auto Shout Murder (Sadece Sheriff)",
   CurrentValue = false,
   Flag = "AutoShout",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(2)
                   local isSheriff = false
                   for _, v in pairs(player.Backpack:GetChildren()) do
                       if v.Name == "Gun" or v.Name == "Revolver" then
                           isSheriff = true
                       end
                   end
                   if isSheriff then
                       game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Murder: " .. tostring(game.Players:GetPlayers()[1].Name), "All")
                   end
               end
           end)
       end
   end,
})

MM2Tab:CreateButton({
   Name = "Auto Throw (Sadece Murder)",
   Callback = function()
       task.spawn(function()
           while true do
               task.wait(0.5)
               local isMurder = false
               for _, v in pairs(player.Backpack:GetChildren()) do
                   if v.Name == "Knife" then
                       isMurder = true
                   end
               end
               if isMurder then
                   for _, v in pairs(game.Players:GetPlayers()) do
                       if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                           local args = {v.Character.HumanoidRootPart}
                           game:GetService("ReplicatedStorage").ThrowKnife:FireServer(unpack(args))
                       end
                   end
               end
           end
       end)
   end,
})

MM2Tab:CreateToggle({
   Name = "Wall Shots (Sadece Sheriff)",
   CurrentValue = false,
   Flag = "WallShots",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(0.1)
                   for _, v in pairs(game.Players:GetPlayers()) do
                       if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                           local args = {v.Character.HumanoidRootPart}
                           game:GetService("ReplicatedStorage").ShootGun:FireServer(unpack(args))
                       end
                   end
               end
           end)
       end
   end,
})

-- ============ ESP SEKMESİ ============
local ESPTab = Window:CreateTab("ESP", 4483362458)

ESPTab:CreateSection("Oyuncu ESP")

ESPTab:CreateToggle({
   Name = "ESP (İsim + Rol)",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(Value)
       if Value then
           for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= player and v.Character then
                   local h = Instance.new("Highlight")
                   h.Parent = v.Character
                   if v.Backpack:FindFirstChild("Knife") then
                       h.FillColor = Color3.fromRGB(255, 0, 0)
                   elseif v.Backpack:FindFirstChild("Gun") then
                       h.FillColor = Color3.fromRGB(0, 0, 255)
                   else
                       h.FillColor = Color3.fromRGB(0, 255, 0)
                   end
                   h.OutlineColor = Color3.fromRGB(255, 255, 255)
                   
                   local billboard = Instance.new("BillboardGui")
                   billboard.Parent = v.Character
                   billboard.Size = UDim2.new(0, 200, 0, 50)
                   billboard.StudsOffset = Vector3.new(0, 3, 0)
                   billboard.AlwaysOnTop = true
                   
                   local text = Instance.new("TextLabel")
                   text.Parent = billboard
                   text.Size = UDim2.new(1, 0, 1, 0)
                   text.BackgroundTransparency = 1
                   text.TextColor3 = Color3.fromRGB(255, 255, 255)
                   text.TextStrokeTransparency = 0
                   text.TextScaled = true
                   if v.Backpack:FindFirstChild("Knife") then
                       text.Text = "MURDER"
                   elseif v.Backpack:FindFirstChild("Gun") then
                       text.Text = "SHERIFF"
                   else
                       text.Text = "INNOCENT"
                   end
               end
           end
       else
           for _, v in pairs(game.Players:GetPlayers()) do
               if v.Character then
                   if v.Character:FindFirstChildOfClass("Highlight") then
                       v.Character:FindFirstChildOfClass("Highlight"):Destroy()
                   end
                   if v.Character:FindFirstChildOfClass("BillboardGui") then
                       v.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                   end
               end
           end
       end
   end,
})

-- ============ TELEPORT SEKMESİ ============
local TPTab = Window:CreateTab("Teleport", 4483362458)

TPTab:CreateSection("Maplar")

local maps = {"Hospital", "House", "Mansion", "Office", "Bank", "Hotel"}

for _, mapName in pairs(maps) do
   TPTab:CreateButton({
       Name = mapName,
       Callback = function()
           for _, v in pairs(workspace:GetChildren()) do
               if v.Name:lower():find(mapName:lower()) then
                   if v:FindFirstChild("TeleportPart") then
                       root.CFrame = v.TeleportPart.CFrame
                   end
               end
           end
       end,
   })
end

-- ============ MUSCLE LEGENDS SEKMESİ ============
local MLTab = Window:CreateTab("Muscle Legends", 4483362458)

MLTab:CreateSection("Otomatik")

MLTab:CreateToggle({
   Name = "Auto Dambıl (Otomatik Kas)",
   CurrentValue = false,
   Flag = "AutoDambil",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(1)
                   local args = {true}
                   game:GetService("ReplicatedStorage").Events.Dambil:FireServer(unpack(args))
               end
           end)
       end
   end,
})

MLTab:CreateToggle({
   Name = "Auto Şınav",
   CurrentValue = false,
   Flag = "AutoSinav",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(1)
                   local args = {true}
                   game:GetService("ReplicatedStorage").Events.Sinav:FireServer(unpack(args))
               end
           end)
       end
   end,
})

MLTab:CreateToggle({
   Name = "Auto Mekik",
   CurrentValue = false,
   Flag = "AutoMekik",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(1)
                   local args = {true}
                   game:GetService("ReplicatedStorage").Events.Mekik:FireServer(unpack(args))
               end
           end)
       end
   end,
})

MLTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(2)
                   game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
               end
           end)
       end
   end,
})

MLTab:CreateButton({
   Name = "Güvenli Yere Işınlan",
   Callback = function()
       root.CFrame = CFrame.new(0, 100, 0)
   end,
})

MLTab:CreateSection("Teleport")

local islands = {"Island1", "Island2", "Island3", "Island4", "Island5"}

for _, island in pairs(islands) do
   MLTab:CreateButton({
       Name = island,
       Callback = function()
           for _, v in pairs(workspace:GetChildren()) do
               if v.Name == island then
                   root.CFrame = v.CFrame + Vector3.new(0, 10, 0)
               end
           end
       end,
   })
end

-- ============ HAKKINDA ============
Window:CreateTab("Hakkında", 4483362458):CreateParagraph({
   Title = "CLOES MENÜ",
   Content = "Bu script Cloes tarafından yapılmıştır. By Cloes. İyi eğlenceler."
})

Rayfield:Notify({
   Title = "CLOES MENÜ",
   Content = "Menü yüklendi! By Cloes",
   Duration = 5,
   Image = 4483362458,
})

print("Cloes Menü yüklendi. By Cloes.")
