Admin.ConsoleMessage( "Loaded Server Side" )

for _, file in ipairs( file.Find( "admin/admin/server/*.lua", "LUA" ) ) do

	include( "admin/admin/server/" .. file )

	Admin.ConsoleMessage( "Loaded Server File: admin/admin/server/" .. file )

end

for _, file in ipairs( file.Find( "admin/admin/client/*.lua", "LUA" ) ) do

	AddCSLuaFile( "admin/admin/client/" .. file )

end