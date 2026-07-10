local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- 1. Criando a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PainelHacksSupremoV5"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Variáveis de estado
local posicaoSalva = nil
local puloInfinitoAtivo = false
local velocidadeAlvo = 16
local walkSpeedAtivo = false 
local loopTpAtivo = false
local intervaloLoopTp = 1.0
local modoLoopTp = "Salvo"
local minimizado = false

-- Variáveis da função Pulo Boost e MM2
local mmvAtivo = false
local isBoostingMMV = false
local autoFacaAtivo = false

-- Configurações do Menu
local VALOR_MIN = 16
local VALOR_MAX = 250
local TAMANHO_PADRAO_X = 260
local TAMANHO_PADRAO_Y = 280
local TAMANHO_MAX_X = 350
local TAMANHO_MAX_Y = 450
local TAMANHO_MIN_X = 200 
local TAMANHO_MIN_Y = 200

-- 2. Frame Principal
local framePrincipal = Instance.new("Frame")
framePrincipal.Size = UDim2.new(0, TAMANHO_PADRAO_X, 0, TAMANHO_PADRAO_Y)
framePrincipal.Position = UDim2.new(0.5, -130, 0.4, -140)
framePrincipal.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
framePrincipal.BorderSizePixel = 0
framePrincipal.Active = true
framePrincipal.Draggable = true
framePrincipal.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = framePrincipal

-- Título do Painel
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, -60, 0, 35)
titulo.Position = UDim2.new(0, 12, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "Menu Avançado V5"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.TextXAlignment = Enum.TextXAlignment.Left
titulo.Font = Enum.Font.SourceSansBold
titulo.TextSize = 16
titulo.Parent = framePrincipal

-- Botões superiores
local btnMinimizar = Instance.new("TextButton")
btnMinimizar.Size = UDim2.new(0, 25, 0, 25)
btnMinimizar.Position = UDim2.new(1, -55, 0, 5)
btnMinimizar.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
btnMinimizar.Text = "-"
btnMinimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMinimizar.Font = Enum.Font.SourceSansBold
btnMinimizar.TextSize = 16
btnMinimizar.Parent = framePrincipal
Instance.new("UICorner", btnMinimizar).CornerRadius = UDim.new(0, 4)

local btnFechar = Instance.new("TextButton")
btnFechar.Size = UDim2.new(0, 25, 0, 25)
btnFechar.Position = UDim2.new(1, -30, 0, 5)
btnFechar.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
btnFechar.Text = "X"
btnFechar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFechar.Font = Enum.Font.SourceSansBold
btnFechar.TextSize = 14
btnFechar.Parent = framePrincipal
Instance.new("UICorner", btnFechar).CornerRadius = UDim.new(0, 4)

-- ==========================================
-- INTERFACE DE ABAS
-- ==========================================
local barAbas = Instance.new("Frame")
barAbas.Size = UDim2.new(1, 0, 0, 30)
barAbas.Position = UDim2.new(0, 0, 0, 35)
barAbas.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
barAbas.BorderSizePixel = 0
barAbas.Parent = framePrincipal

-- Dividindo o espaço (33% para cada)
local tabBtnTeleporte = Instance.new("TextButton")
tabBtnTeleporte.Size = UDim2.new(0.33, 0, 1, 0)
tabBtnTeleporte.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tabBtnTeleporte.Text = "Teleporte"
tabBtnTeleporte.TextColor3 = Color3.fromRGB(255, 255, 255)
tabBtnTeleporte.Font = Enum.Font.SourceSansBold
tabBtnTeleporte.TextSize = 13
tabBtnTeleporte.BorderSizePixel = 0
tabBtnTeleporte.Parent = barAbas

local tabBtnMods = Instance.new("TextButton")
tabBtnMods.Size = UDim2.new(0.34, 0, 1, 0)
tabBtnMods.Position = UDim2.new(0.33, 0, 0, 0)
tabBtnMods.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabBtnMods.Text = "Mods"
tabBtnMods.TextColor3 = Color3.fromRGB(150, 150, 150)
tabBtnMods.Font = Enum.Font.SourceSansBold
tabBtnMods.TextSize = 13
tabBtnMods.BorderSizePixel = 0
tabBtnMods.Parent = barAbas

local tabBtnMM2 = Instance.new("TextButton")
tabBtnMM2.Size = UDim2.new(0.33, 0, 1, 0)
tabBtnMM2.Position = UDim2.new(0.67, 0, 0, 0)
tabBtnMM2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabBtnMM2.Text = "MM2"
tabBtnMM2.TextColor3 = Color3.fromRGB(150, 150, 150)
tabBtnMM2.Font = Enum.Font.SourceSansBold
tabBtnMM2.TextSize = 13
tabBtnMM2.BorderSizePixel = 0
tabBtnMM2.Parent = barAbas

-- ScrollingFrames (Telas rolaveis)
local containerTeleportes = Instance.new("ScrollingFrame")
containerTeleportes.Size = UDim2.new(1, 0, 1, -65)
containerTeleportes.Position = UDim2.new(0, 0, 0, 65)
containerTeleportes.BackgroundTransparency = 1
containerTeleportes.BorderSizePixel = 0
containerTeleportes.ScrollBarThickness = 5 
containerTeleportes.ScrollingDirection = Enum.ScrollingDirection.Y
containerTeleportes.CanvasSize = UDim2.new(0, 0, 0, 310) 
containerTeleportes.Visible = true
containerTeleportes.Parent = framePrincipal

local containerMods = Instance.new("ScrollingFrame")
containerMods.Size = UDim2.new(1, 0, 1, -65)
containerMods.Position = UDim2.new(0, 0, 0, 65)
containerMods.BackgroundTransparency = 1
containerMods.BorderSizePixel = 0
containerMods.ScrollBarThickness = 5
containerMods.ScrollingDirection = Enum.ScrollingDirection.Y
containerMods.CanvasSize = UDim2.new(0, 0, 0, 220) 
containerMods.Visible = false
containerMods.Parent = framePrincipal

local containerMM2 = Instance.new("ScrollingFrame")
containerMM2.Size = UDim2.new(1, 0, 1, -65)
containerMM2.Position = UDim2.new(0, 0, 0, 65)
containerMM2.BackgroundTransparency = 1
containerMM2.BorderSizePixel = 0
containerMM2.ScrollBarThickness = 5
containerMM2.ScrollingDirection = Enum.ScrollingDirection.Y
containerMM2.CanvasSize = UDim2.new(0, 0, 0, 100) 
containerMM2.Visible = false
containerMM2.Parent = framePrincipal

local layoutMM2 = Instance.new("UIListLayout")
layoutMM2.Padding = UDim.new(0, 8)
layoutMM2.HorizontalAlignment = Enum.HorizontalAlignment.Center
layoutMM2.Parent = containerMM2

local function criarBotao(nome, texto, posicao, cor, pai)
	local b = Instance.new("TextButton")
	b.Name = nome
	b.Size = UDim2.new(1, -20, 0, 32)
	if posicao then b.Position = posicao end
	b.BackgroundColor3 = cor
	b.Text = texto
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.SourceSansBold
	b.TextSize = 14
	b.BorderSizePixel = 0
	b.Parent = pai
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
	return b
end

-- Lógica de Alternância de Abas
local function resetarAbas()
	containerTeleportes.Visible = false
	containerMods.Visible = false
	containerMM2.Visible = false
	
	tabBtnTeleporte.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	tabBtnTeleporte.TextColor3 = Color3.fromRGB(150, 150, 150)
	tabBtnMods.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	tabBtnMods.TextColor3 = Color3.fromRGB(150, 150, 150)
	tabBtnMM2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	tabBtnMM2.TextColor3 = Color3.fromRGB(150, 150, 150)
end

tabBtnTeleporte.MouseButton1Click:Connect(function()
	resetarAbas()
	containerTeleportes.Visible = true
	tabBtnTeleporte.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tabBtnTeleporte.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

tabBtnMods.MouseButton1Click:Connect(function()
	resetarAbas()
	containerMods.Visible = true
	tabBtnMods.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tabBtnMods.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

tabBtnMM2.MouseButton1Click:Connect(function()
	resetarAbas()
	containerMM2.Visible = true
	tabBtnMM2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tabBtnMM2.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- ==========================================
-- CONTEÚDO: ABA TELEPORTES
-- ==========================================
local btnSalvar = criarBotao("BtnSalvar", "Salvar Posição Atual", UDim2.new(0, 10, 0, 10), Color3.fromRGB(46, 204, 113), containerTeleportes)

local lblCoordenada = Instance.new("TextLabel")
lblCoordenada.Size = UDim2.new(1, -70, 0, 25)
lblCoordenada.Position = UDim2.new(0, 10, 0, 47)
lblCoordenada.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
lblCoordenada.Text = "Salvo: Nenhuma"
lblCoordenada.TextColor3 = Color3.fromRGB(200, 200, 200)
lblCoordenada.Font = Enum.Font.Code
lblCoordenada.TextSize = 11
lblCoordenada.Parent = containerTeleportes
Instance.new("UICorner", lblCoordenada).CornerRadius = UDim.new(0, 4)

local btnCopiarColar = criarBotao("BtnCopiarColar", "📝 C&P", UDim2.new(1, -55, 0, 47), Color3.fromRGB(149, 165, 166), containerTeleportes)
btnCopiarColar.Size = UDim2.new(0, 45, 0, 25)
btnCopiarColar.TextSize = 12

local btnTeleportar = criarBotao("BtnTeleportar", "Teleportar para Salva", UDim2.new(0, 10, 0, 77), Color3.fromRGB(52, 152, 219), containerTeleportes)

local linha = Instance.new("Frame")
linha.Size = UDim2.new(1, -20, 0, 1)
linha.Position = UDim2.new(0, 10, 0, 120)
linha.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
linha.BorderSizePixel = 0
linha.Parent = containerTeleportes

local txtDigitar = Instance.new("TextBox")
txtDigitar.Size = UDim2.new(1, -20, 0, 32)
txtDigitar.Position = UDim2.new(0, 10, 0, 132)
txtDigitar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
txtDigitar.PlaceholderText = "Digitar: X, Y, Z"
txtDigitar.Text = ""
txtDigitar.ClearTextOnFocus = false
txtDigitar.TextColor3 = Color3.fromRGB(255, 255, 255)
txtDigitar.Font = Enum.Font.SourceSans
txtDigitar.TextSize = 14
txtDigitar.Parent = containerTeleportes
Instance.new("UICorner", txtDigitar).CornerRadius = UDim.new(0, 5)

local btnIrDigitado = criarBotao("BtnIrDigitado", "Teleportar para Digitado", UDim2.new(0, 10, 0, 172), Color3.fromRGB(155, 89, 182), containerTeleportes)

local linhaLoop = Instance.new("Frame")
linhaLoop.Size = UDim2.new(1, -20, 0, 1)
linhaLoop.Position = UDim2.new(0, 10, 0, 215)
linhaLoop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
linhaLoop.BorderSizePixel = 0
linhaLoop.Parent = containerTeleportes

local btnLoopTp = criarBotao("BtnLoopTp", "Auto-Tp (Loop): DESATIVADO", UDim2.new(0, 10, 0, 225), Color3.fromRGB(192, 57, 43), containerTeleportes)

local txtTempoLoop = Instance.new("TextBox")
txtTempoLoop.Size = UDim2.new(0, 110, 0, 32)
txtTempoLoop.Position = UDim2.new(0, 10, 0, 262)
txtTempoLoop.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
txtTempoLoop.PlaceholderText = "Tempo (seg)"
txtTempoLoop.Text = "1"
txtTempoLoop.ClearTextOnFocus = false
txtTempoLoop.TextColor3 = Color3.fromRGB(255, 255, 255)
txtTempoLoop.Font = Enum.Font.SourceSans
txtTempoLoop.TextSize = 14
txtTempoLoop.Parent = containerTeleportes
Instance.new("UICorner", txtTempoLoop).CornerRadius = UDim.new(0, 5)

local btnModoLoop = criarBotao("BtnModoLoop", "Alvo: Salvo", UDim2.new(1, -120, 0, 262), Color3.fromRGB(52, 73, 94), containerTeleportes)
btnModoLoop.Size = UDim2.new(0, 110, 0, 32)

-- ==========================================
-- BOTÃO FLUTUANTE (WIDGET MOBILE)
-- ==========================================
local menuFlutuanteContainer = Instance.new("Frame")
menuFlutuanteContainer.Size = UDim2.new(0, 45, 0, 135)
menuFlutuanteContainer.Position = UDim2.new(1, -60, 1, -180) 
menuFlutuanteContainer.BackgroundTransparency = 1
menuFlutuanteContainer.Parent = screenGui

local subBtnSalvar = Instance.new("TextButton")
subBtnSalvar.Size = UDim2.new(0, 40, 0, 40)
subBtnSalvar.Position = UDim2.new(0, 2, 0, 0)
subBtnSalvar.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
subBtnSalvar.Text = "SV"
subBtnSalvar.TextColor3 = Color3.fromRGB(255, 255, 255)
subBtnSalvar.Font = Enum.Font.SourceSansBold
subBtnSalvar.TextSize = 14
subBtnSalvar.Visible = false
subBtnSalvar.Parent = menuFlutuanteContainer
Instance.new("UICorner", subBtnSalvar).CornerRadius = UDim.new(1, 0)

local subBtnTp = Instance.new("TextButton")
subBtnTp.Size = UDim2.new(0, 40, 0, 40)
subBtnTp.Position = UDim2.new(0, 2, 0, 45)
subBtnTp.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
subBtnTp.Text = "TP"
subBtnTp.TextColor3 = Color3.fromRGB(255, 255, 255)
subBtnTp.Font = Enum.Font.SourceSansBold
subBtnTp.TextSize = 14
subBtnTp.Visible = false
subBtnTp.Parent = menuFlutuanteContainer
Instance.new("UICorner", subBtnTp).CornerRadius = UDim.new(1, 0) 

local btnFlutuantePrincipal = Instance.new("TextButton")
btnFlutuantePrincipal.Size = UDim2.new(0, 45, 0, 45)
btnFlutuantePrincipal.Position = UDim2.new(0, 0, 0, 90)
btnFlutuantePrincipal.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
btnFlutuantePrincipal.Text = "⚙️"
btnFlutuantePrincipal.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFlutuantePrincipal.Font = Enum.Font.SourceSansBold
btnFlutuantePrincipal.TextSize = 18
btnFlutuantePrincipal.Parent = menuFlutuanteContainer
Instance.new("UICorner", btnFlutuantePrincipal).CornerRadius = UDim.new(1, 0)

btnFlutuantePrincipal.Active = true
btnFlutuantePrincipal.Draggable = true

btnFlutuantePrincipal:GetPropertyChangedSignal("Position"):Connect(function()
	local p = btnFlutuantePrincipal.Position
	subBtnSalvar.Position = UDim2.new(p.X.Scale, p.X.Offset + 2, p.Y.Scale, p.Y.Offset - 90)
	subBtnTp.Position = UDim2.new(p.X.Scale, p.X.Offset + 2, p.Y.Scale, p.Y.Offset - 45)
end)

local flutuanteAberto = false
local function toggleMenuFlutuante()
	flutuanteAberto = not flutuanteAberto
	subBtnSalvar.Visible = flutuanteAberto
	subBtnTp.Visible = flutuanteAberto
	if flutuanteAberto then
		btnFlutuantePrincipal.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
		btnFlutuantePrincipal.Text = "X"
	else
		btnFlutuantePrincipal.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		btnFlutuantePrincipal.Text = "⚙️"
	end
end
btnFlutuantePrincipal.MouseButton1Click:Connect(toggleMenuFlutuante)


-- ==========================================
-- CONTEÚDO: ABA MODIFICAÇÕES
-- ==========================================
local btnPuloInfinito = criarBotao("BtnPuloInfinito", "Pulo Infinito: DESATIVADO", UDim2.new(0, 10, 0, 10), Color3.fromRGB(192, 57, 43), containerMods)

local linhaMod = Instance.new("Frame")
linhaMod.Size = UDim2.new(1, -20, 0, 1)
linhaMod.Position = UDim2.new(0, 10, 0, 55)
linhaMod.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
linhaMod.BorderSizePixel = 0
linhaMod.Parent = containerMods

local btnToggleSpeed = criarBotao("BtnToggleSpeed", "Modificador de Speed: DESATIVADO", UDim2.new(0, 10, 0, 65), Color3.fromRGB(192, 57, 43), containerMods)

local lblVelTitulo = Instance.new("TextLabel")
lblVelTitulo.Size = UDim2.new(1, -20, 0, 20)
lblVelTitulo.Position = UDim2.new(0, 10, 0, 105)
lblVelTitulo.BackgroundTransparency = 1
lblVelTitulo.Text = "Velocidade Selecionada: 16"
lblVelTitulo.TextColor3 = Color3.fromRGB(230, 230, 230)
lblVelTitulo.Font = Enum.Font.SourceSansBold
lblVelTitulo.TextSize = 14
lblVelTitulo.TextXAlignment = Enum.TextXAlignment.Left
lblVelTitulo.Parent = containerMods

local sliderFundo = Instance.new("TextButton")
sliderFundo.Size = UDim2.new(1, -20, 0, 10)
sliderFundo.Position = UDim2.new(0, 10, 0, 130)
sliderFundo.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sliderFundo.Text = ""
sliderFundo.AutoButtonColor = false
sliderFundo.Parent = containerMods
Instance.new("UICorner", sliderFundo).CornerRadius = UDim.new(0, 5)

local sliderPreenchido = Instance.new("Frame")
sliderPreenchido.Size = UDim2.new(0, 0, 1, 0)
sliderPreenchido.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
sliderPreenchido.BorderSizePixel = 0
sliderPreenchido.Parent = sliderFundo
Instance.new("UICorner", sliderPreenchido).CornerRadius = UDim.new(0, 5)

local sliderBotao = Instance.new("Frame")
sliderBotao.Size = UDim2.new(0, 16, 0, 16)
sliderBotao.Position = UDim2.new(0, -8, 0.5, -8)
sliderBotao.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderBotao.Parent = sliderFundo
Instance.new("UICorner", sliderBotao).CornerRadius = UDim.new(1, 0)

local txtVelDigitar = Instance.new("TextBox")
txtVelDigitar.Size = UDim2.new(0, 110, 0, 32)
txtVelDigitar.Position = UDim2.new(0, 10, 0, 155)
txtVelDigitar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
txtVelDigitar.PlaceholderText = "Digitar Valor"
txtVelDigitar.Text = ""
txtVelDigitar.ClearTextOnFocus = false
txtVelDigitar.TextColor3 = Color3.fromRGB(255, 255, 255)
txtVelDigitar.Font = Enum.Font.SourceSans
txtVelDigitar.TextSize = 14
txtVelDigitar.Parent = containerMods
Instance.new("UICorner", txtVelDigitar).CornerRadius = UDim.new(0, 5)

local btnVelReset = criarBotao("BtnVelReset", "Reset (16)", UDim2.new(1, -120, 0, 155), Color3.fromRGB(127, 140, 141), containerMods)
btnVelReset.Size = UDim2.new(0, 110, 0, 32)


-- ==========================================
-- CONTEÚDO: ABA MM2
-- O UIListLayout organiza a posição automaticamente
-- ==========================================
local espacadorTop = Instance.new("Frame")
espacadorTop.Size = UDim2.new(1, 0, 0, 2)
espacadorTop.BackgroundTransparency = 1
espacadorTop.Parent = containerMM2

-- 1. O botão original do pulo (No topo!)
local btnToggleMMV = criarBotao("BtnToggleMMV", "Boost Pulo (Speed 100): OFF", nil, Color3.fromRGB(192, 57, 43), containerMM2)

-- 2. Auto Lançar Facas 
local btnAutoFaca = criarBotao("BtnAutoFaca", "Auto Lançar Faca: OFF", nil, Color3.fromRGB(192, 57, 43), containerMM2)

-- 3. ESP Unificado
local btnEspUnificado = criarBotao("BtnEspUnificado", "ESP Geral (Jogadores + Armas): OFF", nil, Color3.fromRGB(52, 73, 94), containerMM2)

-- 4. Restante dos hacks do MM2 (removidos atirar no murderer, tp arma e matar todos)
local btnTpMapa = criarBotao("BtnTpMapa", "Teleportar p/ Mapa", nil, Color3.fromRGB(155, 89, 182), containerMM2)
local btnTpLobby = criarBotao("BtnTpLobby", "Teleportar p/ Lobby", nil, Color3.fromRGB(155, 89, 182), containerMM2)

-- Ajusta automaticamente o tamanho de rolagem da aba MM2
layoutMM2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	containerMM2.CanvasSize = UDim2.new(0, 0, 0, layoutMM2.AbsoluteContentSize.Y + 20)
end)


-- ==========================================
-- SISTEMA DE REDIMENSIONAMENTO NO CANTO
-- ==========================================
local btnResizer = Instance.new("TextButton")
btnResizer.Size = UDim2.new(0, 20, 0, 20)
btnResizer.Position = UDim2.new(1, -20, 1, -20)
btnResizer.BackgroundTransparency = 1
btnResizer.Text = "◢"
btnResizer.TextColor3 = Color3.fromRGB(150, 150, 150)
btnResizer.Font = Enum.Font.SourceSans
btnResizer.TextSize = 16
btnResizer.ZIndex = 10 
btnResizer.Parent = framePrincipal

local arrastandoResizer = false
local resizerStartPos = nil
local resizerStartSize = nil

btnResizer.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		arrastandoResizer = true
		resizerStartPos = input.Position
		resizerStartSize = framePrincipal.AbsoluteSize
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if arrastandoResizer and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local deltaX = input.Position.X - resizerStartPos.X
		local deltaY = input.Position.Y - resizerStartPos.Y
		
		local novoX = math.clamp(resizerStartSize.X + deltaX, TAMANHO_MIN_X, TAMANHO_MAX_X)
		local novoY = math.clamp(resizerStartSize.Y + deltaY, TAMANHO_MIN_Y, TAMANHO_MAX_Y)
		
		if not minimizado then
			framePrincipal.Size = UDim2.new(0, novoX, 0, novoY)
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		arrastandoResizer = false
	end
end)


-- ==========================================
-- LÓGICAS FUNCIONAIS DOS BOTÕES E HACKS
-- ==========================================

-- Lógica Pulo Boost 
btnToggleMMV.MouseButton1Click:Connect(function()
	mmvAtivo = not mmvAtivo
	if mmvAtivo then
		btnToggleMMV.Text = "Boost Pulo (Speed 100): ATIVADO"
		btnToggleMMV.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
	else
		btnToggleMMV.Text = "Boost Pulo (Speed 100): DESATIVADO"
		btnToggleMMV.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
		local char = localPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = walkSpeedAtivo and velocidadeAlvo or 16 end
	end
end)

-- ==========================================
-- LÓGICA DO MURDER MYSTERY 2
-- ==========================================
local espGeralAtivo = false
local loopEsp = nil
local loopArma = nil

local function getMurderer()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then
			return p
		end
	end
	return nil
end

local function getSheriff()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun")) then
			return p
		end
	end
	return nil
end

local function limparESP()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("MM2_ESP_HL") then p.Character.MM2_ESP_HL:Destroy() end
	end
end

local function findNearestPlayer()
	local nearestPlayer = nil
	local shortestDistance = math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= localPlayer and p.Character then
			local localRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
			local otherRootPart = p.Character:FindFirstChild("HumanoidRootPart")
			if localRootPart and otherRootPart then
				local distance = (localRootPart.Position - otherRootPart.Position).Magnitude
				if distance < shortestDistance then
					shortestDistance = distance
					nearestPlayer = p
				end
			end
		end
	end
	return nearestPlayer
end

-- 0. Auto Atirar Faca
btnAutoFaca.MouseButton1Click:Connect(function()
	autoFacaAtivo = not autoFacaAtivo
	if autoFacaAtivo then
		btnAutoFaca.Text = "Auto Lançar Faca: ON"
		btnAutoFaca.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
	else
		btnAutoFaca.Text = "Auto Lançar Faca: OFF"
		btnAutoFaca.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
	end
end)

local function knifeThrow()
	if getMurderer() ~= localPlayer then return end
	
	local char = localPlayer.Character
	if not char then return end

	if not char:FindFirstChild("Knife") then
		local hum = char:FindFirstChild("Humanoid")
		if localPlayer.Backpack:FindFirstChild("Knife") then
			hum:EquipTool(localPlayer.Backpack.Knife)
		else
			return
		end
	end

	local NearestPlayer = findNearestPlayer()
	if not NearestPlayer or not NearestPlayer.Character then return end
	local nearestHRP = NearestPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not nearestHRP then return end

	local rightHand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") or char.PrimaryPart
	if not rightHand then return end

	-- Predição baseada na velocidade do player pra não errar feio
	local vel = nearestHRP.AssemblyLinearVelocity
	local predictedPos = nearestHRP.Position + (vel * 0.25)
	
	local argsThrow = {
		[1] = CFrame.new(rightHand.Position),
		[2] = CFrame.new(predictedPos)
	}

	pcall(function()
		char.Knife.Events.KnifeThrown:FireServer(unpack(argsThrow))
	end)
end

task.spawn(function()
	while task.wait(1.5) do
		if autoFacaAtivo then
			knifeThrow()
		end
	end
end)

-- 1. ESP Unificado (Jogadores + Arma Caída)
btnEspUnificado.MouseButton1Click:Connect(function()
	espGeralAtivo = not espGeralAtivo
	if espGeralAtivo then
		btnEspUnificado.Text = "ESP Geral (Jogadores + Armas): ON"
		btnEspUnificado.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
		
		-- Lógica ESP Jogadores
		loopEsp = RunService.Heartbeat:Connect(function()
			local murd = getMurderer()
			local sher = getSheriff()
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= localPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					local hl = p.Character:FindFirstChild("MM2_ESP_HL")
					if not hl then
						hl = Instance.new("Highlight")
						hl.Name = "MM2_ESP_HL"
						hl.FillTransparency = 0.5
						hl.OutlineTransparency = 0
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						hl.Parent = p.Character
					end
					if p == murd then
						hl.FillColor = Color3.fromRGB(255, 0, 0) hl.OutlineColor = Color3.fromRGB(255, 0, 0)
					elseif p == sher then
						hl.FillColor = Color3.fromRGB(0, 150, 255) hl.OutlineColor = Color3.fromRGB(0, 150, 255)
					else
						hl.FillColor = Color3.fromRGB(0, 255, 0) hl.OutlineColor = Color3.fromRGB(0, 255, 0)
					end
				end
			end
		end)

		-- Lógica ESP Arma Caída
		loopArma = RunService.Heartbeat:Connect(function()
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj.Name == "GunDrop" and obj:IsA("BasePart") then
					local hl = obj:FindFirstChild("MM2_ARMA_HL")
					if not hl then
						hl = Instance.new("Highlight") hl.Name = "MM2_ARMA_HL" hl.FillColor = Color3.fromRGB(255, 255, 0)
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop hl.Parent = obj
					end
				end
			end
		end)
	else
		btnEspUnificado.Text = "ESP Geral (Jogadores + Armas): OFF"
		btnEspUnificado.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
		
		-- Desativando ESP Jogadores
		if loopEsp then loopEsp:Disconnect() end
		limparESP()
		
		-- Desativando ESP Armas
		if loopArma then loopArma:Disconnect() end
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj.Name == "GunDrop" and obj:FindFirstChild("MM2_ARMA_HL") then 
				obj.MM2_ARMA_HL:Destroy() 
			end
		end
	end
end)

-- 4. TPs MM2
local function obterMapa()
	for _, obj in ipairs(workspace:GetChildren()) do
		if obj:FindFirstChild("CoinContainer") and obj:FindFirstChild("Spawns") then return obj end
	end return nil
end

btnTpMapa.MouseButton1Click:Connect(function()
	local mapa = obterMapa()
	if mapa and mapa:FindFirstChild("Spawns") then
		local spawns = mapa.Spawns:GetChildren()
		if #spawns > 0 then localPlayer.Character:MoveTo(spawns[math.random(1, #spawns)].Position) end
	end
end)

btnTpLobby.MouseButton1Click:Connect(function()
	if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
		localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-107, 152, 41)
	end
end)


-- ==========================================
-- LÓGICA CORE: TELEPORTES, COPIAR, SPEED E LOOPS
-- ==========================================
RunService.Heartbeat:Connect(function()
	if not mmvAtivo then return end
	local char = localPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		local isActuallyJumping = hum.Jump or hum:GetState() == Enum.HumanoidStateType.Freefall or hum:GetState() == Enum.HumanoidStateType.Jumping
		if isActuallyJumping then
			if not isBoostingMMV then isBoostingMMV = true hum.WalkSpeed = 100 end
		else
			if isBoostingMMV then isBoostingMMV = false hum.WalkSpeed = walkSpeedAtivo and velocidadeAlvo or 16 end
		end
	end
end)

local function extrairCFrameDigitado()
	local texto = txtDigitar.Text
	local x, y, z = string.match(texto, "([%-?%d%.]+)[%s%,%;]+([%-?%d%.]+)[%s%,%;]+([%-?%d%.]+)")
	if x and y and z then
		local numX, numY, numZ = tonumber(x), tonumber(y), tonumber(z)
		if numX and numY and numZ then return CFrame.new(numX, numY, numZ) end
	end
	return nil
end

local function formatarPos(cframe) return string.format("%.1f, %.1f, %.1f", cframe.Position.X, cframe.Position.Y, cframe.Position.Z) end
local function acaoSalvarPosicao()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then posicaoSalva = hrp.CFrame lblCoordenada.Text = "Salvo: " .. formatarPos(posicaoSalva) end
end
local function acaoTeleportarParaSalva()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if posicaoSalva and hrp then hrp.CFrame = posicaoSalva end
end

btnSalvar.MouseButton1Click:Connect(acaoSalvarPosicao)
subBtnSalvar.MouseButton1Click:Connect(acaoSalvarPosicao)
btnTeleportar.MouseButton1Click:Connect(acaoTeleportarParaSalva)
subBtnTp.MouseButton1Click:Connect(acaoTeleportarParaSalva)

btnCopiarColar.MouseButton1Click:Connect(function()
	if posicaoSalva then txtDigitar.Text = formatarPos(posicaoSalva) btnCopiarColar.Text = "✓" task.wait(0.5) btnCopiarColar.Text = "📝 C&P"
	else btnCopiarColar.Text = "X" task.wait(0.5) btnCopiarColar.Text = "📝 C&P" end
end)

btnIrDigitado.MouseButton1Click:Connect(function()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local cfDigitado = extrairCFrameDigitado()
	if cfDigitado then hrp.CFrame = cfDigitado
	else btnIrDigitado.Text = "Formato Inválido!" task.wait(1.2) btnIrDigitado.Text = "Teleportar para Digitado" end
end)

txtTempoLoop.FocusLost:Connect(function()
	local num = tonumber(txtTempoLoop.Text)
	if num and num > 0 then intervaloLoopTp = num else txtTempoLoop.Text = tostring(intervaloLoopTp) end
end)
btnModoLoop.MouseButton1Click:Connect(function()
	if modoLoopTp == "Salvo" then modoLoopTp = "Digitado" btnModoLoop.BackgroundColor3 = Color3.fromRGB(142, 68, 173)
	else modoLoopTp = "Salvo" btnModoLoop.BackgroundColor3 = Color3.fromRGB(52, 73, 94) end
	btnModoLoop.Text = "Alvo: " .. modoLoopTp
end)
btnLoopTp.MouseButton1Click:Connect(function()
	loopTpAtivo = not loopTpAtivo
	if loopTpAtivo then btnLoopTp.Text = "Auto-Tp (Loop): ATIVADO" btnLoopTp.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
	else btnLoopTp.Text = "Auto-Tp (Loop): DESATIVADO" btnLoopTp.BackgroundColor3 = Color3.fromRGB(192, 57, 43) end
end)

task.spawn(function()
	while true do
		task.wait(intervaloLoopTp)
		if loopTpAtivo then
			local char = localPlayer.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				if modoLoopTp == "Salvo" and posicaoSalva then hrp.CFrame = posicaoSalva
				elseif modoLoopTp == "Digitado" then
					local cfDigitado = extrairCFrameDigitado()
					if cfDigitado then hrp.CFrame = cfDigitado end
				end
			end
		end
	end
end)

local function atualizarVariavelSpeed(valor)
	velocidadeAlvo = math.clamp(valor, 0, 1000)
	lblVelTitulo.Text = "Velocidade Selecionada: " .. math.floor(velocidadeAlvo)
	if walkSpeedAtivo and not isBoostingMMV then
		local char = localPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = velocidadeAlvo end
	end
end

btnToggleSpeed.MouseButton1Click:Connect(function()
	walkSpeedAtivo = not walkSpeedAtivo
	local char = localPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if walkSpeedAtivo then
		btnToggleSpeed.Text = "Modificador de Speed: ATIVADO" btnToggleSpeed.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
		if hum and not isBoostingMMV then hum.WalkSpeed = velocidadeAlvo end
	else
		btnToggleSpeed.Text = "Modificador de Speed: DESATIVADO" btnToggleSpeed.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
		if hum and not isBoostingMMV then hum.WalkSpeed = 16 end 
	end
end)

RunService.RenderStepped:Connect(function()
	if walkSpeedAtivo and not isBoostingMMV then
		local char = localPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum and hum.WalkSpeed ~= velocidadeAlvo then hum.WalkSpeed = velocidadeAlvo end
	end
end)

local arrastandoSlider = false
local function atualizarSliderPorInput(input)
	local tamanhoMax = sliderFundo.AbsoluteSize.X
	local posX = math.clamp(input.Position.X - sliderFundo.AbsolutePosition.X, 0, tamanhoMax)
	local percentual = posX / tamanhoMax
	sliderBotao.Position = UDim2.new(percentual, -8, 0.5, -8)
	sliderPreenchido.Size = UDim2.new(percentual, 0, 1, 0)
	local novoValor = VALOR_MIN + (percentual * (VALOR_MAX - VALOR_MIN))
	atualizarVariavelSpeed(novoValor)
end

sliderFundo.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then arrastandoSlider = true atualizarSliderPorInput(input) end
end)
UserInputService.InputChanged:Connect(function(input)
	if arrastandoSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then atualizarSliderPorInput(input) end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then arrastandoSlider = false end
end)
txtVelDigitar.FocusLost:Connect(function()
	local num = tonumber(txtVelDigitar.Text)
	if num then
		atualizarVariavelSpeed(num)
		local percentual = math.clamp((num - VALOR_MIN) / (VALOR_MAX - VALOR_MIN), 0, 1)
		sliderBotao.Position = UDim2.new(percentual, -8, 0.5, -8)
		sliderPreenchido.Size = UDim2.new(percentual, 0, 1, 0)
	else txtVelDigitar.Text = "" end
end)
btnVelReset.MouseButton1Click:Connect(function()
	atualizarVariavelSpeed(16)
	sliderBotao.Position = UDim2.new(0, -8, 0.5, -8)
	sliderPreenchido.Size = UDim2.new(0, 0, 1, 0)
	txtVelDigitar.Text = ""
end)

btnPuloInfinito.MouseButton1Click:Connect(function()
	puloInfinitoAtivo = not puloInfinitoAtivo
	if puloInfinitoAtivo then btnPuloInfinito.Text = "Pulo Infinito: ATIVADO" btnPuloInfinito.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
	else btnPuloInfinito.Text = "Pulo Infinito: DESATIVADO" btnPuloInfinito.BackgroundColor3 = Color3.fromRGB(192, 57, 43) end
end)

UserInputService.JumpRequest:Connect(function()
	if puloInfinitoAtivo then
		local char = localPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

local tamanhoSalvo = UDim2.new(0, TAMANHO_PADRAO_X, 0, TAMANHO_PADRAO_Y)
btnMinimizar.MouseButton1Click:Connect(function()
	minimizado = not minimizado
	local tamanhoAlvo
	if minimizado then
		tamanhoSalvo = framePrincipal.Size 
		containerTeleportes.Visible = false 
		containerMods.Visible = false 
		containerMM2.Visible = false
		barAbas.Visible = false
		btnResizer.Visible = false 
		tamanhoAlvo = UDim2.new(0, tamanhoSalvo.X.Offset, 0, 35) 
		btnMinimizar.Text = "+"
	else
		if tabBtnTeleporte.BackgroundColor3 == Color3.fromRGB(45, 45, 45) then containerTeleportes.Visible = true
		elseif tabBtnMods.BackgroundColor3 == Color3.fromRGB(45, 45, 45) then containerMods.Visible = true
		else containerMM2.Visible = true end
		
		barAbas.Visible = true 
		btnResizer.Visible = true 
		tamanhoAlvo = tamanhoSalvo 
		btnMinimizar.Text = "-"
	end
	TweenService:Create(framePrincipal, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = tamanhoAlvo}):Play()
end)

btnFechar.MouseButton1Click:Connect(function()
	puloInfinitoAtivo = false loopTpAtivo = false walkSpeedAtivo = false mmvAtivo = false espGeralAtivo = false autoFacaAtivo = false
	if loopEsp then loopEsp:Disconnect() end
	if loopArma then loopArma:Disconnect() end
	limparESP()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj.Name == "GunDrop" and obj:FindFirstChild("MM2_ARMA_HL") then obj.MM2_ARMA_HL:Destroy() end
	end
	local char = localPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = 16 end
	screenGui:Destroy()
end)