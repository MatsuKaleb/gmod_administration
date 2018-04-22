Admin.Config = Admin.Config || {}
Admin.Config.Colors = Admin.Config.Colors || {}

local cfg = Admin.Config
cfg.ChatCommandPrefix = "!"
cfg.ConCommand = "admin"

cfg.DB_Host = ""
cfg.DB_User = ""
cfg.DB_Pass = ""
cfg.DB_Name = ""
cfg.DB_Port = ""


local clrs = Admin.Config.Colors
clrs.Main = Color( 240, 240, 240 )
clrs.Caller = Color( 20, 130, 180 )
clrs.Target = Color( 180, 130, 20 )
clrs.NotAllowed = Color( 170, 45, 45 )

clrs.Types = {

	[ "number" ] = Color( 185, 165, 15),
	[ "string" ] = Color( 185, 165, 15),
	[ "table" ] = Color( 185, 165, 15),
	[ "not value" ] = clrs.Main

}
