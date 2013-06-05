Feature: account control

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

  Scenario: I submit changes with empty values
    When I am on the accountcontrol_index page
    And I press the button "Muokkaa" inside "adminaccount"
    Then I should see "Tunnuksen muokkaus ei onnistunut!"

  Scenario: I submit valid changes
    When I fill inside "adminaccount" the following:
      | Uusi käyttäjätunnus       | admin     |
      | Uusi salasana             | 123qwerty |
      | Uuden salasanan vahvistus | 123qwerty |
      | Vanha salasana            | qwerty123 |
    And I press the button "Muokkaa" inside "adminaccount"
    Then I should see "Tiedot päivitetty"
