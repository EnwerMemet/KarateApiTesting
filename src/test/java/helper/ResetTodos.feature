Feature:

  Scenario:
    # clear all todos
    Given url 'http://localhost:8080/api/reset'
    When method Get
    Then status 200
    And match response == { deleted: '#number' }
    * def deletedCount = response.deleted
    * print 'Deleted Todos Count: ' + deletedCount