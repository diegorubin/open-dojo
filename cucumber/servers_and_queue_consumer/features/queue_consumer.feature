Feature: put message in the queue and retrieve results by service
  Background:
    Given I logged on admin of rabbitmq

  Scenario: Put a message on queue and get content via service
    Given in page of "dojo" queue
    When set the message 
    """
    content
    of
    message
    """
    And set header key "name" with "message1"
    And post the message
    And fetch "message1" file from api
    Then the response should be the message

  Scenario: Not create forbidden file
    Given in page of "dojo" queue
    When set the message 
    """
    content
    of
    message
    """
    And set header key "name" with "xurisso"
    And post the message
    And fetch "xurisso" file from api
    Then the response status code should be "404"
    And a messsage exists on "erro" queue with "xurisso" in payload
