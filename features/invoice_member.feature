Feature: invoice members

  I want to see if we are billing the right members

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name           | fee  |
      | 1  | Ainaisjäsen    | 40.0 |
      | 2  | Varsinaisjäsen | 20.0 |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | Janne                 |
      | Sukunimi         | Jäsen                 |
      | Kunta            | Vantaa                |
      | Katuosoite       | Jokiniementie         |
      | Postinumero      | 54321                 |
      | Postitoimipaikka | Stadi                 |
      | Sähköposti       | janne.jasen@yahoo.com |
      | Jäsennumero      | 12345                 |

    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    And I follow "Listaa jäsenet"
    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | Liisa                      |
      | Sukunimi         | Mehiläinen                 |
      | Kunta            | Espoo                      |
      | Katuosoite       | Jokintie                   |
      | Postinumero      | 12345                      |
      | Postitoimipaikka | Stadi                      |
      | Sähköposti       | liisa.mehilainen@gmail.com |
      | Jäsennumero      | 12466                      |
    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    And I follow "Listaa jäsenet"



  Scenario: Select all
    And I should see "Liisa"
    And I should see "Janne"
    And I choose "membership_1"
#    And I press "Lähetä laskut"
#    And I should see "Laskunlähetys"
#

  Scenario: Select one
#    And I check "1"
#    And I press "Lähetä laskut"
#    And I should not see "Liisa"
#    And I should see "Janne"
#    And I should see "Laskunlähetys"
#

