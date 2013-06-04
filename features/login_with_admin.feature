Feature: login with admin

  I want to log into the system as an admin and redirect to the "add a new member" page

  Background: admins in database
    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    When I am on the login page

  Scenario: I log in as an admin
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    Then I should see "Kirjaudu ulos"

  Scenario: I log in as a partner using invalid parameters
    And I fill in "username" with "fdkglsa"
    And I fill in "password" with "gfdaögf"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana"

  Scenario: I log in using an incorrect password
    And I fill in "username" with "admin"
    And I fill in "password" with "gfda"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana"