local LuauPollyfill = require(script.Parent.Parent.LuauPolyfill)
local Object = LuauPollyfill.Object

local types = require(script.Parent["types.d"])

type ModalStore = types.ModalStore
type ModalAction = types.ModalAction

local function reducer(state: ModalStore, action: ModalAction)
	if state == nil then
		state = {} :: ModalStore
	end

	if action.type == "modal/show" then
		local modalId = action.payload.modalId
		local args = action.payload.args

		return Object.assign({}, state, {
			[modalId] = Object.assign({}, state[modalId], {
				id = modalId,
				args = args,
			}),
		})
	elseif action.type == "modal/hide" then
		local modalId = action.payload.modalId

		if not state[modalId] then
			return state
		end

		return Object.assign({}, state, {
			[modalId] = Object.assign({}, state[modalId], {
				visible = false,
			}),
		})
	elseif action.type == "modal/remove" then
		local modalId = action.payload.modalId
		local newState = Object.assign({}, state, {
			[modalId] = Object.None,
		})

		return newState
	elseif action.type == "modal/set-flags" then
		local modalId = action.payload.modalId
		local flags = action.payload.flags

		return Object.assign({}, state, {
			[modalId] = Object.assign({}, state[modalId], flags),
		})
	end

	return state
end

return reducer
