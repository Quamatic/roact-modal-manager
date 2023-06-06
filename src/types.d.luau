local LuauPolyfill = require(script.Parent.Parent.LuauPolyfill)

type Promise<T> = LuauPolyfill.Promise<T>

export type ModalState = {
	id: string,
	args: { [string]: unknown }?,
	visible: boolean?,
	delayVisible: boolean?,
	keepMounted: boolean?,
}

export type ModalStore = {
	[string]: ModalState,
}

export type ModalAction = {
	type: string,
	payload: {
		modalId: string,
		args: { [string]: unknown }?,
		flags: { [string]: unknown }?,
	},
}

export type ModalCallbacks = {
	[string]: {
		resolve: (args: unknown) -> ()?,
		reject: (args: unknown) -> ()?,
		promise: Promise<unknown>,
	},
}

export type ModalHandler<Props> = ModalState & {
	show: (args: Props?) -> Promise<unknown>,
	hide: () -> Promise<unknown>,
	resolve: (args: unknown) -> (),
	reject: (args: unknown) -> (),
	remove: () -> (),
	resolveHide: (args: unknown) -> (),
}

export type ModalHocProps = {
	id: string,
	defaultVisible: boolean?,
	keepMounted: boolean?,
}

return {}
