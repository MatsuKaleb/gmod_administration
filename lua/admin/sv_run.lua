Admin.ConsoleMessage( "Loaded Server Side" )

for _, file in ipairs( file.Find( "admin/server/*.lua", "LUA" ) ) do

	include( "admin/server/" .. file )

	Admin.ConsoleMessage( "Loaded Server File: admin/server/" .. file )

end

for _, file in ipairs( file.Find( "admin/client/*.lua", "LUA" ) ) do

	AddCSLuaFile( "admin/client/" .. file )

end