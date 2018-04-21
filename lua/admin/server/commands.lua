function Admin:GetChatCommand( msg )

	return ( string.match( msg, "%w+" ) or "" ):lower()

end

function Admin:GetChatArgs( msg )

	local args = {}
	local first = true

	for match in string.gmatch( msg, "[^ ]+" ) do

		if ( first ) then first = false else

			table.insert( args, match )

		end

	end

	return args

end

function Admin:GetConCommandArgs( allargs )

	local newargs = {}

	for i = 2, #allargs do

		table.insert( newargs, allargs[i] )

	end

	return newargs

end

function Admin:NameMatch( ply, str )

	if str == "*" then

		return true

	elseif str == "@" && ply:IsAdmin() then

		return true

	elseif str == "!@" && !ply:IsAdmin() then

		return true

	elseif string.match( str, "STEAM_[0-5]:[0-9]:[0-9]+" ) then

		return ply:SteamID() == str

	elseif string.Left( str, 1 ) == "\"" && string.Right( str, 1 ) == "\"" then

		return ply:Nick() == string.sub( str, 2, #str - 1 )

	else

		return string.lower( ply:Nick() ) == string.lower( str ) || string.find( string.lower( ply:Nick() ), string.lower( str ), nil, true )

	end

end

function Admin:FindPlayer( name, def, nonum, noimmunity )

	local matches = {}

	if ( !name || #name == 0 ) then

		matches[1] = def

	else

		if ( type( name ) != "table" ) then name = { name } end

		local name2 = table.Copy( name )

		if ( nonum ) then

			if ( #name2 > 1 && tonumber( name2[ #name2 ] ) ) then table.remove( name2, #name2 ) end

		end

		for _, ply in ipairs( player.GetAll() ) do

			for _, pm in ipairs( name2 ) do

				if Admin:NameMatch( ply, pm ) && !table.HasValue( matches, ply ) then

					table.insert( matches, ply )

				end

			end

		end

	end

	return matches

end

function Admin:PlayerListForCommands( tbl )

	local names = ""

	if #tbl <= 1 then

		return tbl[ 1 ]:Nick()

	end

	for k, v in pairs( tbl ) do

		if k < ( #tbl - 1 ) then

			names = names .. v:Nick() .. ", "

		elseif k == ( #tbl - 1 ) then

			names = names .. v:Nick() .. " and "

		else

			names = names .. v:Nick()

		end

	end

	return names

end

hook.Add( "PlayerSay", "AdminChatCommands", function( ply, text )

	if string.StartWith( text, Admin.Config.ChatCommandPrefix ) then

		local _cmd = Admin:GetChatCommand( text )
		local args = Admin:GetChatArgs( text )

		if _cmd && #_cmd > 0 then

			for _, cmd in pairs( Admin.Command ) do

				if cmd.Command == _cmd then

					if !args then

						caller:SendMessage( { Admin.Config.Colors.NotAllowed, v.Desc } )

					end

					res, ret = pcall( cmd.Function, cmd, ply, args )

					if ( !res ) then

						print( ret )

					end

				end

			end

		end

		return ""

	end

end )

function Admin:ConCommand( ply, _command, command_args )

	local command = command_args[ 1 ]
	local args = Admin:GetConCommandArgs( command_args )

	for _, cmd in pairs( Admin.Command ) do

		if cmd.Command == command then

			if !args then

				caller:SendMessage( { Admin.Config.Colors.NotAllowed, v.Desc } )

			end

			res, ret = pcall( cmd.Function, cmd, ply, args )

			if ( !res ) then

				print( ret )

			end

		end

	end

end

concommand.Add( Admin.Config.ConCommand, function( ply, command, args )

	Admin:ConCommand( ply, command, args )

end )