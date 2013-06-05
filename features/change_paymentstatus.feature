Feature: Change paymentstatus to false

  I want to change member's paymentstatus to false and see if the changes was made

  Background: admins in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

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
#
#  @javascript
#  Scenario: I try to delete all members from the list page and press cancel on conf
#    When I am on the members page
#    Then I should see "jasen"
#    And I check "check_all"
#    Given I expect to click "cancel" on a confirmation box
#    When I press "Poista"
#    Then I should not see "Jäsen poistettu"
