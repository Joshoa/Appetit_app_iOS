
# Appetit_app_iOS  
  
Uma plataforma de solicitação de pedidos em um café fictício para dispositivos iOS usando Swift.  
  
- #### Pré-requisitos para rodar o app: 

 * **MAC - OS X**
 * [**Xcode**](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
 * [**Node.Js**](https://nodejs.org/) - [clique para ver o tutorial de instalação](https://medium.com/qa-sampa-meeting/instala%C3%A7%C3%A3o-do-node-js-e8d7a29b9db9) 
* **API REST:** [**json-server**](https://github.com/typicode/json-server) - [clique para ver o tutorial](https://medium.com/@andrewchanm/criando-uma-api-rest-fake-com-json-server-9a312127f6d6)

- ##### Arquivo db.json utilizado:
	<details>
		<summary>Mostrar código </summary>

	    {
            "user": [
                {
                    "id": 1,
                    "name": "Alessandra",
                    "password": "alessandra.senha",
                    "email": "alessandra@email.com"
                },
                {
                    "id": 2,
                    "name": "Mr Mjop",
                    "password": "mrmjop.senha",
                    "email": "mrmjop@email.com"
                },
                {
                    "id": 3,
                    "name": "Walace",
                    "password": "walace.senha",
                    "email": "walace@email.com"
                },
                {
                    "id": 4,
                    "name": "Renato",
                    "password": "renato.senha",
                    "email": "renato@email.com"
                }
            ],
            "client": [
                {
                    "id": 1,
                    "name": "Disclosure"
                },
                {
                    "id": 2,
                    "name": "Flume"
                },
                {
                    "id": 3,
                    "name": "Tove Lo"
                },
                {
                    "id": 4,
                    "name": "Hozier"
                }
            ],
            "order": [
                {
                    "id": 1,
                    "paymentStatus": 0,
                    "date": {
                        "year": 2019,
                        "month": 12,
                        "dayOfMonth": 11,
                        "hourOfDay": 23,
                        "minute": 0,
                        "second": 0
                    },
                    "client": "Tove Lo",
                    "products": "2x Cucuz completo com ovo, 1x Café com leite",
                    "amount": 10,
                    "user": 1
                },
                {
                    "id": 2,
                    "paymentStatus": 0,
                    "date": {
                        "year": 2019,
                        "month": 12,
                        "dayOfMonth": 11,
                        "hourOfDay": 23,
                        "minute": 0,
                        "second": 0
                    },
                    "client": "Flume",
                    "products": "2x Misto quente, 2x Coca cola",
                    "amount": 26,
                    "user": 1
                }
            ],
            "product": [
                {
                    "id": 1,
                    "name": "Cucuz completo",
                    "note": "Com ovo",
                    "options": "Cucuz de milho,Cucuz de arroz",
                    "price": 3.25
                }, 
                {
                    "id": 2,
                    "name": "Coca cola",
                    "note": "",
                    "options": "Original,Zero",
                    "price": 5.25
                }, 
                {
                    "id": 3,
                    "name": "Café",
                    "note": "Com leite",
                    "options": "",
                    "price": 3.25
                }, 
                {
                    "id": 4,
                    "name": "Misto quente",
                    "note": "",
                    "options": "",
                    "price": 7.75
                }
            ]
        }

	</details>

- #### Rodando o App:
	1. Inicie o json-server no diretório onde está o arquivo db.json;
	2. Baixe o projeto do git;
    3. Abra o projeto no XCode
    4. Faça o build e instalação do App no Simulador presente no XCode.
    
        *   [Rodando app no dispositivo](https://code.tutsplus.com/pt/tutorials/ios-from-scratch-with-swift-how-to-test-an-ios-application-on-a-device--cms-25156)

