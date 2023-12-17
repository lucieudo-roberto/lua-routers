

local sock = require 'socket'
local http_parser = require('libs/http-parser')

local Router = {}

function Router:new(ip,port)
	local _data_ = {}
    setmetatable(_data_, self)
	self.__index = self
	_data_.tcp = sock.tcp()
	_data_.get_endpoints = {}
	_data_.pos_endpoints = {}
	_data_.ip = ip
	_data_.pt = port
	_data_.public_dir = '../public/'
	return _data_
end

function Router:get(endpoint,callback)
	self.get_endpoints[endpoint] = callback
end

function Router:post(endpoint,callback)
	self.pos_endpoints[endpoint] = callback
end


function Router:run()
	if self.tcp:bind(self.ip,self.pt) ~= nil and self.tcp:listen() ~= nil then
		-- print('app run on '..self.ip..':'..self.pt)
			
		while 1 do 
			local client_socket, errors = self.tcp:accept()
			http_table = http_parser(client_socket)

			if http_table.method == 'GET' then
				if self.get_endpoints[http_table.router] ~= nil then
					-- endpoint implemented by user
					print('router: ',http_table.router)

				else 
					print('router invalid')
					client_socket:send('303')
					client_socket:close()
				end
			end
			
			if http_table.method == 'POST' then
				if self.pos_endpoints[http_table.router] ~= nil then
					self.pos_endpoints[http_table.router](client_socket,http_table)
				else
					print('router invalid')
					client_socket:send('303')
					client_socket:close()
				end
			end
		end
	end

	self.tcp:close()
end 


return Router