local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)
local Set = LuauPolyfill.Set
type Set<T> = LuauPolyfill.Set<T>

local alreadyMounted = Set.new() :: Set<string>
local modalRegistry = {}

local function register(id: string, component, props)
	if not modalRegistry[id] then
		modalRegistry[id] = { props = props, component = component }
	else
		modalRegistry[id].props = props
	end
end

local function unregister(id: string)
	modalRegistry[id] = nil
end

local function isModalRegistered(id: string)
	return modalRegistry[id] and alreadyMounted:has(id)
end

local function isRegistered(id: string)
	return modalRegistry[id] ~= nil
end

local function getModal(id: string)
	return modalRegistry[id]
end

local function mount(id: string)
	alreadyMounted:add(id)
end

local function unmount(id: string)
	alreadyMounted:delete(id)
end

return {
	register = register,
	unregister = unregister,
	getModal = getModal,
	isModalRegistered = isModalRegistered,
	isRegistered = isRegistered,
	mount = mount,
	unmount = unmount,
}
