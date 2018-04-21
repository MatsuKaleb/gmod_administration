-- Freeze
Admin.Command.Freeze = Admin.Command.Freeze || {}
Admin.Command.Freeze.Title = "Freeze"
Admin.Command.Freeze.Desc = "freezes/unfreezes a player."
Admin.Command.Freeze.Command = "freeze"
Admin.Command.Freeze.Access = "mod"

function Admin.Command.Freeze:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.Freeze.Access ) then

		--caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You do not have access" } )

		--return

	--end

	local targets = Admin:FindPlayer( args, caller, true )
	local freeze_arg = math.Clamp( tonumber( args[ #args ] ), 0, 1 )
	local freeze_enabled = tobool( freeze_arg )

	if !targets || #targets < 1 then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "No valid players specified" } )

	end

	if !freeze_arg then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You did not specify a valid freeze value 0|1" } )

	end

	for k, v in pairs( targets ) do

		if freeze_enabled then

			v:Lock()
			v:Freeze( true )
			v:SetMaterial( "models/props_c17/metalladder002" )

		else

			v:UnLock()
			v:Freeze( false )
			v:SetMaterial( "" )

		end

	end

	Admin:SendMessageAll( { Admin.Config.Colors.Caller, caller:Nick(), Admin.Config.Colors.Types[ type( args[ #args ] ) ], freeze_enabled && " froze " || " unfroze ", Admin.Config.Colors.Target, #targets > 1 && Admin:PlayerListForCommands( targets ) || targets[ 1 ]:Nick() } )

end