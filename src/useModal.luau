local React = require(script.Parent.Parent.React)
local Error = require(script.Parent.Parent.LuauPolyfill).Error

local registry = require(script.Parent.registry)
local register, isRegistered = registry.register, registry.isRegistered

local actions = require(script.Parent.actions)
local show, hide, remove = actions.show, actions.hide, actions.remove

local getModalId = require(script.Parent.getModalId)

local ModalContext = require(script.Parent.ModalContext)
local ModalIdContext = require(script.Parent.ModalIdContext)

local function useModal(modal: any?, args: any?)
	local modals = React.useContext(ModalContext)
	local modalIdContext = React.useContext(ModalIdContext)

	local modalId: string?
	local isUseComponent = type(modal) == "string"

	if not modal then
		modalId = modalIdContext
	else
		modalId = getModalId(modal)
	end

	if not modalId then
		error(Error.new("No modal id found in RoactModalManager.useModal"))
	end

	React.useEffect(function()
		if isUseComponent and not isRegistered(modalId) then
			register(modalId, modal :: React.FC<any>, args)
		end
	end, { isUseComponent, modalId, modal, args })

	local modalInfo = modals[modalId] or {}

	local showCallback = React.useCallback(function(_args: { [string]: unknown }?)
		return show(modalId, _args)
	end, { modalId })

	local hideCallback = React.useCallback(function()
		return hide(modalId)
	end, { modalId })

	local removeCallback = React.useCallback(function()
		return remove(modalId)
	end, { modalId })

	return React.useMemo(function()
		return {
			id = modalId,
			args = modalInfo.args,
			visible = not not modalInfo.visible,
			keepMounted = not not modalInfo.keepMounted,
			show = showCallback,
			hide = hideCallback,
			remove = removeCallback,
		}
	end, { modalId, modalInfo, showCallback, hideCallback, removeCallback })
end

return useModal
