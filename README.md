# README

This README would normally document whatever steps are necessary to get the
application up and running.

This application does following activities:
a. View a list of tasks.
b. Add a new task.
c. Edit an existing task (update its title or status).
d. Delete a task.
e. Feature to mark tasks as "Done."
f. Display tasks in a list, including their title, description, status, and due date.
g. The application has proper error handling and validation.
h. Immplimented pagination for task list
i. Implemented unit test using Rspec

The tasks should have the following properties:
a. Title (string).
b. Description (string).
c. Status (enum with values: "To Do," "In Progress," "Done").
d. Due Date (datetime).

Some things to think about when building this application are:
● HTTP Methods used for endpoints
    GET v1/tasks
    POST v1/tasks
    PATCH/PUT v1/tasks/:id
    DELETE v1/tasks/:id
    PATCH v1/tasks/:id/mark_done
● How you structure your request and response data
    Added the JSON api serielizer to serialize the data
● How you would validate the request data
    For this application title and status must be present


Things you may to cover:

* Ruby version
 ruby '2.7.8'

* Rails version
'rails', '~> 6.0.6', '>= 6.0.6.1'

* Database creation
 This application use default sqlite database

* Added test cases using Rspec
 spec\requests\api\v1\tasks.rb

