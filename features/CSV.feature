Feature: CSV functionality

  I want to test the CSV functionality (or at least the error message)

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: I try to import a CSV with no file chosen
    When I am on the members page
    Given I expect to click "OK" on an alert box
    And I press "Tuo jäseniä .CSV-muodossa"