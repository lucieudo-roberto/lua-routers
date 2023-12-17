
local cjson = require 'cjson'

function parse(client_socket)

	local request = { 
		method = '', 
		router = '', 
		version= '', 
		headers= {},
		text = '',
		json = {},
		args = {}
	}
	
	local _head = {}
	local _data = client_socket:receive('*l') -- read first line from tcp payload
	
	if _data ~= nil then 
		for _term in _data:gmatch('[%a%d%p]+') do
			if _term ~= nil then
				table.insert(_head,_term)
			end
		end
	end
	
	if #_head == 3 then
		request.method  = _head[1]
		request.router  = _head[2]
		request.version = _head[3] 
	end
	
	while true do
	-- parsing http headers after first line
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
	
	local payload = client_socket:receive(request.headers.content_length)
	request.text = payload
	
	if payload ~= nil and #payload > 0 then
		if request.method == 'POST' then	
			if request.headers.content_type == 'application/json' then
				-- json post decode 
				request.json = cjson.decode(payload)
			end
			-- add others file type here for post method
			-- if request.headers.content_type == 'application/xml' then 
			-- end
		end

	  --if request.method == 'GET' then end	
	  --if request.method == 'PUT' then end	
	  --if request.method == 'PATCH' then end	
	  --if request.method == 'DELETE' then end	

	end
	
	return request
end
 
return parse