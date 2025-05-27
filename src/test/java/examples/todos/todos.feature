@debug 
Feature: Karate basic todos

Background: 
  * url  apiUrl
@ignore
Scenario: Get all todos
  When method get
  Then status 200

Scenario: Create, retrieve, and update a todo
    * def firstTodo = 'New Todo'
  # Create a new todo item
  Given request { "title": '#(firstTodo)', "completed": false }
  When method post
  Then status 200
  And match response.title == 'New Todo'
  And match response.completed == false
  And match response.id != null
  And match response == { id: '#string', title: 'New Todo', completed: false }

  * def todoId = response.id
  * def title = response.title
  * def status = response.completed
  * print 'Created Todo ID: ' + todoId, 'Title: ' + title, 'Status: ' + status

  # Get the created todo item with ID
  Given path todoId    
  When method get
  Then status 200
  And match response == { id: '#(todoId)', title: 'New Todo', completed: false }

  # Update the created todo item
  Given path todoId
  And request { id: '#(todoId)', title: 'Updated Todo', completed: true }
  When method put
  Then status 200
  And match response == { id: '#(todoId)', title: 'Updated Todo', completed: true }

  # Get the updated todo item
  Given path todoId
  When method get
  Then status 200
  And match response == { id: '#(todoId)', title: 'Updated Todo', completed: true }


  # create another todo item
  * def toso2 = 
  """
  {
    "title": "Another Todo",
    "completed": false
  }
  """
  Given request toso2
  When method post
  Then status 200
  And match response.title == 'Another Todo'

  # get all todos 
  When method get
  Then status 200
  * match each response == { id: '#string', title: '#string', completed: '#boolean' }
  * print 'All Todos:', response
  # Clean up by deleting the created todos
  Given path todoId
  When method delete
  Then status 200


  * call read('classpath:helper/ResetTodos.feature')
* print 'Todos reset successfully'