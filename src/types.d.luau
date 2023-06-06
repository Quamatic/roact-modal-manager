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
		promise: unknown,
	},
}

export type ModalHandler<Props> = ModalState & {
	show: (args: Props?) -> unknown,
	hide: () -> unknown,
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
