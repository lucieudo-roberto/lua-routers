


function send(file_url)

    if file_url ~= nil and #file_url  > 0 then
        file_data = io.open(file_url,'rb')
    end 
    
    return nil
end
 
return send

--[[
 HTTP/1.1 200 OK
Date: Fri, 23 Sep 2023 12:00:00 GMT
Server: lua-routers/1.0
Content-Type: text/html; charset=utf-8
Content-Length: 1234

<!DOCTYPE html>
<html>
<head>
    <title>Exemplo</title>
</head>
<body>
    <h1>Este é um exemplo de página HTML</h1>
    <p>Olá, mundo!</p>
</body>
</html>

]]