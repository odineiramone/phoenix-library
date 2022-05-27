# Documentação da API

Caso prefira, importe o arquivo [`phoenix_library_insomnia.json`](phoenix_library_insomnia.json) no [Insomnia](https://insomnia.rest/) para requisitar a API.

As respostas foram padronizadas seguindo a especificação [JSend](https://github.com/omniti-labs/jsend).

# Endpoints

## Busca

- GET `/api/search`
  - Retorna lista com livros encontrados na busca
  - Aceita os seguintes parâmetros por query string: `title` e `authorship`
  - Exemplo de corpo de resposta:
    - Sucesso
      - Quando a busca encontra livros
      ```json
      {
        "data": {
          "books": [
            {
              "authorship": [
                "William Golding"
              ],
              "cover_photo": null,
              "id": "59af82ae-de3f-4222-b535-362a050fca6d",
              "inserted_at": "2022-05-27T00:28:43",
              "publisher": "Alfaguara",
              "title": "O Senhor das Moscas",
              "updated_at": "2022-05-27T00:28:43"
            },
            {
              "authorship": [
                "J. R. R. Tolkien"
              ],
              "cover_photo": null,
              "id": "00368f3d-19b6-49c2-9f18-7d1a4fefb2d0",
              "inserted_at": "2022-05-27T00:28:43",
              "publisher": "Martins Fontes",
              "title": "O Senhor dos Anéis: A Sociedade do Anel",
              "updated_at": "2022-05-27T00:28:43"
            }
          ]
        },
        "status": "success"
      }
      ```

      - Quando a busca não encontra livros:
      ```json
      {
        "data": {
          "books": []
        },
        "status": "success"
      }
      ```

    - Falha:
    ```json
    {
      "data": {
        "book": "No search parameters!"
      },
      "status": "fail"
    }
    ```

## Books


- GET `/api/books`
  - Lista todos os livros cadastrados no sistema.
  - Exemplo de corpo da resposta:
  ```json
  {
     "data":{
        "books":[
           {
              "authorship":[
                 "Douglas Adamns"
              ],
              "cover_photo":"https://i.imgur.com/0FvAVYu.png",
              "id":"fa79b315-5bbb-4e50-8a37-0866448276ea",
              "inserted_at":"2022-05-16T02:33:15",
              "publisher":"Editora Arqueiro",
              "title":"O Guia do Mochileiro das Galáxias",
              "updated_at":"2022-05-16T02:42:07"
           }
        ]
     },
     "status":"success"
  }
  ```

- POST `/api/books`
  - Cria um novo livro no sistema
  - Exemplo de corpo da requisição:
  ```json
  {
    "title": "O Guia do Mochileiro das Galáxias",
    "publisher": "Editora Arqueiro",
    "authorship": ["Douglas Adamns"],
    "cover_photo": "https://i.imgur.com/0FvAVYu.png",
  }
  ```
    - Campos obrigatórios: `title (string)`, `publisher (string)`, `authorship (lista)`.
    - Campos opcionais: `cover_photo (string)`.

  - Exemplo de corpo da resposta
    - sucesso:
      ```json
      {
        "data": {
          "book": {
            "authorship": [
              "Douglas Adamns"
            ],
            "cover_photo": "https://i.imgur.com/0FvAVYu.png"

            ,
            "id": "fa79b315-5bbb-4e50-8a37-0866448276ea",
            "inserted_at": "2022-05-16T02:33:15",
            "publisher": "Editora Arqueiro",
            "title": "O Guia do Mochileiro das Galáxias",
            "updated_at": "2022-05-16T02:33:15"
          }
        },
        "status": "success"
      }
      ```

    - falha:
    ```json
    {
      "status": "fail",
      "data": {
        "authorship": ["can't be blank"],
        "publisher": ["can't be blank"],
        "title": ["can't be blank"]
      }
    }
    ```

- GET `/api/books/:id`
  - Detalha um livro cadastrado no sistema.
  - Exemplo de corpo da resposta
    - sucesso:
    ```json
    {
      "data": {
        "book": {
          "authorship": [
            "Douglas Adamns"
          ],
          "cover_photo": "https://i.imgur.com/0FvAVYu.png",
          "id": "fa79b315-5bbb-4e50-8a37-0866448276ea",
          "inserted_at": "2022-05-16T02:33:15",
          "publisher": "Editora Arqueiro",
          "title": "O Guia do Mochileiro das Galáxias",
          "updated_at": "2022-05-16T02:42:07"
        }
      },
      "status": "success"
    }
  ```

  - falha:
  ```json
  {
    "data": {
      "book": "Not found!"
    },
    "status": "fail"
  }
  ```

- PATCH `/api/books/:id`
  - Atualiza os dados de um livro cadastrado no sistema.
  - Exemplo de corpo da requisição:
  ```json
  {
    "cover_photo": "https://i.imgur.com/0FvAVYu.png",
  }
  ```

  - Exemplo de corpo de resposta
    - sucesso:
    ```json
    {
      "data": {
        "book": {
          "authorship": [
            "Douglas Adamns"
          ],
          "cover_photo": "https://i.imgur.com/0FvAVYu.png",
          "id": "fa79b315-5bbb-4e50-8a37-0866448276ea",
          "inserted_at": "2022-05-16T02:33:15",
          "publisher": "Editora Arqueiro",
          "title": "O Guia do Mochileiro das Galáxias",
          "updated_at": "2022-05-16T02:42:07"
        }
      },
      "status": "success"
    }
    ```

    - falha:
    ```json
    {
      "status": "fail",
      "data": {
        "title": ["can't be blank"]
      }
    }
    ```

    ```json
    {
      "status": "fail",
      "data": {
        "book": "Not found!"
      }
    }
    ```

- DELETE `/api/books/:id`
  - Atualiza os dados de um livro cadastrado no sistema.
  - Exemplo de corpo de resposta
    - sucesso:
    ```json
    {
      "data": {
        "message": "Book deleted!"
      },
      "status": "success"
    }
    ```

    - falha: 
    ```json
    {
      "status": "fail",
      "data": {
        "book": "Not found!"
      }
    }
    ```
