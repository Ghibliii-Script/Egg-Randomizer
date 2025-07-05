local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 📦 Setup GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PlainEggRandomizer"

-- 🧾 Dropdown label
local dropdownLabel = Instance.new("TextLabel", screenGui)
dropdownLabel.Size = UDim2.new(0, 200, 0, 30)
dropdownLabel.Position = UDim2.new(0.5, -100, 0.3, 0)
dropdownLabel.Text = "Select Egg"
dropdownLabel.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)

-- 🧾 Dropdown frame
local dropdownFrame = Instance.new("Frame", screenGui)
dropdownFrame.Size = UDim2.new(0, 200, 0, 180)
dropdownFrame.Position = UDim2.new(0.5, -100, 0.3, 35)
dropdownFrame.Visible = false

-- 🧾 Result label
local resultLabel = Instance.new("TextLabel", screenGui)
resultLabel.Size = UDim2.new(0, 300, 0, 40)
resultLabel.Position = UDim2.new(0.5, -150, 0.7, 0)
resultLabel.Text = "Waiting..."
resultLabel.TextColor3 = Color3.new(1, 1, 1)
resultLabel.BackgroundTransparency = 1
resultLabel.TextScaled = true

-- 🧾 Hatch button
local hatchButton = Instance.new("TextButton", screenGui)
hatchButton.Size = UDim2.new(0, 200, 0, 40)
hatchButton.Position = UDim2.new(0.5, -100, 0.7, 50)
hatchButton.Text = "Hatch Egg"

-- 🐣 Eggs and their pets
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

local selectedEgg = nil
local canHatch = true

-- 🧾 Create egg buttons
for eggName, pets in pairs(eggPets) do
	local eggBtn = Instance.new("TextButton", dropdownFrame)
	eggBtn.Size = UDim2.new(1, 0, 0, 20)
	eggBtn.Text = eggName
	eggBtn.MouseButton1Click:Connect(function()
		selectedEgg = eggName
		dropdownLabel.Text = "Selected: " .. eggName
		dropdownFrame.Visible = false
	end)
end

-- 🔄 Toggle dropdown
dropdownLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dropdownFrame.Visible = not dropdownFrame.Visible
	end
end)

-- 🕒 Hatch logic with 10s cooldown
hatchButton.MouseButton1Click:Connect(function()
	if not selectedEgg then
		resultLabel.Text = "⚠️ Select an egg first!"
		return
	end
	if not canHatch then
		resultLabel.Text = "⏳ Please wait for cooldown..."
		return
	end

	-- Immediately show pet
	local pets = eggPets[selectedEgg]
	local chosenPet = pets[math.random(1, #pets)]
	resultLabel.Text = "🎉 You got: " .. chosenPet

	-- Cooldown
	canHatch = false
	hatchButton.Text = "Cooldown (10s)"
	task.delay(10, function()
		canHatch = true
		hatchButton.Text = "Hatch Egg"
	end)
end)
