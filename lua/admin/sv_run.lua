Admin.ConsoleMessage( "Loaded Server Side" )

for _, file in ipairs( file.Find( "admin/server/*.lua", "LUA" ) ) do

	include( "admin/server/" .. file )

	Admin.ConsoleMessage( "Loaded Server File: admin/server/" .. file )

end