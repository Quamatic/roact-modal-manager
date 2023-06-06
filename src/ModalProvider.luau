local React = require(script.Parent.Parent.React)

local ModalContext = require(script.Parent.ModalContext)
local InnerContextProvider = require(script.Parent.InnerContextProvider)
local ModalPlaceholder = require(script.Parent.ModalPlaceholder)

local _dispatch = require(script.Parent.dispatch)
type ModalDispatch = _dispatch.ModalDispatch

local types = require(script.Parent["types.d"])
type ModalStore = types.ModalStore

local e = React.createElement

local function ModalProvider(props: {
	children: React.ReactNode,
	dispatch: ModalDispatch?,
	modals: ModalStore?,
})
	local modals = props.modals
	local dispatch = props.dispatch

	if not modals or not dispatch then
		return e(InnerContextProvider, nil, props.children)
	end

	_dispatch.setDispatch(dispatch)

	return e(ModalContext.Provider, {
		value = modals,
	}, {
		Children = e(React.Fragment, nil, props.children),
		ModalPlaceholder = e(ModalPlaceholder),
	})
end

return ModalProvider
