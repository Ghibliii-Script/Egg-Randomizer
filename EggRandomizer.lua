local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 📦 GUI Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "EggRandomizerGUI"
screenGui.ResetOnSpawn = false

-- 🪟 Main draggable frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
mainFrame.Active = true
mainFrame.Draggable = true

-- 🧾 Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🥚 Egg Randomizer"
title.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true

-- 🐣 Result label
local resultLabel = Instance.new("TextLabel", mainFrame)
resultLabel.Size = UDim2.new(1, -20, 0, 60)
resultLabel.Position = UDim2.new(0, 10, 0, 50)
resultLabel.Text = "Waiting..."
resultLabel.BackgroundTransparency = 1
resultLabel.TextScaled = true
resultLabel.TextColor3 = Color3.new(0, 0, 0)

-- 🎯 Hatch button
local hatchButton = Instance.new("TextButton", mainFrame)
hatchButton.Size = UDim2.new(0, 200, 0, 40)
hatchButton.Position = UDim2.new(0.5, -100, 1, -50)
hatchButton.Text = "🎲 Randomize Egg"
hatchButton.BackgroundColor3 = Color3.fromRGB(255, 230, 180)
hatchButton.TextScaled = true

-- 🐾 Egg data
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

local canHatch = true

-- 🎲 Hatch logic with 10s cooldown
hatchButton.MouseButton1Click:Connect(function()
	if not canHatch then
		resultLabel.Text = "⏳ Please wait..."
		return
	end

	-- Random egg and pet
	local eggNames = {}
	for eggName in pairs(eggPets) do
		table.insert(eggNames, eggName)
	end
	local randomEgg = eggNames[math.random(1, #eggNames)]
	local petList = eggPets[randomEgg]
	local randomPet = petList[math.random(1, #petList)]

	-- Show result
	resultLabel.Text = "🥚 Egg: " .. randomEgg .. "\n🎉 Pet: " .. randomPet

	-- Cooldown
	canHatch = false
	hatchButton.Text = "⏳ Cooling down..."
	task.delay(10, function()
		canHatch = true
		hatchButton.Text = "🎲 Randomize Egg"
	end)
end)
