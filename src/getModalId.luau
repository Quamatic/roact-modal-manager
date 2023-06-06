local Symbol = require(script.Parent.Parent.LuauPolyfill).Symbol

local MODAL_ID_SYMBOL = Symbol("RoactModalId")

local nextId = 0

local function getUuid()
	return `_react_modal_{nextId}`
end

local function getModalId(modal): string
	if not modal[MODAL_ID_SYMBOL] then
		modal[MODAL_ID_SYMBOL] = getUuid()
	end

	return modal[MODAL_ID_SYMBOL]
end

return getModalId
