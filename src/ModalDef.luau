local React = require(script.Parent.Parent.React)

local registry = require(script.Parent.registry)

local function ModalDef(props: {
	id: string,
	component: React.FC<any>,
})
	local id = props.id
	local component = props.component

	React.useEffect(function()
		registry.register(id, component)

		return function()
			registry.unregister(id)
		end
	end, { id, component })

	return nil
end

return ModalDef
