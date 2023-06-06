local React = require(script.Parent.Parent.React)
local Promise = require(script.Parent.Parent.Promise)

local _dispatch = require(script.Parent.dispatch)
local registry = require(script.Parent.registry)
local isRegistered, register = registry.isRegistered, registry.register

local getModalId = require(script.Parent.getModalId)

local types = require(script.Parent["types.d"])
type ModalAction = types.ModalAction
type ModalCallbacks = types.ModalCallbacks

local modalCallbacks: ModalCallbacks = {}
local hideModalCallbacks: ModalCallbacks = {}

local function showModal(modalId: string, args: { [string]: unknown }?): ModalAction
	return {
		type = "modal/show",
		payload = {
			modalId = modalId,
			args = args,
		},
	}
end

local function setModalFlags(modalId: string, flags: { [string]: unknown }?): ModalAction
	return {
		type = "modal/set-flags",
		payload = {
			modalId = modalId,
			flags = flags,
		},
	}
end

local function hideModal(modalId: string): ModalAction
	return {
		type = "modal/hide",
		payload = {
			modalId = modalId,
		},
	}
end

local function removeModal(modalId: string): ModalAction
	return {
		type = "modal/remove",
		payload = {
			modalId = modalId,
		},
	}
end

local function show(modal: React.FC<any> | string, args: { [string]: unknown }?)
	local modalId = getModalId(modal)

	if type(modal) ~= "string" and not isRegistered(modalId) then
		register(modalId, modal :: React.FC<any>)
	end

	local dispatch = _dispatch.getDispatch()
	dispatch(showModal(modalId, args))

	if not modalCallbacks[modalId] then
		local promise
		promise = Promise.new(function(resolve, reject)
			modalCallbacks[modalId] = {
				resolve = resolve,
				reject = reject,
				promise = promise,
			}
		end)

		return promise
	end

	return modalCallbacks[modalId].promise
end

local function hide(modal: string | React.FC<any>)
	local modalId = getModalId(modal)
	local dispatch = _dispatch.getDispatch()

	dispatch(hideModal(modalId))
	modalCallbacks[modalId] = nil

	if not hideModalCallbacks[modalId] then
		local promise
		promise = Promise.new(function(resolve, reject)
			modalCallbacks[modalId] = {
				resolve = resolve,
				reject = reject,
				promise = promise,
			}
		end)

		return promise
	end

	return hideModalCallbacks[modalId].promise
end

local function remove(modalId: string)
	local dispatch = _dispatch.getDispatch()
	dispatch(removeModal(modalId))

	modalCallbacks[modalId] = nil
	hideModalCallbacks[modalId] = nil
end

local function setFlags(modalId: string, flags: { [string]: unknown })
	local dispatch = _dispatch.getDispatch()
	dispatch(setModalFlags(modalId, flags))
end

return {
	show = show,
	hide = hide,
	remove = remove,
	setFlags = setFlags,
}
