Feature: Delete a new member

  I want to delete a member and see if the member was successfully destroyed

  Background: admins in database

    Given the following admins exist:
      | username | password  |
      | admin    | qwerty123 |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | aaa      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | 12345    |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 12345    |
    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    And I follow "Listaa jäsenet"


  Scenario: I try to delete a member from the list page
    When I am on the members page
    Then I should see "jasen"
    And I press "Poista"
    Then I should see "Jäsen poistettu"
    Then I should not see "jasen"

  Scenario: I try to delete an already deleted member from the list page
    When I am on the members page
    Then I should see "jasen"
    And I press "Poista"
    Then I should see "Jäsen poistettu"
    Then I should not see "jasen"
    And I check "membership[1]"
    And I check "membership[0]"
    And I press "Hae"
    Then I should see "aaa"
    And I press "Aktivoi"
    Then I should see "Jäsen aktivoitu"