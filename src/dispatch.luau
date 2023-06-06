local Error = require(script.Parent.Parent.LuauPolyfill).Error

local types = require(script.Parent["types.d"])
type ModalAction = types.ModalAction

export type ModalDispatch = (action: ModalAction) -> ()

local dispatch: ModalDispatch = function()
	error(Error.new("No dispatch method detected, did you embed your app with ModalProvider?"))
end

local function getDispatch()
	return dispatch
end

local function setDispatch(newDispatch: ModalDispatch)
	dispatch = newDispatch
end

return {
	getDispatch = getDispatch,
	setDispatch = setDispatch,
}
