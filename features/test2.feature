Feature: Contact me
  In order to get in touch
  A visitor
  Should send me a message by contact form

  Scenario: Log in
    Given I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "12345678"
    When I press "Submit"
    Then page should have notice message "Login succesful"