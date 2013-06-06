Feature: login with partner

  I want to log into the system as a partner

  Background: partners in database
    Given the following partners exist:
      | username | password  |
      | partner  | qwerty123 |

    When I am on the partner_login page

  Scenario: I log in as a partner
    And I fill in "username" with "partner"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    Then I should see "Kirjaudu ulos"

  Scenario: I log in as a partner using invalid parameters
    And I fill in "username" with "fdkglsa"
    And I fill in "password" with "gfdaögf"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana"

  Scenario: I log in using an incorrect password
    And I fill in "username" with "partner"
    And I fill in "password" with "gfda"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana"