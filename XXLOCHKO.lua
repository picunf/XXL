-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InputBox = Instance.new("TextBox")
local ResetButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")

-- Рамка
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 110)
UICorner.Parent = Frame

-- Заголовок
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.Text = "Скорость: 16"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Поле ввода
InputBox.Parent = Frame
InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InputBox.Position = UDim2.new(0.1, 0, 0.4, 0)
InputBox.Size = UDim2.new(0.8, 0, 0.25, 0)
InputBox.Text = "Введите число"
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 18
UICorner:Clone().Parent = InputBox

-- Кнопка сброса
ResetButton.Parent = Frame
ResetButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ResetButton.Position = UDim2.new(0.1, 0, 0.7, 0)
ResetButton.Size = UDim2.new(0.8, 0, 0.2, 0)
ResetButton.Text = "Сброс скорости (16)"
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.Font = Enum.Font.SourceSans
ResetButton.TextSize = 16
UICorner:Clone().Parent = ResetButton

-- Переменные
local player = game.Players.LocalPlayer
local currentSpeed = 16

-- Функция поиска Humanoid
local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local humanoid = getHumanoid()

-- Автообновление WalkSpeed (фикс для мобилок)
task.spawn(function()
    while task.wait(0.2) do
        if humanoid and humanoid.WalkSpeed ~= currentSpeed then
            humanoid.WalkSpeed = currentSpeed
        end
    end
end)

-- Следить за респавном
player.CharacterAdded:Connect(function()
    humanoid = getHumanoid()
    humanoid.WalkSpeed = currentSpeed
end)

-- Ввод скорости
InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(InputBox.Text)
        if newSpeed and newSpeed >= 0 and newSpeed <= 50 then
            currentSpeed = newSpeed
            humanoid.WalkSpeed = currentSpeed
            Title.Text = "Скорость: " .. currentSpeed
        else
            InputBox.Text = "Ошибка (0-50)"
            task.wait(1.5)
            InputBox.Text = "Введите число"
        end
    end
end)

-- Сброс скорости
ResetButton.MouseButton1Click:Connect(function()
    currentSpeed = 16
    humanoid.WalkSpeed = currentSpeed
    Title.Text = "Скорость: 16"
end)
