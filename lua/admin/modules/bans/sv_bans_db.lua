function Admin.Bans:GetInfo( sid, callback, ... )

	local q = {}
	q.sql = "SELECT * FROM " .. Admin.DB.Prefix .. "bans WHERE steamid = " .. Admin.DB:Escape( sid ) .. " AND !removed AND ( time + length > " .. Admin.DB:Escape( os.time() ) .. " OR length = 0 );"
	q.callback = callback
	q.vargs = { ... }

	Admin.DB:RunPreparedQuery( q )

end

function Admin.Bans:GetInfoByID( banid, callback, ... )

	Admin.DB:GetRow( "bans", "WHERE banid = " .. Admin.DB:Escape( banid ), callback, ... )

end

function Admin.Bans:Add( steamid, name, adminid, aname, reason, length )

	Admin.DB:Insert( "bans", { '', steamid, name, adminid, aname, reason, os.time(), length, 0, '' } )

end

function Admin.Bans:Remove( banid )

	Admin.DB:SetField( "bans", "WHERE banid = " .. Admin.DB:Escape( banid ), "removed", 1 )

end

function Admin.Bans:Edit( banid, reason, length ) -- bite me

	Admin.DB:SetField( "bans", "WHERE banid = " .. Admin.DB:Escape( banid ), "reason", reason )
	Admin.DB:SetField( "bans", "WHERE banid = " .. Admin.DB:Escape( banid ), "length", length )

end