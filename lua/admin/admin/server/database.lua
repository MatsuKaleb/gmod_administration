require( "mysqloo" )

Admin.DB = Admin.DB || {}

Admin.DB.QueryQueue = {}
Admin.DB.Host = Admin.Config.DB_Host
Admin.DB.User = Admin.Config.DB_User
Admin.DB.Pass = Admin.Config.DB_Pass
Admin.DB.Name = Admin.Config.DB_Name
Admin.DB.Port = Admin.Config.DB_Port

function Admin.DB:Init()

	Admin.ConsoleMessage( "MySQL -> Connecting to database.." )
	Admin.DB.MySQL, db = mysqloo.connect( Admin.DB.Host, Admin.DB.User, Admin.DB.Pass, Admin.DB.Name, Admin.DB.Port )

	if !db then

		Admin.ConsoleMessage( "MySQL -> Connection Failed" )

	else

		Admin.ConsoleMessage( "MySQL -> Connection Successful \n" .. Admin.DB.MySQL:serverInfo() )

	end

end

function Admin.DB:Escape( str )

	return "\"" .. Admin.DB.MySQL:escape( tostring( str ) ) .. "\""

end

function Admin.DB:RunPreparedQuery( q )

	q.callback = q.callback || function() end

	Admin.DB.MySQL:query( q.sql, function( data )

		if !data || !data[ 1 ] then

			Admin.ConsoleMessage( "MySQL -> nil data returned!!!!!" )

			return

		end

		if data[ 1 ].error then

			Admin.ConsoleMessage( "MySQL -> Query Failed!\nQuery: " .. q.sql .. "\nError" .. data[ 1 ].error )

			return

		end

		q.callback( data[ 1 ].data, unpack( q.vargs || {} ) )

	end )

end

function Admin.DB:QuickQuery( sql )

	local q = {}
	q.sql = sql
	Admin.DB:RunPreparedQuery( q )

end

function Admin.DB:GetRow( sqltable, conditions, callback, ... )

	local query = {}
	query.sql = "SELECT * FROM " .. sqltable .. " " .. conditions .. ";"

	function query.callback( data, ... )

		if !callback then return end
		callback( data && data[ 1 ], ... )

	end

	query.vargs = { ... }

	Admin.DB:RunPreparedQuery( query )

end

function Admin.DB:GetField( sqltable, column, conditions, callback, ... )

	local query = {}
	query.sql = "SELECT " .. column .. " FROM " .. sqltable .. " " .. conditions .. ";"

	function query.callback( data, ... )

		if !callback then return end
		callback( data && data[ 1 ] && data[ 1 ][ column ], ... )

	end

	query.vargs = { ... }

	Admin.DB:RunPreparedQuery( query )

end

function Admin.DB:Insert( sqltable, values, callback, ... )

	local query = {}
	query.sql = "INSERT INTO " .. sqltable .. " VALUES( "

	for k, v in ipairs( values ) do

		query.sql = query.sql .. Admin.DB:Escape( v ) .. ( k == #values && " );" || ", " )

	end

	function query.callback( data, ... )

		if !callback then return end
		callback( data, ... )

	end

	query.vargs = { ... }

	Admin.DB:RunPreparedQuery( query )

end

function Admin.DB:SetField( sqltable, conditions, field, value, callback, ... )

	local query = {}
	query.sql = "UPDATE " .. sqltable .. " SET " .. field .. " = " .. Admin.DB:Escape( value ) .. " " .. conditions .. ";"

	function query.callback( data, ... )

		if !callback then return end
		callback( data, ... )

	end

	query.vargs = { ... }

	Admin.DB:RunPreparedQuery( query )

end

function Admin.DB:Count( sqltable, conditions, callback, ... )

	local query = {}
	query.sql = "SELECT COUNT(*) FROM " .. sqltable .. " " .. conditions .. ";"

	function query.callback( data, ... )

		if !callback then return end
		callback( data && data[ 1 ] && tonumber( data[ 1 ][ "COUNT(*)" ] ) || 0, ... )

	end

	query.vargs = { ... }

	Admin.DB:RunPreparedQuery( query )

end