-- Goto
Admin.Command.Goto = Admin.Command.Goto || {}
Admin.Command.Goto.Title = "Goto"
Admin.Command.Goto.Desc = "Teleports to a player."
Admin.Command.Goto.Command = "goto"
Admin.Command.Goto.Access = "admin"

function Admin.Command.Goto:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.Goto.Access ) then

		--caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You do not have access" } )

		--return

	--end

	local targets = Admin:FindPlayer( args, caller, true )

	if !targets || #targets < 1 then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "No valid players specified" } )

	end

	local target_pos = targets[ 1 ]:GetPos()

	caller:SetMoveType( MOVETYPE_NOCLIP )
	caller:SetPos( target_pos )

	timer.Simple( 3, function()

		caller:SetMoveType( MOVETYPE_WALK )

	end )

	Admin:SendMessageAll( { Admin.Config.Colors.Caller, caller:Nick(), Admin.Config.Colors.Main, " teleported to ", Admin.Config.Colors.Target, targets[ 1 ]:Nick() } )

end

-- Bring
Admin.Command.Bring = Admin.Command.Bring || {}
Admin.Command.Bring.Title = "Bring"
Admin.Command.Bring.Desc = "Brings a player."
Admin.Command.Bring.Command = "bring"
Admin.Command.Bring.Access = "admin"

function Admin.Command.Bring:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.Bring.Access ) then

		--caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You do not have access" } )

		--return

	--end

	local targets = Admin:FindPlayer( args, caller, true )

	if !targets || #targets < 1 then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "No valid players specified" } )

	end

	local caller_pos = caller:GetPos()

	caller:SetMoveType( MOVETYPE_NOCLIP )
	targets[ 1 ]:SetPos( caller_pos )

	timer.Simple( 3, function()

		caller:SetMoveType( MOVETYPE_WALK )

	end )

	Admin:SendMessageAll( { Admin.Config.Colors.Caller, caller:Nick(), Admin.Config.Colors.Main, " brought ", Admin.Config.Colors.Target, targets[ 1 ]:Nick() } )

end