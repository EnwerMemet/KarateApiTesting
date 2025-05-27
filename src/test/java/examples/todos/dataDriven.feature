@dataDriven
Feature: Data Driven testing examples
Background: 
    * url apiUrl
    * def sleep = function (pause){ java.lang.Thread.sleep(pause * 1000); }
Scenario Outline: Create and retrieve todos with different titles
    Given request { "title": '#(title)', "completed": false }
    When method post
    Then status 200
    And match response == { id: '#string', title: '#(title)', completed: false }

    * def todoId = response.id
    * print 'Created Todo ID: ' + todoId, 'Title: ' + title
    * sleep(5)

    Given path todoId    
    When method get
    Then status 200
    And match response == { id: '#(todoId)', title: '#(title)', completed: false }
    * print 'Finished iteration::' + iteration
    
    Examples:
        | title          | iteration |
        | First Todo     | 1         |
        | Second Todo    | 2         |
        | Third Todo     | 3         |
        | Fourth Todo    | 4         |