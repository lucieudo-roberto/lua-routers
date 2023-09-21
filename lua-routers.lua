

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

function Router:run()
	if self.tcp:bind(self.ip,self.pt) ~= nil then
	if self.tcp:listen() ~= nil then
	
		print('app run on '..self.ip..':'..self.pt)
		while 1 do 
		    print('waiting..')
			tcp_reqs = self.tcp:accept()
			while 1 do
				tcp_data = tcp_reqs:receive(1)
				print(tcp_data)
			end
		end
	end
	end
end 

local app = Router:new('127.0.0.1',3000)

app:get('/root',function(response) 
	print(response)
end)

app:run()
