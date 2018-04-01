Admin.Console = Admin.Console or {}
Admin.Console.Error = MsgN

setmetatable( Admin.Console, {

	__tostring = function( self )

		return self:Nick() .. " (" .. self:SteamID() .. ")"

	end

} )

function Admin.Console:IsUserGroup()

	return true

end

function Admin.Console:Nick()

	return "Console"

end

function Admin.Console:SteamID()

	return "STEAM_0:0:CONSOLE"

end

function Admin.Console:Alive()

	return true

end