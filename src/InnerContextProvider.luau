local React = require(script.Parent.Parent.React)

local reducer = require(script.Parent.reducer)
local _dispatch = require(script.Parent.dispatch)

local ModalPlaceholder = require(script.Parent.ModalPlaceholder)
local ModalContext = require(script.Parent.ModalContext)

local e = React.createElement

local initialState = {}

local function InnerContextProvider(props: { children: React.ReactNode })
	local modals, dispatch = React.useReducer(reducer, initialState)
	_dispatch.setDispatch(dispatch)

	return e(ModalContext.Provider, {
		value = modals,
	}, {
		Children = e(React.Fragment, nil, props.children),
		Placeholders = e(ModalPlaceholder),
	})
end

return InnerContextProvider
