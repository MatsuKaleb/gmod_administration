Admin = Admin || {}

function Admin.ConsoleMessage( msg )

	if ( SERVER ) then

		print( "[Admin] -> " .. msg )

	end

end

if ( SERVER ) then

	AddCSLuaFile( "admin/sh_run.lua" )
	AddCSLuaFile( "admin/cl_run.lua" )
	include( "admin/sh_run.lua" )
	include( "admin/sv_run.lua" )

else

	include( "admin/sh_run.lua" )
	include( "admin/cl_run.lua" )

end