
function parse(client_socket)

	local request = { 
		method = '', 
		router = '', 
		version= '', 
		headers= {},
		bodyraw= ''
	}
	
	local _head = {}
	local _data = client_socket:receive('*l')
	if _data ~= nil then 
		for _term in _data:gmatch('[%a%d%p]+') do
			-- this get first line from http payload
			if _term ~= nil then
				table.insert(_head,_term)
			end
		end
	end
	-- normalize data from first line  in lua table
	if #_head == 3 then
		if  _head[1] == 'POST' or _head[1] == 'GET' then  request.method = _head[1] end
		if #_head[2] > 0 then  request.router  = _head[2] end -- use this if for sanatize url/endpoint
		if #_head[3] > 0 then  request.version = _head[3] end 
	end
	
	while true do
		-- get all key:value form headers http data
		local payload = client_socket:receive('*l')

		if payload ~= nil and #payload > 0 then  
			local eof = string.find(payload,':');
			
			if eof ~= nil then
				local key = string.sub(payload,1,eof-1):lower():gsub('-','_')
				local val = string.sub(payload,eof+2,-1)
				request.headers[key] = val
			end
		else break end
	end
	
	-- get post payload and normalize in to lua table
	if request.method == 'POST' then
		local payload = client_socket:receive(request.headers.content_length)
		if payload ~= nil then  request.bodyraw = payload end
	end
	
	return request
end
 
return parse