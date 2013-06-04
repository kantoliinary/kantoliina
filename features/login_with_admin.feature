Feature: login with admin

  I want to log into the system as an admin and redirect to the "add a new member" page

  Background: admins in database
    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    When I am on the login page

  Scenario: login with admin
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    Then I should see "Kirjaudu ulos"

  Scenario: login with admin invalid params
    And I fill in "username" with "fdkglsa"
    And I fill in "password" with "gfdaögf"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana"

  Scenario: login with wrong password
    And I fill in "username" with "admin"
    And I fill in "password" with "gfda"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana"