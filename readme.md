
# Router Lua

![Lua](https://img.shields.io/badge/language-Lua-blue)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

Router Lua é um simples roteador de rotas em Lua, projetado para facilitar a manipulação de endpoints em camadas, com suporte para GET e POST. A biblioteca inclui uma funcionalidade de análise HTTP (`parseHttp`) para simplificar o processamento de solicitações HTTP.

## Características

- **Designer em Camadas:** As rotas são empilhadas, e conforme as rotas são acessadas, o callback correspondente é executado.
  
- **Suporte para GET e POST:** Três stacks principais estão disponíveis: `get`, `post` e `public`. Nomes expressivos facilitam o entendimento do propósito de cada stack.

- **Análise HTTP:** A biblioteca `parseHttp` oferece uma funcionalidade de análise HTTP, permitindo a extração de informações importantes das solicitações, como método, rota, versão, cabeçalhos e corpo.

## Como Usar

### Instalação

Certifique-se de ter Lua e as dependências necessárias instaladas.

```bash
git clone https://github.com/seu-usuario/router-lua.git
cd router-lua
```

### Exemplo de Uso

```lua
-- Exemplo de utilização do Router
local Router = require('router')
local myRouter = Router:new('127.0.0.1', 8080)

myRouter:get('/hello', function(req,resp)
    req:send('Hello, World!')
    req:close()
end)

myRouter:run()
```

## Progresso

- **Implementado:** Suporte básico para roteamento GET e POST.
  
- **Em Andamento:** Desenvolvimento da biblioteca `parseHttp`. Algumas opções de segurança e um parser para endpoints estão em processo.

## Contribuindo

Contribuições são bem-vindas! Se você encontrar problemas ou desejar melhorar o projeto, sinta-se à vontade para abrir uma [issue](https://github.com/seu-usuario/router-lua/issues) ou enviar um pull request.

## Licença

Este projeto é licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT) - veja o arquivo [LICENSE](LICENSE) para detalhes.

--- 

Lembre-se de substituir `'127.0.0.1'` e `8080` com o IP e porta desejados para a execução do seu aplicativo. Personalize conforme necessário.
