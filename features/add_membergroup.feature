Feature: Add a new membergroup

  I want to add a new membergroup and see if it was successfully created


  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |





    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I am on the membergroups page
    Then I should see "Jäsenmaksu (€)"
    And I follow "Lisää jäsenryhmä"

  Scenario: Add a new membergroup with valid values
    When I fill in the following:
      | Nimi           | Rivijäsen |
      | Jäsenmaksu (€) | 10        |
    And I press "Lisää"
    Then I should see "Jäsenryhmä lisätty"
    And I should see "Rivijäsen"
    And I should see "Vuosittainen"
    And I should see "10.0"

  Scenario: Add a new membergroup with valid values and a permanent fee
    When I fill in the following:
      | Nimi           | Rivijäsen |
      | Jäsenmaksu (€) | 10        |
    And I check "Kertamaksu"
    And I press "Lisää"
    Then I should see "Jäsenryhmä lisätty"
    And I should see "Rivijäsen"
    And I should see "Kerta"

  Scenario: Add a new membergroup with empty values
    When I press "Lisää"
    Then I should see "Ryhmän nimi puuttuu"
    And I should see "Hinta puuttuu"

  Scenario: Add a new membergroup with invalid values
    When I fill in the following:
      | Nimi           | Rivijäsen |
      | Jäsenmaksu (€) | abba      |
    And I press "Lisää"
    Then I should see "Hinnan tulee olla numero"
