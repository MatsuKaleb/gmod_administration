function Admin.Warnings:DBAdd( sid, name, reason, asid, arpname )

	Admin.DB:Insert( "warnings", { '', sid, name or "unknown", reason, os.time(), asid or "unknown", arpname or "unknown", '', '' } )

end

function Admin.Warnings:Remove( warningid )

	Admin.DB:QuickQuery( "DELETE FROM " .. Admin.DB.Prefix .. "warnings WHERE warningid = " .. Admin.DB:Escape( warningid ) .. ";" )

end

function Admin.Warnings:Edit( warningid, reason )

	Admin.DB:SetField( "warnings", "WHERE warningid = " .. Admin.DB:Escape( warningid ), "reason", Admin.DB:Escape( reason or "unknown" ) )
	Admin.DB:SetField( "warnings", "WHERE warningid = " .. Admin.DB:Escape( warningid ), "edittime", Admin.DB:Escape( os.time() ) )

end

function Admin.Warnings:Process( data, warningid, callback )

	if not data then callback() return end
	callback( warningid, data.steamid, data.name, data.reason, data.time, data.asid, data.arpname, data.edittime )

end

function Admin.Warnings:GetAll( steamid, callback )

	local q = {}
	q.sql = "SELECT * FROM " .. Admin.DB.Prefix .. "warnings WHERE steamid = " .. Admin.DB:Escape( steamid ) .. " ORDER by warningid ASC;"
	q.callback = callback
	Admin.DB:RunPreparedQuery( q )

end

function Admin.Warnings:Count( steamid, callback )

	Admin.DB:Count( "warnings", "WHERE steamid = " .. Admin.DB:Escape( steamid ) .. ";", callback )

end

function Admin.Warnings:Add( ply, pname, pid, admin, aname, aid, reason )

	if !reason or #reason < 1 then

		Admin:SendMessageAll( { Admin.Config.Colors.NotAllowed, "Reason invalid or not specified!" } )

		return

	end

	Admin.Warnings:Count( pid, function( count )

		Admin.Warnings:DBAdd( pid, pname, reason, aid, aname )

		count = count + 1

		if count == 3 and IsValid( ply ) then

			SRH.Admin:ProcessCommand( admin, "kick", { ply:UserID(), "AutoKicked: 3 warnings (" .. reason .. ")" }, true )

		elseif count > 3 and count < 7 then

			if IsValid( ply ) then

				SRH.Admin:ProcessCommand( admin, "ban", { ply:UserID(), 60, "Auto-banned: " .. count .. " warnings (" .. reason .. ")" }, true )

			else

				SRH.Admin:ProcessCommand( admin, "banid", { pid, 60, "Auto-banned: " .. count .. " warnings (" .. reason .. ")" }, true )

			end

		elseif count > 6 and count < 10 then

			if IsValid( ply ) then

				SRH.Admin:ProcessCommand( admin, "ban", { ply:UserID(), 1440, "Auto-banned: " .. count .. " warnings (" .. reason .. ")" }, true )

			else

				SRH.Admin:ProcessCommand( admin, "banid", { pid, 1400, "Auto-banned: " .. count .. " warnings (" .. reason .. ")" }, true )

			end

		elseif count > 9 then

			if IsValid( ply ) then

				SRH.Admin:ProcessCommand( admin, "ban", { ply:UserID(), 0, "Auto-banned: " .. count .. " warnings (" .. reason .. ")" }, true )

			else

				SRH.Admin:ProcessCommand( admin, "banid", { pid, 0, "Auto-banned: " .. count .. " warnings (" .. reason .. ")" }, true )

			end

		end

	end )

	return true
end