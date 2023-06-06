local React = require(script.Parent.Parent.React)
local Object = require(script.Parent.Parent.LuauPolyfill).Object

local registry = require(script.Parent.registry)
local mount, unmount = registry.mount, registry.unmount

local actions = require(script.Parent.actions)
local setFlags = actions.setFlags

local useModal = require(script.Parent.useModal)
local ModalContext = require(script.Parent.ModalContext)
local ModalIdContext = require(script.Parent.ModalIdContext)

local types = require(script.Parent["types.d"])
type ModalHocProps = types.ModalHocProps

local e = React.createElement

local function create<P>(ModalComponent: React.ComponentType<P>): React.FC<P & ModalHocProps>
	return function(props)
		local id = props.id
		local defaultVisible = props.defaultVisible
		local keepMounted = props.keepMounted

		local modal = useModal(id)
		local args = modal.args
		local show = modal.show

		local modals = React.useContext(ModalContext)
		local shouldMount = not not modals[id]

		React.useEffect(function()
			if defaultVisible then
				show()
			end

			mount(id)

			return function()
				unmount(id)
			end
		end, { id, show, defaultVisible })

		React.useEffect(function()
			if keepMounted then
				setFlags(id, { keepMounted = true })
			end
		end, { id, keepMounted })

		local delayVisible = (modals[id] or {}).delayVisible

		React.useEffect(function()
			if delayVisible then
				show(args)
			end
		end, { delayVisible, args, show })

		if not shouldMount then
			return nil
		end

		return e(ModalIdContext.Provider, {
			value = id,
		}, e(ModalComponent, Object.assign({}, props, args)))
	end
end

return create
