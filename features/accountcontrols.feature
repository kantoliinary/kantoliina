Feature: account controls

  I want to edit the admin and partner password

  Background: admins and partners in database

    Given the following admins exist:
      | username | password  | email         |
      | admin    | qwerty123 | mail@mail.com |

    Given the following partners exist:
      | username | password  |
      | partner  | qwerty123 |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Hallitse tunnuksia"

  Scenario: I submit empty admin account values
    When I am on the accountcontrols page
    And I press the button "Muokkaa" inside "adminaccount"
    Then I should see "Tunnuksen muokkaus ei onnistunut"

  Scenario: I submit valid admin account changes with a correct password
    When I am on the accountcontrols page
    And I fill inside "adminaccount" the following:
      | Uusi käyttäjätunnus       | admi      |
      | Uusi salasana             | 123qwerty |
      | Uuden salasanan vahvistus | 123qwerty |
      | Vanha salasana            | qwerty123 |
    And I press the button "Muokkaa" inside "adminaccount"
    Then I should see "Tiedot päivitetty"


  Scenario: I submit valid admin account changes with an incorrect password
    When I am on the accountcontrols page
    And I fill inside "adminaccount" the following:
      | Uusi käyttäjätunnus       | admi      |
      | Uusi salasana             | 123qwerty |
      | Uuden salasanan vahvistus | 123qwerty |
      | Vanha salasana            | qwerty124 |
    And I press the button "Muokkaa" inside "adminaccount"
    Then I should see "Tunnuksen muokkaus ei onnistunut"

  Scenario: I submit valid admin account changes with an incorrect verification for the new password
    When I am on the accountcontrols page
    And I fill inside "adminaccount" the following:
      | Uusi käyttäjätunnus       | admio     |
      | Uusi salasana             | 123qwerty |
      | Uuden salasanan vahvistus | 123qwertu |
      | Vanha salasana            | qwerty123 |
    And I press the button "Muokkaa" inside "adminaccount"
    Then I should see "Salasanan vahvistus on virheellinen"

  Scenario: I submit partner account changes with empty values
    When I am on the accountcontrols page
    And I press the button "Muokkaa" inside "partneraccount"
    Then I should see "Tunnuksen muokkaus ei onnistunut"

  Scenario: I submit valid partner account changes with a correct password
    When I am on the accountcontrols page
    And I fill inside "partneraccount" the following:
      | Uusi käyttäjätunnus       | partra    |
      | partner[password]         | 123qwerty |
      | Uuden salasanan vahvistus | 123qwerty |
      | Ylläpitäjän salasana      | qwerty123 |
    And I press the button "Muokkaa" inside "partneraccount"
    Then I should see "Tiedot päivitetty"

  Scenario: I submit valid partner account changes with an incorrect password
    When I am on the accountcontrols page
    And I fill inside "partneraccount" the following:
      | Uusi käyttäjätunnus       | partneo   |
      | partner[password]         | 123qwerty |
      | Uuden salasanan vahvistus | 123qwerty |
      | Ylläpitäjän salasana      | qwerty124 |
    And I press the button "Muokkaa" inside "partneraccount"
    Then I should see "Tunnuksen muokkaus ei onnistunut"

  Scenario: I submit valid admin account changes with an incorrect verification for the new password
    When I am on the accountcontrols page
    And I fill inside "partneraccount" the following:
      | Uusi käyttäjätunnus       | partneo     |
      | partner[password]         | 123qwerty |
      | Uuden salasanan vahvistus | 123qwertu |
      | Ylläpitäjän salasana      | qwerty123 |
    And I press the button "Muokkaa" inside "adminaccount"
    Then I should see "Tunnuksen muokkaus ei onnistunut"