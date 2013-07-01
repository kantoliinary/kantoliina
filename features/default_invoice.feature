Feature: Invoice members

  I want to see if the invoice functionality works

  Background: Admin exists in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I am on the invoice_edit page

  Scenario: I try to revert to the default invoice template
    When I fill in "template" with "REMOVE THIS TEXT"
    And I press "Palauta oletuspohja"
    Then I should see "Kantoliinayhdistyksen jäsenmaksu"
    Then I should not see "REMOVE THIS TEXT"



