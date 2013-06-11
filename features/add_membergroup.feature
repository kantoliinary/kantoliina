#Feature: Add a new membergroup
#
#  I want to add a new membergroup and see if it was successfully created
#
#
#  Background: admins in database
#
#    Given the following admins exist:
#      | username | password  | email          |
#      | admin    | qwerty123 | testi@testi.fi |
#
#    Given the following membergroups exist:
#      | id | name        | fee  |
#      | 1  | Ainaisjäsen | 10.0 |
#
#
#
#    When I am on the login page
#    And I fill in "username" with "admin"
#    And I fill in "password" with "qwerty123"
#    And I press "Login"
#    And I follow "Jäsenryhmät"
#    Then I should see "Jäsenmaksu (€)"
#
#  Scenario: Add a new membergroup with valid values
#    When I fill in the following:
#      | Nimi           | Rivijäsen |
#      | Jäsenmaksu (€) | 10        |
#    And I press "Lisää"
#    Then I should see "Jäsenryhmä lisätty"
#    And I should see "Rivijäsen"
#
#
#
