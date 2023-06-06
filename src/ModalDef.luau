local React = require(script.Parent.Parent.React)

local registry = require(script.Parent.registry)
local register, unregister = registry.register, registry.unregister

local function ModalDef(props: {
	id: string,
	component: React.FC<any>,
})
	local id = props.id
	local component = props.component

	React.useEffect(function()
		register(id, component)

		return function()
			unregister(id)
		end
	end, { id, component })

	return nil
end

return ModalDef
