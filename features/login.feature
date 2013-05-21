Feature: Log in
As an admin logs in

  Scenario: Log in
    Given I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "12345678"
    When I press "Submit"
    Then page should have notice message "Login succesful"