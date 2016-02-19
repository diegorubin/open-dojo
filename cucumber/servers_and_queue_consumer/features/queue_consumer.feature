Feature: put message in the queue and retrieve results by service

  Scenario: Put a message on queue and get content via service
    Given I logged on admin of rabbitmq
    And in page of "dojo" queue
    When set the message 
    """
    content
    of
    message
    """
    And set header key "name" with "message1"
    And post the message
    Then read the message content from service

