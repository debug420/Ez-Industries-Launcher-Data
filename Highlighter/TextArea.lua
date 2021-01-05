--[[
	
	@Author As8D
	
	@Description
		A custom textbox, with the ability to control the caret.
		If a formatted text list object is passed the text of the
		textbox is forced to be invisible.
	
	@Modified 09/06/2017
	
	Constructor:
	TextArea.new(TextBox textbox[, string highlightLanguage = nil])
	
	Methods:
	void	TextArea:CaptureFocus()
	void	TextArea:ReleaseFocus([boolean enterPressed = false])
	
	Properties:
	string	TextArea.Placeholder
	Color3	TextArea.PlaceholderColor3
	float	TextArea.PlaceholderTransparency
	Color3	TextArea.CaretColor3
	int		TextArea.CaretPosition
	float	TextArea.CaretBlinkSpeed
	boolean	TextArea.IsFocused [readonly]
	
	Events:
	TextArea.Focused ()
	TextArea.FocusLost (boolean enterPressed, InputObject input)
	TextArea.CaretChanged (int position)
	TextArea.Changed (string propertyName)
	
--]]

local Markup = require(game:GetService("ReplicatedStorage"):WaitForChild("Markup"))

local module = {}
local api = {set = {}, get = {}}
local defaultValues = {}

local fadeIn = TweenInfo.new(0.5)

local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

local function isShiftDown()
	return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
end

function module.new(textbox, highlightLanguage) -- to do: replace with language. Add Text property override to set the text of the TextArea.
	textbox.TextTransparency = 1
	textbox.Text = "-"
	
	local events = {
		Focused = Instance.new("BindableEvent"),
		FocusLost = Instance.new("BindableEvent"),
		CaretChanged = Instance.new("BindableEvent"),
		Changed = Instance.new("BindableEvent")
	}
	
	local caret = Instance.new("Frame")
	caret.BackgroundColor3 = textbox.TextColor3
	caret.ZIndex = textbox.ZIndex
	caret.Name = "Caret"
	caret.BorderSizePixel = 0
	caret.Size = UDim2.new(0, 1, 0, textbox.TextSize)
	caret.Visible = false
	caret.Parent = textbox
	
	local fadeIn = game:GetService("TweenService"):Create(caret, TweenInfo.new(), {BackgroundTransparency = 0})
	local selTemplate = Instance.new("Frame")
	selTemplate.BorderSizePixel = 0
	selTemplate.BackgroundTransparency = 0.75
	selTemplate.BackgroundColor3 = defaultValues.__selectionColor3
	selTemplate.Name = "SelectionFrame"
	
	local obj = {
		__highlightLanguage = highlightLanguage,
		__element = textbox,
		__placeholderColor3 = textbox.TextColor3,
		__caretColor3 = textbox.TextColor3,
		__caret = caret,
		__caretMove = Vector2.new(),
		__caretDesiredX = 0,
		__caretLastMove = 0,
		__selectionTemplate = selTemplate,
		__selectionFrames = {},
		__events = events
	}
	for key, val in next, defaultValues do
		obj[key] = obj[key] or val
	end
	for key, val in next, events do
		obj[key] = val.Event
	end
	
	function obj.__internalSelectionUpdate()
		if isShiftDown() or obj.__selectionStart == -1 or (obj.__selectionStart == obj.__selectionEnd) then
			if rawget(obj, "__textlist") then
				if obj.__caretMove.X ~= 0 then
					obj.CaretPosition = math.clamp(obj.__caretPosition + obj.__caretMove.X, 0, #obj.__text + 1)
				end
				if obj.__caretMove.Y ~= 0 then
					local oldX = obj.__caretDesiredX
					obj.CaretPosition = obj.__textlist:GetIndexByPosition(textbox.AbsolutePosition.X + oldX - 1, obj.__caret.AbsolutePosition.Y +
						textbox.TextSize * obj.__caretMove.Y) + (obj.__textPaddingTopLeft.Y > 0 and obj.__caretMove.Y > 0 and 1 or 0)
					obj.__caretDesiredX = oldX
				end
			else
				
			end
		end
		if rawget(obj, "__textlist") then
			for i = math.min(obj.__selectionStart, obj.__selectionEnd) + 1, math.max(obj.__selectionStart, obj.__selectionEnd) do
				if not obj.__selectionFrames[i] then
					local pos, size = obj.__textlist:GetBounds(i)
					local n = selTemplate:clone()
					n.Position = UDim2.new(0, pos.X, 0, pos.Y + 1)
					n.Size = UDim2.new(0, size.X, 0, size.Y)
					n.Parent = obj.__textlist.parent
					obj.__selectionFrames[i] = n
				end
			end
			for key, frame in next, obj.__selectionFrames do
				if key < math.min(obj.__selectionStart, obj.__selectionEnd) + 1 or key > math.max(obj.__selectionStart, obj.__selectionEnd) then
					frame:Destroy()
					obj.__selectionFrames[key] = nil
				end
			end
		end
		textbox:CaptureFocus()
	end
	
	local function performCaretMove()
		if isShiftDown() then
			if obj.__selectionStart == -1 then
				obj.__selectionStart = obj.__caretPosition
				events.Changed:Fire("SelectionStart")
			end
		end
		obj.__internalSelectionUpdate()
		if isShiftDown() then
			obj.__selectionEnd = obj.__caretPosition
			events.Changed:Fire("SelectionEnd")
			if rawget(obj, "__textlist") then
				for i = math.min(obj.__selectionStart, obj.__selectionEnd) + 1, math.max(obj.__selectionStart, obj.__selectionEnd) do
					if not obj.__selectionFrames[i] then
						local pos, size = obj.__textlist:GetBounds(i)
						local n = selTemplate:clone()
						n.Position = UDim2.new(0, pos.X, 0, pos.Y + 1)
						n.Size = UDim2.new(0, size.X, 0, size.Y)
						n.Parent = obj.__textlist.parent
						obj.__selectionFrames[i] = n
					end
				end
				for key, frame in next, obj.__selectionFrames do
					if key < math.min(obj.__selectionStart, obj.__selectionEnd) + 1 or key > math.max(obj.__selectionStart, obj.__selectionEnd) then
						frame:Destroy()
						obj.__selectionFrames[key] = nil
					end
				end
			end
		elseif obj.__selectionStart ~= -1 then
			obj.__selectionStart = -1
			obj.__selectionEnd = -1
			events.Changed:Fire("SelectionStart")
			events.Changed:Fire("SelectionEnd")
			for key, frame in next, obj.__selectionFrames do
				if key < math.min(obj.__selectionStart, obj.__selectionEnd) + 1 or key > math.max(obj.__selectionStart, obj.__selectionEnd) then
					frame:Destroy()
					obj.__selectionFrames[key] = nil
				end
			end
		end
	end
	
	local function appendSymbol(symbol)
		local oldCaretPos = obj.__caretPosition
		if obj.__selectionStart > 0 and obj.__selectionEnd > 0 and obj.__selectionStart ~= obj.__selectionEnd then
			local min = math.min(obj.__selectionStart, obj.__selectionEnd)
			obj.Text = obj.__text:sub(1, math.max(0, min)) .. obj.__text:sub(math.max(obj.__selectionStart, obj.__selectionEnd) + 1)
			obj.CaretPosition = math.max(0, min)
			obj.__selectionStart = 0
			obj.__selectionEnd = 0
			obj.__internalSelectionUpdate()
		end
		if not symbol then
			if oldCaretPos > 1 then
				obj.Text = obj.__text:sub(1, math.max(0, oldCaretPos - 1)) .. obj.__text:sub(oldCaretPos + 1)
				obj.CaretPosition = math.max(0, oldCaretPos - 1)
				print("New Text:", obj.Text)
			end
		elseif symbol ~= string.char(13) then
			obj.Text = obj.__text:sub(1, oldCaretPos) .. symbol .. obj.__text:sub(oldCaretPos + 1)
			obj.CaretPosition = math.clamp(oldCaretPos + 1, 1, #obj.__text)
			print("New Text:", obj.Text, "appended char code is:", symbol:byte(), "'" .. symbol .. "'")
		end
	end
	
	function obj.__internalCaptureFocus()
		textbox:CaptureFocus()
		obj.__isFocused = true
		events.Focused:Fire()
		events.Changed:Fire("IsFocused")
		if rawget(obj, "__textlist") then
			obj.CaretPosition = obj.__textlist:GetIndexByPosition(mouse.X, mouse.Y) or 0
		end
		caret.Visible = true
		obj.__selectionStart = -1
		obj.__selectionEnd = -1
		for key, frame in next, obj.__selectionFrames do
			if key < math.min(obj.__selectionStart, obj.__selectionEnd) or key > math.max(obj.__selectionStart, obj.__selectionEnd) then
				frame:Destroy()
				obj.__selectionFrames[key] = nil
			end
		end
		if not rawget(obj, "__blinkconn") then
			if obj.__animated then
				caret.BackgroundTransparency = 1
				fadeIn:Play()
			end
			local start = tick()
			local lastMoveUpdate = 0
			rawset(obj, "__blinkconn", game:GetService("RunService").Heartbeat:connect(function()
				caret.Visible = (tick() - start) % obj.__caretBlinkSpeed < obj.__caretBlinkSpeed * 0.7
				if tick() - obj.__caretLastMove > 0.08 and obj.__caretMove.magnitude > 0 then
					obj.__caretLastMove = tick()
					performCaretMove()
				end
			end))
		end
	end
	
	textbox.FocusLost:connect(function(pressed, inputObject)
		obj.__isFocused = false
		if rawget(obj, "__blinkconn") then
			obj.__blinkconn:disconnect()
			rawset(obj, "__blinkconn", nil)
		end
		caret.Visible = false
		events.FocusLost:Fire(pressed, inputObject)
		events.Changed:Fire("IsFocused")
	end)
	
	textbox:GetPropertyChangedSignal("Text"):connect(function()
		if #textbox.Text > 1 then -- append
			local symbol = textbox.Text:match("%-$") and textbox.Text:sub(1, #textbox.Text - 1) or textbox.Text:sub(2)
			textbox.Text = "-"
			print("APPENDING", symbol)
			appendSymbol(symbol)
		elseif #textbox.Text < 1 then -- delete
			print("DELETING")
			appendSymbol()
			textbox.Text = "-"
			textbox:CaptureFocus()
		end
	end)
	
	local function calculateKeysDown()
		local keys = game:GetService("UserInputService"):GetKeysPressed()
		local move = Vector2.new()
		for i = 1, #keys do
			if keys[i].KeyCode == Enum.KeyCode.Left then
				move = move + Vector2.new(-1, 0)
			elseif keys[i].KeyCode == Enum.KeyCode.Right then
				move = move + Vector2.new(1, 0)
			elseif keys[i].KeyCode == Enum.KeyCode.Up then
				move = move + Vector2.new(0, -1)
			elseif keys[i].KeyCode == Enum.KeyCode.Down then
				move = move + Vector2.new(0, 1)
			end
		end
		obj.__caretMove = move
	end
	
	local selectionDragged = false
	UserInputService.InputBegan:connect(function(input)
		if UserInputService:GetFocusedTextBox() == textbox then
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				obj:CaptureFocus()
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.Up or input.KeyCode == Enum.KeyCode.Down then
					calculateKeysDown()
					obj.__caretLastMove = tick() + 0.4
					performCaretMove()
				end
			elseif (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				selectionDragged = true
				if rawget(obj, "__textlist") then
					obj.CaretPosition = obj.__textlist:GetIndexByPosition(input.Position.X - obj.__textPaddingTopLeft.X, input.Position.Y - obj.__textPaddingTopLeft.Y) or 0
					obj.SelectionStart = obj.CaretPosition
					obj.SelectionEnd = obj.CaretPosition
				end
			end
		end
	end)
	
	UserInputService.InputEnded:connect(function(input)
		if UserInputService:GetFocusedTextBox() == textbox then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.Up or input.KeyCode == Enum.KeyCode.Down then
					calculateKeysDown()
				end
			elseif (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				selectionDragged = false
			end
		end
	end)
	
	UserInputService.InputChanged:connect(function(input)
		if UserInputService:GetFocusedTextBox() == textbox then
			if selectionDragged and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local newPos = obj.__textlist:GetIndexByPosition(input.Position.X - obj.__textPaddingTopLeft.X, input.Position.Y - obj.__textPaddingTopLeft.Y)
				if obj.CaretPosition ~= newPos then
					obj.CaretPosition = newPos
					obj.SelectionEnd = obj.CaretPosition
				end
			end
		end
	end)
	
	return setmetatable(obj, api)
end

--Core
function api.__index(tabl, key)
	if api[key] then
		return api[key]
	elseif api.get[key] then
		return api.get[key](tabl)
	elseif pcall(function() return tabl.__element[key] end) then
		return tabl.__element[key]
	else
		error("Invalid or ungettable property " .. tostring(key))
	end
end

function api.__newindex(tabl, key, val)
	if api.set[key] then
		api.set[key](tabl, val)
	elseif pcall(function() assert(type(tabl.__element[key]) ~= "function") end) then
		tabl.__element[key] = val
		tabl.__events.Changed:Fire(key)
	else
		error("Invalid or unsettable property " .. tostring(key))
	end
end

local function createProperty(name, expectType, defaultValue, gettable, settable)
	local internalName = "__" .. name:sub(1, 1):lower() .. name:sub(2)
	defaultValues[internalName] = defaultValue
	if gettable then
		api.get[name] = function(tabl)
			return tabl[internalName]
		end
	end
	if settable then
		api.set[name] = function(tabl, val)
			assert(typeof(val) == expectType, "Expected " .. expectType .. " for " .. name .. " (got " .. typeof(val) .. ")")
			if val ~= tabl[internalName] then
				local oldVal = tabl[internalName]
				if type(settable) == "function" then
					val = settable(tabl, val) or val
				end
				tabl[internalName] = val
				if val ~= oldVal and not rawget(tabl, "__silenceChanged") then
					tabl.__events.Changed:Fire(name)
				end
			end
		end
	end
end

--Methods
function api:CaptureFocus()
	self.__internalCaptureFocus()
end

function api:ReleaseFocus(pressed)
	self.__element:ReleaseFocus(pressed)
end

function api:GetSelectedText()
	return self.__text:sub(math.min(self.__selectionStart, self.__selectionEnd) + 1, math.max(self.__selectionStart, self.__selectionEnd))
end

--Properties
createProperty("Placeholder", "string", "Placeholder", true, true)
createProperty("PlaceholderColor3", "Color3", nil, true, true)
createProperty("PlaceholderTransparency", "number", 0.5, true, true)
createProperty("CaretColor3", "Color3", nil, true, function(tabl, val)
	tabl.__caret.BackgroundColor3 = val
end)
local function caretPositionChange(tabl, val)
	if val <= 0 then
		if tabl.__animated and tabl.__caret.Visible then
			tabl.__caret:TweenPosition(UDim2.new(0, tabl.__textPaddingTopLeft.X, 0, 1 + tabl.__textPaddingTopLeft.Y), "Out", "Quad", 0.1, true)
		else
			tabl.__caret.Position = UDim2.new(0, tabl.__textPaddingTopLeft.X, 0, 1 + tabl.__textPaddingTopLeft.Y)
		end
		tabl.__caretDesiredX = 0
		return 0
	else
		if rawget(tabl, "__textlist") then
			local _, size, pos = tabl.__textlist:GetBounds(val)
			print("CARETPOS:", val, pos.X, tabl.__textlist.root:GetText():sub(val, val), ",", tabl.__textlist.root:GetText():sub(val, val):byte())
			tabl.__caretDesiredX = pos.X
			if tabl.__animated and tabl.__caret.Visible then
				tabl.__caret:TweenPosition(UDim2.new(0, pos.X - 1, 0, pos.Y + 1), "Out", "Quad", 0.1, true)
			else
				tabl.__caret.Position = UDim2.new(0, pos.X - 1, 0, pos.Y + 1)
			end
			return math.min(#tabl.__text, val)
		end
	end
end
createProperty("CaretPosition", "number", 0, true, caretPositionChange)
createProperty("IsFocused", "boolean", false, true, false)
createProperty("CaretBlinkSpeed", "number", 0.75, true, true)
createProperty("SelectionStart", "number", -1, true, function(tabl, val)
	tabl.__selectionStart = math.clamp(val, 0, #tabl.__text)
	tabl.__internalSelectionUpdate()
	return tabl.__selectionStart
end)
createProperty("SelectionEnd", "number", -1, true, function(tabl, val)
	tabl.__selectionEnd = math.clamp(val, 0, #tabl.__text)
	tabl.__internalSelectionUpdate()
	return tabl.__selectionEnd
end)
createProperty("SelectionColor3", "Color3", Color3.new(0.2, 0.5, 0.8), true, function(tabl, val)
	tabl.__selectionTemplate.BackgroundColor3 = val
	for _, obj in next, tabl.__selectionFrames do
		obj.BackgroundColor3 = val
	end
end)
createProperty("Animated", "boolean", true, true, true)
createProperty("ReadOnly", "boolean", false, true, true)

local function refreshText(tabl)
	if rawget(tabl, "__textlist") then
		for i = 1, #tabl.__textlist.list do
			if tabl.__textlist.list[i].label then
				tabl.__textlist.list[i].label:Destroy()
			end
		end
		tabl.__textlist.root:Destroy()
		tabl.__textlist:Destroy()
		rawset(tabl, "__textlist", nil)
	end
	if rawget(tabl, "__highlightLanguage") and #tabl.__highlightLanguage > 0 then
		local elem = tabl.__element
		rawset(tabl, "__textlist", Markup.fromLanguage(tabl.__highlightLanguage, tabl.__text):Show(tabl.__element, tabl.__textPaddingTopLeft, tabl.__textPaddingBottomRight))
		tabl.CaretPosition = tabl.__caretPosition
		for _, frame in next, tabl.__selectionFrames do
			frame:Destroy()
		end
		setmetatable(tabl.__selectionFrames, {__mode = "kv"})
		tabl.__selectionFrames = {}
		tabl.__internalSelectionUpdate()
	end
end

createProperty("HighlightLanguage", "string", "", true, function(tabl, val)
	tabl.__highlightLanguage = val
	refreshText(tabl)
end)
createProperty("Text", "string", "", true, function(tabl, val)
	tabl.__text = val
	refreshText(tabl)
end)
createProperty("TextPaddingTopLeft", "Vector2", Vector2.new(), true, function(tabl, val)
	tabl.__textPaddingTopLeft = val
	refreshText(tabl)
	caretPositionChange(tabl, tabl.__caretPosition)
end)
createProperty("TextPaddingBottomRight", "Vector2", Vector2.new(), true, function(tabl, val)
	tabl.__textPaddingBottomRight = val
	refreshText(tabl)
	caretPositionChange(tabl, tabl.__caretPosition)
end)

return module
