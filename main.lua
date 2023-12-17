
local router = require 'lua-routers'

local app = router:new('127.0.0.1',3000)

local valid_user = function(req,res)
    user_name = res.json['user_name']
    user_pass = res.json['user_pass']
    user_rawd = res.body -- string
    user_args = res.args -- table 

    if user_name == 'lroberto' and user_pass == '123' then
        print('senha e usuário corretos ')
    end

    req:send('200 - its ok')
    req:close()
end

-- this router not exists
app:public('/public')  -- directorio público,
app:post('/admin/v2/login',valid_user)
app:run()