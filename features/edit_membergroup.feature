Feature: Edit a membergroup

  I want to edit a membergroup and see if the changes were valid


  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  | onetimefee |
      | 1  | Rivijäsen   | 10.0 | false      |




    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I am on the membergroups page
    Then I should see "Jäsenmaksu (€)"
    Then I follow "Rivijäsen"

  Scenario: Edit a membergroup with valid values
    When I fill in the following:
      | Nimi           | Bilejäsen |
      | Jäsenmaksu (€) | 2         |
    And I check "Kertamaksu"
    And I press "Tallenna muutokset"
    Then I should see "Tiedot muutettu"
    And I should see "Bilejäsen"
    And I should see "2.0"
    And I should see "Kerta"

  Scenario: Edit a membergroup with empty values
    When I fill in the following:
      | Nimi           |  |
      | Jäsenmaksu (€) |  |
    And I press "Tallenna muutokset"
    Then I should see "Ryhmän nimi puuttuu"
    And I should see "Hinta puuttuu"



  Scenario: Edit a membergroup with invalid values
    When I fill in the following:
      | Nimi           | Rivijäsen |
      | Jäsenmaksu (€) | abba      |
    And I press "Tallenna muutokset"
    Then I should see "Hinnan tulee olla numero"
