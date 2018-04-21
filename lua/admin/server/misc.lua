util.AddNetworkString( "Admin_Send_Message_To_Client" )

function table.pack( ... ) -- https://github.com/stevedonovan/Penlight/blob/master/lua/pl/compat.lua#L134

    return { n = select('#',...); ... }

end

function Admin:SendMessageAll( msg )

	net.Start( "Admin_Send_Message_To_Client" )
	net.WriteTable( table.pack( msg ) )

	for k, v in pairs( player.GetAll() ) do

		net.Send( v )

	end

end

function Admin:SendMessageAllButOne( skip_ply, msg )

	net.Start( "Admin_Send_Message_To_Client" )
	net.WriteTable( table.pack( msg ) )

	for k, v in pairs( player.GetAll() ) do

		if skip_ply == v then continue end

		net.Send( v )

	end

end

function m_Player:SendMessage( msg )

	net.Start( "Admin_Send_Message_To_Client" )
	net.WriteTable( table.pack( msg ) )
	net.Send( self )

end