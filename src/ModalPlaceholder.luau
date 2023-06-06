local React = require(script.Parent.Parent.React)
local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local Object, Array, console = LuauPolyfill.Object, LuauPolyfill.Array, LuauPolyfill.console

local registry = require(script.Parent.registry)
local isModalRegisteredAndMounted = registry.isModalRegisteredAndMounted
local getModal = registry.getModal

local ModalContext = require(script.Parent.ModalContext)

local e = React.createElement

local function ModalPlaceholder()
	local modals = React.useContext(ModalContext)
	local visibleModalIds = Array.filter(Object.keys(modals), function(id)
		return not not modals[id]
	end)

	Array.forEach(visibleModalIds, function(id)
		if not isModalRegisteredAndMounted(id) then
			console.warn(
				`No modal found for id: ${id}. Please check the id or if it is registered or declared via Roact.`
			)
		end
	end)

	local rendered = Array.map(visibleModalIds, function(id)
		return Object.assign({ id = id }, getModal(id))
	end)

	return e(
		React.Fragment,
		nil,
		Array.map(rendered, function(modal)
			return e(modal.component, Object.assign({ key = modal.id, id = modal.id }, modal.props))
		end)
	)
end

return ModalPlaceholder :: React.FC<{}>
