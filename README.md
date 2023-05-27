# PhoenixLibrary

API de sistema de gerenciamento de biblioteca. Desafio de backend do [DevChallenge](https://www.devchallenge.com.br/challenges/5f0b43f5a5fec43156149043/details). Para saber como usar a API, veja os arquivos da pasta [`docs`.](https://github.com/odineiramone/phoenix-library/tree/main/docs)

## Feito com

  - Elixir 1.11.4 🧪
  - Erlang 23.3.4 👴
  - Phoenix 1.5.3 🐓
  - Postgres 13.3 🐘

## Como instalar

  - Instale as depencencias com `mix deps.get`.
  - Renomeie o arquivo `.env.sample` para `.env` e preencha as variáveis de acordo com seu ambiente de desenvolvimento.
  - Rode o comando `source .env` para usar as variáveis de ambiente na sessão atual do terminal.
  - Crie o banco de dados com `mix ecto.setup`.
  - Popule o banco de dados com `mix run priv/repo/seeds.exs`.
  - Inicie o servidor da aplicação com `mix phx.server`.

## Dicas úteis

  - Para acessar um console interativo com as entidades da sua aplicação em phoenix carregadas, use `iex -S mix`.
  - Para gerar a documentação dos módulos usando o `ex_docs`, rode o seguinte comando no console `mix docs` e siga as instruções da tela. Ou, se preferir, importe a coleção de requests `docs/phoenix_library_insomnia.json` no [Insomnia](https://insomnia.rest/).
