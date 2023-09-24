

local sock = require 'socket'
local http_parser = require('libs/http-parser')

local Router = {}

function Router:new(ip,port)
	local _data_ = {}
    setmetatable(_data_, self)
	self.__index = self
	_data_.tcp = sock.tcp()
	_data_.get_endpoinst = {}
	_data_.pos_endpoints = {}
	_data_.ip = ip
	_data_.pt = port
	_data_.public_dir = '../public/'
	return _data_
end

function Router:get(endpoint,callback)
	self.get_endpoinst[endpoint] = callback
	return '<router on stack>'
end

function Router:post(endpoint,callback)
	self.pos_endpoinst[endpoint] = callback
	return '<router on stack>'
end


function Router:run()
	if self.tcp:bind(self.ip,self.pt) ~= nil and self.tcp:listen() ~= nil then
		print('app run on '..self.ip..':'..self.pt)
			
		while 1 do 
		    print('waiting..')
			local client_socket, errors = self.tcp:accept()
			http_table = http_parser(client_socket)

			if http_table.method == 'GET' then
				if self.get_endpoinst[http_table.router] ~= nil then
					-- endpoint implemented by user
				else 
					client_socket:send('HTTP/1.1 404 Not Found\nContent-Type: text/html\n\n<html><body><h1>404 - page not found</h1></body></html>')
					client_socket:close()
				end
				print(http_table.router)
			end
			
			if http_table.method == 'POST' then
				print(http_table.bodyraw) 
				client_socket:send('<ok>')
				client_socket:close()
			end
		end
	end

	self.tcp:close()
end 


return Router