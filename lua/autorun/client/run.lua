for _, file in ipairs( file.Find( "admin/admin/client/*.lua", "LUA" ) ) do

	include( "admin/admin/client/" .. file )

end