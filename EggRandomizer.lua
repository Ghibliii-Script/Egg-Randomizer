local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "AutoEggRandomizer"
screenGui.ResetOnSpawn = false

-- Main Frame (Draggable)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 130)
frame.Position = UDim2.new(1, -210, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Auto Stop Button
local stopBtn = Instance.new("TextButton", frame)
stopBtn.Size = UDim2.new(1, 0, 0, 30)
stopBtn.Position = UDim2.new(0, 0, 0, 0)
stopBtn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.TextScaled = true
stopBtn.Text = "🔴 Auto Stop: ON"

-- Auto Randomizer Button
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(1, 0, 0, 30)
autoBtn.Position = UDim2.new(0, 0, 0, 30)
autoBtn.BackgroundColor3 = Color3.fromRGB(0, 90, 0)
autoBtn.TextColor3 = Color3.new(1, 1, 1)
autoBtn.TextScaled = true
autoBtn.Text = "🟢 Auto Randomizer: ON"

-- Countdown Label
local countdownLabel = Instance.new("TextLabel", frame)
countdownLabel.Size = UDim2.new(1, 0, 0, 25)
countdownLabel.Position = UDim2.new(0, 0, 0, 60)
countdownLabel.BackgroundTransparency = 1
countdownLabel.TextColor3 = Color3.new(1, 1, 1)
countdownLabel.TextScaled = true
countdownLabel.Text = "Changing in: 30"

-- Pet Display
local petLabel = Instance.new("TextLabel", frame)
petLabel.Size = UDim2.new(1, -10, 0, 25)
petLabel.Position = UDim2.new(0, 5, 0, 90)
petLabel.BackgroundTransparency = 1
petLabel.TextColor3 = Color3.new(1, 1, 1)
petLabel.TextScaled = true
petLabel.Text = "Waiting..."

-- Help Button
local helpBtn = Instance.new("TextButton", frame)
helpBtn.Size = UDim2.new(0, 25, 0, 25)
helpBtn.Position = UDim2.new(1, -28, 0, 3)
helpBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
helpBtn.TextColor3 = Color3.new(1, 1, 1)
helpBtn.Text = "?"

helpBtn.MouseButton1Click:Connect(function()
	warn("Auto Egg Randomizer: Visual-only tool. Randomizes fake eggs/pets every 30s.")
end)

-- Egg + Pet Table
local eggPets = {
	Common = {"Golden Lab", "Dog", "Bunny"},
	Uncommon = {"Black Bunny", "Chicken", "Cat", "Deer"},
	Rare = {"Orange Tabby", "Spotted Deer", "Pig", "Rooster", "Monkey"},
	Legendary = {"Cow", "Silver Monkey", "Sea Otter", "Turtle", "Polar Bear"},
	Bug = {"Snail", "Giant Ant", "Caterpillar", "Praying Mantis", "Dragonfly"},
	Night = {"Hedgehog", "Mole", "Frog", "Echo Frog", "Night Owl", "Raccoon"},
	Mythical = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
	Oasis = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox"}
}

-- Auto Control States
local autoRunning = true
local autoRandomizer = true

-- Toggle Auto Stop
stopBtn.MouseButton1Click:Connect(function()
	autoRunning = not autoRunning
	stopBtn.Text = autoRunning and "🔴 Auto Stop: ON" or "🟢 Auto Stop: OFF"
end)

-- Toggle Auto Randomizer
autoBtn.MouseButton1Click:Connect(function()
	autoRandomizer = not autoRandomizer
	autoBtn.Text = autoRandomizer and "🟢 Auto Randomizer: ON" or "🔴 Auto Randomizer: OFF"
end)

-- Main Randomizer Loop
task.spawn(function()
	local timer = 30
	while true do
		if autoRunning and autoRandomizer then
			countdownLabel.Text = "Changing in: " .. timer
			timer -= 1
			if timer <= 0 then
				-- Randomize
				local eggNames = {}
				for egg in pairs(eggPets) do
					table.insert(eggNames, egg)
				end
				local selectedEgg = eggNames[math.random(1, #eggNames)]
				local selectedPet = eggPets[selectedEgg][math.random(1, #eggPets[selectedEgg])]
				petLabel.Text = selectedEgg .. " Egg | " .. selectedPet
				timer = 30
			end
		else
			countdownLabel.Text = "Paused"
		end
		task.wait(1)
	end
end)
