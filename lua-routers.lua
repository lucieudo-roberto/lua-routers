

local sock = require 'socket'

local Router = {}

function Router:new(ip,port)
	local _data_ = {}
    setmetatable(_data_, self)
	self.__index = self
	_data_.tcp = sock.tcp()
	_data_.get_edpt = {} -- get endpoints
	_data_.get_cabk = {} -- get callbacks
	_data_.pot_edpt = {} -- post
	_data_.pot_cabk = {}
	_data_.ip = ip
	_data_.pt = port
	return _data_
end

function Router:get(endpoint,callback)
	self.get_edpt[#self.get_edpt+1] = endpoint
	self.get_cabk[#self.get_cabk+1] = callback
	return '<router on stack>'
end

function Router:post(endpoint,callback)
	self.pot_edpt[#self.pot_edpt+1] = endpoint
	self.pot_cabk[#self.pot_cabk+1] = callback
	return '<router on stack>'
end

function http_parse(client_socket)
	local ctrl = true
	local data = ''
	
	while ctrl do
		tmp = client_socket:receive('*ll')
		if tmp ~= nil and #tmp > 0 then  data = data..tmp else ctrl = false end
	end

	return data, client_socket
end

function Router:run()
	if self.tcp:bind(self.ip,self.pt) ~= nil and self.tcp:listen() ~= nil then
		print('app run on '..self.ip..':'..self.pt)
			
		while 1 do 
		    print('waiting..')
			local data, client_socket = http_parse(self.tcp:accept())
			print(data)
			
		end
	end
end 

local app = Router:new('127.0.0.1',3000)
app:run()
