local keywords = {
	"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in",
	"local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"
}

local operators = {
	"+", "-", "*", "/", "%", "^", "#", "==", "~=", "<=", ">=", "<", ">",
	"=", "(", ")", "{", "}", "\\[", "]", ";", ":", ",", ".", "..", "..."
}

local stdvar = {
	"assert",
	"collectgarbage",
	"dofile",
	"error",
	"_G",
	"genfenv",
	"getmetatable",
	"ipairs",
	"load",
	"loadfile",
	"loadstring",
	"next",
	"pairs",
	"pcall",
	"print",
	"rawequal",
	"rawget",
	"rawset",
	"select",
	"setfenv",
	"setmetatable",
	"tonumber",
	"tostring",
	"type",
	"unpack",
	"_VERSION",
	"xpcall",
	"module",
	"require"
}

local stdlib = {
	"coroutine",
	"string",
	"table",
	"math",
	"os",
	"debug"
}

return function(code)
	local result, stack = "", {isOperator = false}
	code = code:gsub("\\", "\\\\"):gsub("%[", "\\[")
	for i = 1, #code do
		local char = code:sub(i, i)
		local isOperator, lastOperator = false
		for j = 1, #operators do
			if code:sub(i + 1 - #operators[j], i) == operators[j] then
				isOperator = true
				lastOperator = operators[j]
				break
			end
		end
		local isKeyword = false
		local word = code:sub(1, i):match("[%w_]+$")
		for j = 1, #keywords do
			if word == keywords[j] and (i == #code or not code:sub(i + 1, i + 1):match("[%w_]")) then
				isKeyword = true
				break
			end
		end
		local isBuiltin = false
		for j = 1, #stdvar do
			if word == stdvar[j] and (i == #code or not code:sub(i + 1, i + 1):match("[%w_]")) then
				isBuiltin = true
				break
			end
		end
		for j = 1, #stdlib do
			if word == stdlib[j] and (i == #code or not code:sub(i + 1, i + 1):match("[%w_]")) then
				stack.lastLib = word
				isBuiltin = true
				break
			end
		end
		if stack.lastLib and not (lastOperator == "." or lastOperator == ":" or char:match("[%w_]")) then
			stack.lastLib = nil
		end
		local skip = false
		if code:sub(i - 1, i) == "\\[" then
			if not stack.comment then
				result = result:sub(1, #result - 1) .. "[operator]\\[[/operator]"
				if not stack.multilineLevel then
					local mlMatch = result:match("%[operator%]\\%[%[/operator%][(%[operator%]=+%[/operator%])]*%[operator%]\\%[%[/operator%]")
					if mlMatch then
						print("MlMatch:", mlMatch)
						stack.multilineLevel = #(mlMatch:match("=+") or "")
						stack.isOperator = false
						result = result:sub(1, #result - #mlMatch - 47) .. (stack.comment and "" or "[string]") .. "\\[" .. ("="):rep(stack.multilineLevel) .. "\\["
					end
				end
			else
				result = result .. "["
				local mlMatch = result:match("--\\%[=*\\%[$")
				if mlMatch then
					result = result:gsub("%[operator%]%[comment%]%-%-\\%[(%=*)\\%[$", "[comment]--\\[%1\\[")
					stack.isOperator = false
					stack.multilineLevel = #mlMatch - 6
					print("multilineLevel:", #mlMatch - 6)
				end
			end
		else
			if isOperator ~= stack.isOperator and not stack.comment and not stack.string and (not stack.number or char ~= ".") then
				if stack.number then
					result = result .. "[/number]"
					stack.number = nil
				end
				stack.isOperator = isOperator
				result = result .. "[" .. (isOperator and "" or "/") .. "operator]"
			end
		end
		if stack.number and not (code:sub(i - 1, i):lower() == "0x" or char:match("[%x%.]")) then
			result = result .. "[/number]"
			stack.number = nil
		end
		if isKeyword and not stack.comment and not stack.string then
			result = result:sub(1, #result - #word + 1) .. "[keyword]" .. word .. "[/keyword]"
		elseif stack.lastLib and getfenv()[stack.lastLib][word] then
			result = result:sub(1, #result - #word + 1) .. "[builtin]" .. word .. "[/builtin]"
		elseif isBuiltin and not stack.comment and not stack.string then
			result = result:sub(1, #result - #word + 1) .. "[builtin]" .. word .. "[/builtin]"
		elseif char:match("%d") and word and word:match("^%d+") and not stack.number then
			if code:sub(i - 1, i - 1) == "." then
				result = result:sub(1, #result - 1) .. "[number]." .. char
			else
				result = result .. "[number]" .. char
			end
			stack.number = true
		elseif (char == "\""  or char == "'") and not stack.escaped and not stack.comment and not stack.multilineLevel then
			if stack.string and char == stack.string then
				result = result .. char .. "[/string]"
				stack.string = nil
			elseif not stack.string then
				result = result .. "[string]" .. char
				stack.string = char
			else
				result = result .. char
			end
		elseif char == "-" and code:sub(i - 1, i - 1) == "-" and not stack.comment and not stack.string and not stack.multilineLevel then
			result = result:gsub("%[operator%]$", "")
			result = result:sub(1, #result - 1) .. "[comment]--"
			stack.comment = true
		elseif char == "\n" then
			if stack.comment and not stack.multilineLevel then
				result = result .. "[/comment]"
				stack.comment = nil
			end
			if stack.string and not stack.multilineLevel then
				result = result .. "[/string]"
				stack.string = nil
			end
			if stack.isOperator and not stack.multilineLevel then
				result = result .. "[/operator]"
				stack.isOperator = false
			end
			result = result .. "[break]"
		elseif code:sub(i - 1, i) == "\\[" or char == "\r" then
		elseif not skip then
			result = result .. char
		end
		if stack.multilineLevel and result:match("%[operator%]%]" .. ("="):rep(stack.multilineLevel) .. "%]$") then
			result = result:sub(1, #result - #result:match("%[operator%]%]" .. ("="):rep(stack.multilineLevel) .. "%]$")) .. "]" .. ("="):rep(stack.multilineLevel) .. "]" .. (stack.comment and "[/comment]" or "[/string]")
			stack.multilineLevel = nil
			stack.isOperator = false
		elseif stack.multilineLevel and stack.comment and result:match("%]" .. ("="):rep(stack.multilineLevel) .. "%]$") then
			--print("closing tag:", result:match("%]" .. ("="):rep(stack.multilineLevel) .. "%]$"), "level:", stack.multilineLevel)
			result = result .. "[/comment]"
			stack.multilineLevel = nil
			stack.comment = nil
			stack.isOperator = false
		end
		if char == "\\" then
			stack.escaped = not stack.escaped
		else
			stack.escaped = false
		end
	end
	if stack.comment then
		result = result .. "[/comment]"
	end
	if stack.string then
		result = result .. "[/string]"
	end
	if stack.number then
		result = result .. "[/number]"
	end
	if stack.isOperator then
		result = result .. "[/operator]"
	end
	
	return result
end
