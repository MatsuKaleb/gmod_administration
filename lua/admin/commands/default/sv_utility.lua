-- Set Health
Admin.Command.SetHealth = Admin.Command.SetHealth || {}
Admin.Command.SetHealth.Title = "SetHealth"
Admin.Command.SetHealth.Desc = "Sets the health of a player"
Admin.Command.SetHealth.Command = "health"
Admin.Command.SetHealth.Access = "mod"

function Admin.Command.SetHealth:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.SetHealth.Access ) then

		--caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You do not have access" } )

		--return

	--end

	local targets = Admin:FindPlayer( args, caller, true )
	local health = math.Clamp( tonumber( args[ #args ] ), 0, 200 ) || 100

	if !targets || #targets < 1 then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "No valid players specified" } )

	end

	if !health then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You did not specify a valid health amount 0|200" } )

	end

	for k, v in pairs( targets ) do

		v:SetHealth( health )

	end

	Admin:SendMessageAll( { Admin.Config.Colors.Caller, caller:Nick(), Admin.Config.Colors.Main, " has set the health of ", Admin.Config.Colors.Target, #targets > 1 && Admin:PlayerListForCommands( targets ) || targets[ 1 ]:Nick(), Admin.Config.Colors.Main, " to ", Admin.Config.Colors.Types[ type( args[ #args ] ) ], tostring( health ) } )

end

-- Set Armor
Admin.Command.SetArmor = Admin.Command.SetArmor || {}
Admin.Command.SetArmor.Title = "SetArmor"
Admin.Command.SetArmor.Desc = "Sets the armor of a player"
Admin.Command.SetArmor.Command = "armor"
Admin.Command.SetArmor.Access = "mod"

function Admin.Command.SetArmor:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.SetArmor.Access ) then

		--caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You do not have access" } )

		--return

	--end

	local targets = Admin:FindPlayer( args, caller, true )
	local armor = math.Clamp( tonumber( args[ #args ] ), 0, 100 ) || 100

	if !targets || #targets < 1 then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "No valid players specified" } )

	end

	if !armor then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You did not specify a valid armor amount 0|100" } )

	end

	for k, v in pairs( targets ) do

		v:SetArmor( armor )

	end

	Admin:SendMessageAll( { Admin.Config.Colors.Caller, caller:Nick(), Admin.Config.Colors.Main, " has set the armor of ", Admin.Config.Colors.Target, #targets > 1 && Admin:PlayerListForCommands( targets ) || targets[ 1 ]:Nick(), Admin.Config.Colors.Main, " to ", Admin.Config.Colors.Types[ type( args[ #args ] ) ], tostring( armor ) } )

end

-- Set God Mode
Admin.Command.SetGodMode = Admin.Command.SetGodMode || {}
Admin.Command.SetGodMode.Title = "SetGodMode"
Admin.Command.SetGodMode.Desc = "Enables/disables godmode on a player."
Admin.Command.SetGodMode.Command = "god"
Admin.Command.SetGodMode.Access = "mod"

function Admin.Command.SetGodMode:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.SetGodMode.Access ) then

		--caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You do not have access" } )

		--return

	--end

	local targets = Admin:FindPlayer( args, caller, true )
	local godmode_arg = math.Clamp( tonumber( args[ #args ] ), 0, 1 )
	local godmode_enabled = tobool( godmode_arg )

	if !targets || #targets < 1 then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "No valid players specified" } )

	end

	if !godmode_arg then

		caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You did not specify a valid godmode value 0|1" } )

	end

	for k, v in pairs( targets ) do

		if godmode_enabled then

			v:GodEnable()

		else

			v:GodDisable()

		end

	end

	Admin:SendMessageAll( { Admin.Config.Colors.Caller, caller:Nick(), Admin.Config.Colors.Types[ type( args[ #args ] ) ], godmode_enabled && " enabled" || " disabled", Admin.Config.Colors.Main, " godmode on ", Admin.Config.Colors.Target, #targets > 1 && Admin:PlayerListForCommands( targets ) || targets[ 1 ]:Nick() } )

end