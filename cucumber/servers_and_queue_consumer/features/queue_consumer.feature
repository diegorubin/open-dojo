Feature: put message in the queue and retrieve results by service
    Background:
      Given estou logado
      And acesso a fila "dojo"

    Scenario: acessar o admin e postar uma mensagem
      When seto o header "name" e com valor "valor"
      And digito a mensagem "ola"
      And clico em enviar
      Then mensagem eh postada
      And o serviço deve retornar o conteúdo postado

    Scenario: postar uma mensagem com uma palavra proibida
      When seto o header "name" e com valor "xurisso"
      And digito a mensagem "ola"
      And clico em enviar
      Then mensagem eh postada
      And o serviço deve retornar "404"
      
