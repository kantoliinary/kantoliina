Feature: Edit a membergroup

  I want to delete a membergroup and see if it was really deleted


  Background: There is an admin and membergroups in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  | onetimefee |
      | 1  | Rivijäsen   | 10.0 | false      |
      | 2  | Bilejäsen   | 2.0  | true       |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I am on the membergroups page
    Then I should see "Jäsenmaksu (€)"
    Then I follow "Rivijäsen"

  @javascript
  Scenario: Delete a membergroup
    Given I expect to click "OK" on a confirmation box
    When I press "Poista jäsenryhmä"
    Then I should see "Jäsenryhmä poistettu"
    And I should see "Jäsenmaksu (€)"
    And I should see "Bilejäsen"
    And I should not see "Rivijäsen"

  @javascript
  Scenario: Almost delete a membergroup
    Given I expect to click "cancel" on a confirmation box
    When I press "Poista jäsenryhmä"
    Then I should see "Jäsenryhmän muokkaus"
    And I am on the membergroups page
    And I should see "Rivijäsen"
