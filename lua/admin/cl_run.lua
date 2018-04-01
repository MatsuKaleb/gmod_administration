for _, file in ipairs( file.Find( "admin/client/*.lua", "LUA" ) ) do

	include( "admin/client/" .. file )

end