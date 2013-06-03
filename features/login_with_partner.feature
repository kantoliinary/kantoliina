Feature: login with partner

  I want to login to the system as a partner

  Background: partners in database
    Given the following partners exist:
      | username | password  |
      | partner    | qwerty123 |

    When I am on the partner_login page

  Scenario: login as a partner
    And I fill in "username" with "partner"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    Then I should see "Kirjaudu ulos"

  Scenario: login as a partner using invalid params
    And I fill in "username" with "fdkglsa"
    And I fill in "password" with "gfdaögf"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana"

  Scenario: login with wrong password
    And I fill in "username" with "partner"
    And I fill in "password" with "gfda"
    And I press "Login"
    Then I should see "Virheellinen käyttäjätunnus tai salasana!"