local React = require(script.Parent.Parent.React)

local types = require(script.Parent["types.d"])
type ModalStore = types.ModalStore

local ModalContext = React.createContext({} :: ModalStore)

return ModalContext
