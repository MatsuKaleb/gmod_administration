-- Set Health
Admin.Command.Health = Admin.Command.Health || {}
Admin.Command.Health.Title = "Health"
Admin.Command.Health.Desc = "Sets the health of a player"
Admin.Command.Health.Command = "health"
Admin.Command.Health.Access = "mod"

function Admin.Command.Health:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.Health.Access ) then

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
Admin.Command.Armor = Admin.Command.Armor || {}
Admin.Command.Armor.Title = "Armor"
Admin.Command.Armor.Desc = "Sets the armor of a player"
Admin.Command.Armor.Command = "armor"
Admin.Command.Armor.Access = "mod"

function Admin.Command.Armor:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.Armor.Access ) then

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
Admin.Command.GodMode = Admin.Command.GodMode || {}
Admin.Command.GodMode.Title = "GodMode"
Admin.Command.GodMode.Desc = "Enables/disables godmode on a player."
Admin.Command.GodMode.Command = "god"
Admin.Command.GodMode.Access = "mod"

function Admin.Command.GodMode:Function( caller, args )

	--if !caller:IsUserGroup( Admin.Command.GodMode.Access ) then

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

-- NoClip
Admin.Command.NoClip = Admin.Command.NoClip || {}
Admin.Command.NoClip.Title = "NoClip"
Admin.Command.NoClip.Desc = "Enables/disables noclip."
Admin.Command.NoClip.Command = "noclip"
Admin.Command.NoClip.Access = "admin"

function Admin.Command.NoClip:Function( caller )

	--if !caller:IsUserGroup( Admin.Command.NoClip.Access ) then

		--caller:SendMessage( { Admin.Config.Colors.NotAllowed, "You do not have access" } )

		--return

	--end

	if caller:GetMoveType() == MOVETYPE_WALK then

		caller:SetMoveType( MOVETYPE_NOCLIP )

	else

		caller:SetMoveType( MOVETYPE_WALK )

	end

	Admin:SendMessageAll( { Admin.Config.Colors.Caller, caller:Nick(), Admin.Config.Colors.Main, ( caller:GetMoveType() == MOVETYPE_NOCLIP ) && " enabled " or " disabled ", "noclip" } )

end