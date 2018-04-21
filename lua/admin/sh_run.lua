Admin.ConsoleMessage( "Loaded Shared Side" )

for _, file in ipairs( file.Find( "admin/shared/*.lua", "LUA" ) ) do

	if ( SERVER ) then

		AddCSLuaFile( "admin/shared/" .. file )
		include( "admin/shared/" .. file )

		Admin.ConsoleMessage( "Loaded Shared File: admin/shared/" .. file )

	else

		include( "admin/shared/" .. file )

	end

end

local gamemode = Admin.Config.Gamemode

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