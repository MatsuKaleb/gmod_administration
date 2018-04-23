net.Receive( "Admin_Send_Message_To_Client", function()

	local args = net.ReadTable()
	chat.AddText( Color( 255, 255, 255 ), unpack( unpack( args ) ) )

end )