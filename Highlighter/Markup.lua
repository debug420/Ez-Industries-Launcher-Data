--[[
	
	@Author As8D
	
	@Description
		A custom markup class, used to generate RTF (rich-text-formatted)
		text labels/buttons, and make advanced control of i.e. caret
		placement / range, color, and placeholder properties.
		
		A markup object is relatively similar to a node in an XML/HTML
		node tree. We create markups by nesting new markup elements
		into each other, and the depth overrides the style to use.
		The 'cmds' internal list contains child nodes for a parent node.
		The major different node types are:
		- Node
		- Text
		- NewLine
	
	@Modified 09/06/2017 (documentation added 14/10/2017)
	
	Constructors:
	Markup.new()
	Markup.fromBBCode(string bbcode)
	Markup.fromLanguage(string programmingLanguage, string sourceCode)
	
	Methods:
	void	Markup:Destroy()
	void	Markup:AddLineBreak()
	Markup	Markup:GetRoot()
	void	Markup:PrintTree([string prefix = ""])
	void	Markup:SetStyle(string styleName)
	string	Markup:GetText()
	void	Markup:AddText(string text)
	string	Markup:GetBBCode()
	Label	Markup:Show(GUIObject parent[, Vector2 topLeft = (0, 0)][, Vector2 bottomRight = (0, 0)])
	
	Vector2, Vector2, Vector2	Label:GetBounds(int index)
	int							Label:GetIndexByPosition(int x, int y)
	void						Label:Destroy()
	
	Properties:
	int		Markup.ZIndex
	boolean	Markup.TextWrapped
	table	Markup.StyleSheet
	
--]]

local module = {}
local api = {}
api.__index = api

local defaultStyle = {
	Font = Enum.Font.SourceSans,
	TextSize = 18,
	TextColor3 = Color3.fromRGB(192, 197, 200)
}

function module.new()
	return setmetatable({cmds = {}, ZIndex = 2, TextWrapped = true, StyleSheet = {
		keyword = {TextColor3 = Color3.fromRGB(180, 142, 170), Font = Enum.Font.SourceSansBold},
		builtin = {TextColor3 = Color3.fromRGB(220, 97, 103)},
		operator = {TextColor3 = Color3.fromRGB(202, 207, 120)},
		string = {TextColor3 = Color3.fromRGB(163, 190, 137)},
		number = {TextColor3 = Color3.fromRGB(139, 161, 174)},
		comment = {TextColor3 = Color3.fromRGB(103, 104, 105), Font = Enum.Font.SourceSansItalic}
	}}, api)
end

function module.fromBBCode(str)
	local obj, stack, escaped, text, tagName = module.new(), {}, false
	stack[1] = {nil, obj}
	for i = 1, #str do
		local char = str:sub(i, i)
		local setText = false
		local changedEscape = false
		if char == "\\" then
			changedEscape = true
			escaped = not escaped
			if not escaped then
				text = (text or "") .. char
				setText = true
			end
		elseif char == "[" and not escaped then
			if tagName then
				print(str)
				print(str:sub(1, i))
				error("Invalid BB code. Found [ symbol after " .. tagName)
			end
			tagName = "["
		elseif tagName and char == "]" then
			if tagName == "[break" then
				stack[#stack][2]:AddLineBreak()
			elseif tagName:sub(2, 2) == "/" then
				if stack[#stack][1] ~= tagName:sub(3) then
					print(str)
					print(str:sub(1, i))
					error("Mismatching closing tag (expected " .. (stack[#stack][1] or "nil") .. ", got " .. tagName:sub(3) .. ")")
				end
				table.remove(stack)
			else
				stack[#stack + 1] = {tagName:sub(2), stack[#stack][2]:SetStyle(tagName:sub(2))}
			end
			tagName = nil
		elseif tagName then
			tagName = tagName .. char
		else
			text = (text or "") .. char
			setText = true
		end
		if not changedEscape then
			escaped = false
		end
		if text and (not setText or i == #str) then
			stack[#stack][2]:AddText(text)
			text = nil
		end
	end
	return obj
end

function module.fromLanguage(lang, str)
	local lib = script:FindFirstChild(lang:lower())
	assert(lib, "Language not reckognized.")
	return module.fromBBCode(require(lib)(str))
end

function api:Destroy()
	if self.cmds then
		for i = 1, #self.cmds do
			self.cmds[i]:Destroy()
		end
	end
	setmetatable(self, {__mode = "kv"})
end

function api:AddLineBreak()
	self.cmds[#self.cmds + 1] = setmetatable({newline = true, parent = self}, api)
end

function api:GetRoot()
	if self.parent then
		return self.parent:GetRoot()
	else
		return self
	end
end

function api:PrintTree(prefix)
	prefix = prefix or ""
	if self.cmds then
		print(prefix, "[style='" .. (self.styleName or "<ROOT>") .. "']")
		for i = 1, #self.cmds do
			self.cmds[i]:PrintTree(prefix .. ">")
		end
	elseif self.text then
		print(prefix, "'" .. self.text .. "'")
	elseif self.newline then
		print(prefix, "[break]")
	end
end

function api:SetStyle(styleName)
	local tag = setmetatable({style = self:GetRoot().StyleSheet[styleName], parent = self, styleName = styleName, cmds = {}}, api)
	self.cmds[#self.cmds + 1] = tag
	return tag
end

function api:GetText()
	if self.text then
		return self.text
	elseif self.newline then
		return "\n"
	elseif self.cmds then
		local str = ""
		for i = 1, #self.cmds do
			str = str .. self.cmds[i]:GetText()
		end
		return str
	else
		return tostring(self)
	end
end

function api:AddText(text)
	if self.cmds then
		self.cmds[#self.cmds + 1] = setmetatable({text = text, parent = self}, api)
	end
end

function api:GetBBCode()
	if self.style then
		local str = ""
		for i = 1, #self.cmds do
			str = str .. self.cmds[i]:GetBBCode()
		end
		return (self.styleName and "[" .. self.styleName .. "]" or "") .. str .. (self.styleName and "[/" .. self.styleName .. "]" or "")
	elseif self.text then
		return self.text
	elseif self.newline then
		return "[break]"
	elseif self.cmds then
		local str = ""
		for i = 1, #self.cmds do
			str = str .. self.cmds[i]:GetBBCode()
		end
		return str
	else
		return tostring(self)
	end
end

local function merge(tabl1, tabl2)
	local t = {}
	for key, val in next, tabl1 do
		t[key] = val
	end
	for key, val in next, tabl2 do
		t[key] = val
	end
	return t
end

local function makeLabel(style, text, bounds)
	local n = Instance.new("TextLabel")
	n.BackgroundTransparency = 1
	n.Font = style.Font or defaultStyle.Font
	n.TextSize = style.TextSize or defaultStyle.TextSize
	n.TextColor3 = style.TextColor3 or defaultStyle.TextColor3
	n.TextXAlignment = "Left"
	n.Text = text
	local size = game:GetService("TextService"):GetTextSize(text, n.TextSize, n.Font, bounds)
	n.Size = UDim2.new(0, size.X, 0, defaultStyle.TextSize)
	return n
end

local labelapi = {}
labelapi.__index = labelapi

function labelapi:GetBounds(index)
	if self.cachedBounds[index] then
		return unpack(self.cachedBounds[index])
	end
	if index == 0 then
		return self.topLeft, Vector2.new(0, defaultStyle.TextSize), self.topLeft
	end
	local sumIndex, pos = 0, Vector2.new()
	for i = 1, #self.list do
		if self.list[i].label then
			local current = self.list[i].label
			if sumIndex + #current.Text >= index then
				local charPos = index - sumIndex
				local offset = game:GetService("TextService"):GetTextSize(
					current.Text:sub(1, charPos - 1), current.TextSize, current.Font, current.AbsoluteSize)
				local size = game:GetService("TextService"):GetTextSize(
					current.Text:sub(charPos, charPos), current.TextSize, current.Font, current.AbsoluteSize)
				local position = Vector2.new(current.Position.X.Offset + offset.X + 1, current.Position.Y.Offset)
				self.cachedBounds[index] = {position, size, position + Vector2.new(size.X, 0)}
				return unpack(self.cachedBounds[index])
			else
				if current.Position.Y.Offset > pos.Y then
					pos = Vector2.new(current.AbsoluteSize.X, pos.Y + defaultStyle.TextSize)
				else
					pos = pos + Vector2.new(current.AbsoluteSize.X, 0)
				end
				sumIndex = sumIndex + #current.Text
			end
		elseif self.list[i].newline then
			sumIndex = sumIndex + 1
			pos = Vector2.new(self.topLeft.X, pos.Y + (self.topLeft.Y > 0 and self.topLeft.Y or defaultStyle.TextSize))
			if sumIndex >= index then
				if sumIndex > 0 then
					self.cachedBounds[index] = {pos, Vector2.new(0, defaultStyle.TextSize), pos}
					return unpack(self.cachedBounds[index])
				else
					self.cachedBounds[index] = {self.topLeft, Vector2.new(0, defaultStyle.TextSize), self.topLeft}
					return unpack(self.cachedBounds[index])
				end
			end
		end
	end
	local yOffset, resetX = 0, false
	for i = #self.list, 1, -1 do
		if self.list[i].label then
			self.cachedBounds[index] = {
				Vector2.new(resetX and self.topLeft.X or self.list[i].label.Position.X.Offset + self.list[i].label.AbsoluteSize.X, self.list[i].label.Position.Y.Offset + yOffset),
				Vector2.new(0, defaultStyle.TextSize)
			}
			self.cachedBounds[index][3] = self.cachedBounds[index][1]
			return unpack(self.cachedBounds[index])
		elseif self.list[i].newline then
			yOffset = yOffset + defaultStyle.TextSize
			resetX = true
		end
	end
	self.cachedBounds[index] = {Vector2.new(0, yOffset) + self.topLeft, Vector2.new(0, defaultStyle.TextSize), Vector2.new(0, yOffset) + self.topLeft}
	return unpack(self.cachedBounds[index])
end

function labelapi:GetIndexByPosition(x, y)
	--local sumIndex, lastLineIndex, currentLineOffsetY = 0, 1, 0
	--[[for i = 1, #self.list - 1 do
		if self.list[i].label then
			if self.list[i + 1].newline or self.list[i].label.AbsolutePosition.Y < self.list[i + 1].label.AbsolutePosition.Y then
				lastLineIndex = i + 1
			end
		elseif self.list[i].newline then
			if self.list[i + 1].newline then
				lastLineIndex = i + 1
			end
		end
	end
	for i = 1, #self.list do
		if self.list[i].label then
			local current = self.list[i].label
			if (current.Position.X.Offset == 0 or current.AbsolutePosition.X <= x) and (current.Position.Y.Offset == 0 or current.AbsolutePosition.Y <= y)
				and (i >= lastLineIndex or current.AbsolutePosition.Y + current.AbsoluteSize.Y >= y) and (i == #self.list or
				(self.list[i + 1].newline or current.AbsolutePosition.Y < self.list[i + 1].label.AbsolutePosition.Y) or current.AbsolutePosition.X +
					current.AbsoluteSize.X >= x) then
				for j = 1, #current.Text do
					local offset = game:GetService("TextService"):GetTextSize(
						current.Text:sub(1, j), current.TextSize, current.Font, current.AbsoluteSize * 2)
					if current.AbsolutePosition.X + offset.X > x or j == #current.Text then
						local result = sumIndex + j + ((j == #current.Text and i < #self.list and self.list[i + 1].newline) and 1 or 0)
						local pos, size = self:GetBounds(result)
						return result + ((i == #self.list or not self.list[i + 1].newline) and ((x - self.parent.AbsolutePosition.X - pos.X) / size.X) > 0.5 and 1 or 0)
					end
				end
				return sumIndex + #current.Text
			end
			sumIndex = sumIndex + #current.Text
			if i < #self.list and self.list[i + 1].label and current.AbsolutePosition.Y < self.list[i + 1].label.AbsolutePosition.Y then
				currentLineOffsetY = self.list[i + 1].label.Position.Y.Offset
			end
		elseif self.list[i].newline then
			sumIndex = sumIndex + 1
			if currentLineOffsetY <= y - self.parent.AbsolutePosition.Y and
				currentLineOffsetY + defaultStyle.TextSize >= y - self.parent.AbsolutePosition.Y then
				return sumIndex
			end
			currentLineOffsetY = currentLineOffsetY + defaultStyle.TextSize
		end
	end]]
	local len = #self.root:GetText()
	local absPosX, absPosY = self.parent.AbsolutePosition.X, self.parent.AbsolutePosition.Y
	for i = 1, len do
		local pos, size, caretPos = self:GetBounds(i)
		local moveLeft = ((x - absPosX - caretPos.X) / size.X < -0.5 and 1 or 0)
		if pos.X + absPosX >= x and pos.Y + absPosY >= y then
			return i - moveLeft
		elseif i < len and pos.Y + absPosY <= y and self:GetBounds(i + 1).Y + absPosY > y then
			return i
		elseif pos.Y + absPosY <= y and pos.Y + size.Y + absPosY > y and pos.X + size.X + absPosX > x then
			return i - moveLeft
		end
	end
	return len + 1
end

function labelapi:Destroy()
	setmetatable(self.list, {__mode = "kv"})
	setmetatable(self, {__mode = "kv"})
end

function api:Show(parent, topLeft, bottomRight)
	topLeft = topLeft or Vector2.new()
	bottomRight = bottomRight or Vector2.new()
	local x, y, list, parentWidth = 0, 0, {}, parent.AbsoluteSize.X - bottomRight.X
	
	local function scan(obj, style)
		if obj.cmds then
			if obj.style then
				style = merge(style, obj.style)
			end
			for i = 1, #obj.cmds do
				scan(obj.cmds[i], style)
			end
		elseif obj.newline then
			x = 0
			y = y + defaultStyle.TextSize
			list[#list + 1] = {newline = true}
		elseif obj.text then
			local label = makeLabel(style, obj.text, parent.AbsoluteSize * 2)
			label.Position = UDim2.new(0, x + topLeft.X, 0, y + topLeft.Y)
			label.ZIndex = obj:GetRoot().ZIndex
			list[#list + 1] = {label = label}
			if obj:GetRoot().TextWrapped and x + label.Size.X.Offset > parentWidth then
				for i = #obj.text, 0, -1 do
					if i == 0 then
						x = 0
						y = y + defaultStyle.TextSize
						label.Position = UDim2.new(0, x + topLeft.X, 0, y + topLeft.Y)
					else
						local size = game:GetService("TextService"):GetTextSize(obj.text:sub(1, i), label.TextSize, label.Font, parent.AbsoluteSize * 2)
						if x + size.X <= parentWidth then
							label.Text = obj.text:sub(1, i)
							label.Size = UDim2.new(0, size.X, 0, size.Y)
							if i < #obj.text then
								x = 0
								y = y + defaultStyle.TextSize
								scan(setmetatable({text = obj.text:sub(i + 1), parent = obj.parent}, api), style)
							end
							break
						end
					end
				end
			else
				x = x + label.Size.X.Offset
			end
			label.Parent = parent
		end
	end
	
	scan(self, {})
	
	return setmetatable({list = list, topLeft = topLeft, bottomRight = bottomRight, cachedBounds = {}, root = self, parent = parent}, labelapi)
end

return module
