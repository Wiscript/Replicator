
local Types = {}

local Trove = require(script.Parent.Parent.Trove) :: { any }

type Listener = (ClientReplica, Indice, (Indice, any, any) -> ()) -> (RBXScriptConnection)
type ReplicateTo = { Player } | Player | "All"

export type Indice = { string | number } | string
export type unknown = any
export type Signal = {
	Connect: RBXScriptConnection,
}
export type Cleaner = typeof(Trove.new())

export type ClientWriteLib = {[string]: (ClientReplica, any) -> (any)}
export type ServerWriteLib = {[string]: (ServerReplica, any) -> (any)}

export type ClientReplica = {
	WriteFunctionFlag: boolean,
	WriteLib: ClientWriteLib?,
	Id: string,
	Tags: {any},
	Data: {any},

	AddCleanupTask: (ClientReplica, () -> nil) -> (),
	Update: (ClientReplica, Indice, any, any) -> (),
	Changed: Signal,
	Cleaner: Cleaner,

	ListenToWrite: Listener,
	ListenToChange: Listener,
	ListenToNewKey: Listener,
	ListenToKeyRemoved: Listener,

	FireServer: (...any) -> (),
	Destroy: (ClientReplica) -> (),

	Set: () -> (), -- useless
	
	_Callbacks: {[string]: {(any) -> (any)}},
	_WriteCallbacks: {[string]: {(any) -> (any)}}
}

export type ReplicaConfig = {
	Name: string,
	Tags: { any }?,
	Data: { any },
	To: ReplicateTo,
}

export type ServerReplica = {
	Name: string,
	To: ReplicateTo,
	Tags: {any},
	Data: {any},
	WriteLibModule: ModuleScript?,
	WriteLib: ServerWriteLib?,
	ServerEvents: {(...any) -> ()},

	Changed: any,

	ConnectOnServerEvent: (ServerReplica, (...any) -> ()) -> (() -> ()),
	AddCleanupTask: (ServerReplica, () -> nil) -> (),
	Write: (ServerReplica, string, ...any) -> (any),
	Set: (ServerReplica, {unknown} | string, any) -> (),
	ListenToChange: Listener,
	ListenToNewKey: Listener,
	ListenToKeyRemoved: Listener,
	Cleaner: Cleaner,
	Destroy: (ServerReplica) -> ()
}

return Types