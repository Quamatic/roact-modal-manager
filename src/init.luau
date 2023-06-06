local _actions = require(script.actions)

local types = require(script["types.d"])

export type ModalState = types.ModalState
export type ModalStore = types.ModalStore
export type ModalAction = types.ModalAction
export type ModalHocProps = types.ModalHocProps

return table.freeze({
	create = require(script.create),

	ModalDef = require(script.ModalDef),
	Provider = require(script.ModalProvider),
	useModal = require(script.useModal),
	reducer = require(script.reducer),

	show = _actions.show,
	hide = _actions.hide,
	remove = _actions.remove,
	setFlags = _actions.setFlags,
})
