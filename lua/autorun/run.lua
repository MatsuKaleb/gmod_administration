Admin = Admin || {}

function Admin.ConsoleMessage( msg )

	if ( SERVER ) then

		print( "[Admin] -> " .. msg )

	end

end

if ( SERVER ) then

	AddCSLuaFile( "admin/config.lua" )
	include( "admin/config.lua" )

else

	include( "admin/config.lua" )

end

Admin.ConsoleMessage( "Loaded Shared Side" )

for _, file in ipairs( file.Find( "admin/admin/shared/*.lua", "LUA" ) ) do

	if ( SERVER ) then

		AddCSLuaFile( "admin/admin/shared/" .. file )
		include( "admin/admin/shared/" .. file )

		Admin.ConsoleMessage( "Loaded Shared File: admin/admin/shared/" .. file )

	else

		include( "admin/admin/shared/" .. file )

	end

end

hook.Add( "Initialize", "Admin_Gamemode_Module_Autodetect", function()

	local gamemode = engine.ActiveGamemode()

	if file.Find( "admin/commands/" .. gamemode, "LUA" ) then

		for _, file in ipairs( file.Find( "admin/commands/" .. gamemode .. "/*.lua", "LUA" ) ) do

			if string.StartWith( file, "sv_" ) then

				if ( SERVER ) then

					include( "admin/commands/" .. gamemode .. "/" .. file )

					Admin.ConsoleMessage( "Loaded Server File: admin/commands/" .. gamemode .. "/" .. file )

				end

			elseif string.StartWith( file, "cl_" ) then

				if ( SERVER ) then

					AddCSLuaFile( "admin/commands/" .. gamemode .. "/" .. file )

					Admin.ConsoleMessage( "Loaded Client File: admin/commands/" .. gamemode .. "/" .. file )

				else

					include( "admin/commands/" .. gamemode .. "/" .. file )

				end

			elseif string.StartWith( file, "sh_" ) then

				if ( SERVER ) then

					AddCSLuaFile( "admin/commands/" .. gamemode .. "/" .. file )
					include( "admin/commands/" .. gamemode .. "/" .. file )

					Admin.ConsoleMessage( "Loaded Shared File: admin/commands/" .. gamemode .. "/" .. file )

				else

					include( "admin/commands/" .. gamemode .. "/" .. file )

				end

			end

		end

	end

end )

for _, file in ipairs( file.Find( "admin/commands/default/*.lua", "LUA" ) ) do

	if string.StartWith( file, "sv_" ) then

		if ( SERVER ) then

			include( "admin/commands/default/" .. file )

			Admin.ConsoleMessage( "Loaded Server File: admin/commands/default/" .. file )

		end

	elseif string.StartWith( file, "cl_" ) then

		if ( SERVER ) then

			AddCSLuaFile( "admin/commands/default/" .. file )

			Admin.ConsoleMessage( "Loaded Client File: admin/commands/default/" .. file )


		else

			include( "admin/commands/default/" .. file )

		end

	elseif string.StartWith( file, "sh_" ) then

		if ( SERVER ) then

			AddCSLuaFile( "admin/commands/default/" .. file )
			include( "admin/commands/default/" .. file )

			Admin.ConsoleMessage( "Loaded Shared File: admin/commands/default/" .. file )

		else

			include( "admin/commands/default/" .. file )

		end

	end

end

local files, directories = file.Find( "admin/modules/*", "LUA" )

for _, directory_name in ipairs( directories ) do

	for _, file in pairs( file.Find( "admin/modules/" .. directory_name .. "/*.lua", "LUA" ) ) do

		if string.StartWith( file, "sh_" ) then

			if ( SERVER ) then

				AddCSLuaFile( "admin/modules/" .. directory_name .. "/" .. file )
				include( "admin/modules/" .. directory_name .. "/" .. file )

				Admin.ConsoleMessage( "Loaded Module: " .. directory_name .." -> File: admin/modules/" .. directory_name .. "/" .. file )

			else

				include( "admin/modules/" .. directory_name .. "/" .. file )

			end

		elseif string.StartWith( file, "sv_" ) then

			if ( SERVER ) then

				include( "admin/modules/" .. directory_name .. "/" .. file )

				Admin.ConsoleMessage( "Loaded Module: " .. directory_name .." -> File: admin/modules/" .. directory_name .. "/" .. file )

			end

		elseif string.StartWith( file, "cl_" ) then

			if ( SERVER ) then

				AddCSLuaFile( "admin/modules/" .. directory_name .. "/" .. file )

				Admin.ConsoleMessage( "Loaded Module: " .. directory_name .." -> File: admin/modules/" .. directory_name .. "/" .. file )


			else

				include( "admin/modules/" .. directory_name .. "/" .. file )

			end

		end

	end

end