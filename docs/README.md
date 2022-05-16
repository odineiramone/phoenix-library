# Documentação da API

Caso prefira, importe o arquivo [`phoenix_library_insomnia.json`](phoenix_library_insomnia.json) no [Insomnia](https://insomnia.rest/) para requisitar a API.

# Endpoints
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
              "cover_photo_url":"https://i.imgur.com/0FvAVYu.png",
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

  - Exemplo de corpo da resposta:
  ```json
  {
    "data": {
      "book": {
        "authorship": [
          "Douglas Adamns"
        ],
        "cover_photo_url": "https://i.imgur.com/0FvAVYu.png"

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

- GET `/api/books/:id`
  - Detalha um livro cadastrado no sistema.
  - Exemplo de corpo da resposta:
  ```json
  {
    "data": {
      "book": {
        "authorship": [
          "Douglas Adamns"
        ],
        "cover_photo_url": "https://i.imgur.com/0FvAVYu.png",
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

- PATCH `/api/books/:id`
  - Atualiza os dados de um livro cadastrado no sistema.
  - Exemplo de corpo da requisição:
  ```json
  {
    "cover_photo": "https://i.imgur.com/0FvAVYu.png",
  }
  ```

  - Exemplo de corpo de resposta:
  ```json
  {
    "data": {
      "book": {
        "authorship": [
          "Douglas Adamns"
        ],
        "cover_photo_url": "https://i.imgur.com/0FvAVYu.png",
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

- DELETE `/api/books/:id`
  - Atualiza os dados de um livro cadastrado no sistema.
  - Exemplo de corpo de resposta:
  ```json
  {
    "data": {
      "message": "Book deleted!"
    },
    "status": "success"
  }
  ```
