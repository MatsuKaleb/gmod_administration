m_Entity = FindMetaTable( "Entity" )
m_Player = FindMetaTable( "Player" )

Admin.Ranks = Admin.Ranks || {}
Admin.Ranks.user = nil
Admin.Ranks.mod = "user"
Admin.Ranks.admin = "mod"
Admin.Ranks.superadmin = "admin"
Admin.Ranks.owner = "superadmin"

Admin.Flags = Admin.Flags || {}
Admin.Flags.VIP = 1

Admin.Command = Admin.Command || {}

function m_Player:GetUserGroup()

	return self:GetNWString( "rank" ) || "user"

end

function m_Player:IsUserGroup( g, strict )

	local group = self:GetUserGroup()

	if strict then return group == g end
	if g == "user" then return true end

	while Admin.Ranks[ group ] do

		if group == g then return true end
		group = Admin.Ranks[ group ]

	end

	return false

end