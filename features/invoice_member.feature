Feature: filter members

  I want to search the exact member object and see the change in the screen

  Background: admins in database

    Given the following admins exist:
      | login | password  |
      | admin | qwerty123 |

    Given the following membergroups exist:
      | id | groupname      | fee  |
      | 1  | Ainaisjäsen    | 40.0 |
      | 2  | Varsinaisjäsen | 20.0 |


    When I am on the login page
    And I fill in "login" with "admin"
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
    And I select "2013/11/12" as the member "expirationdate" date
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    And I follow "Listaa jäsenet"
#    And I follow "Jäsenien lisäykseen"
#    When I fill in the following:
#      | Etunimet         | Liisa                      |
#      | Sukunimi         | Mehiläinen                 |
#      | Kunta            | Espoo                      |
#      | Katuosoite       | Jokintie                   |
#      | Postinumero      | 12345                      |
#      | Postitoimipaikka | Stadi                      |
#      | Sähköposti       | liisa.mehilainen@gmail.com |
#      | Jäsennumero      | 12466                      |
#    And I select "Ainaisjäsen" from "member[membergroup_id]"
#    And I select "2013/11/12" as the member "expirationdate" date
#    And I press "Lisää"
#    Then I should see "Jäsen lisätty!"
#    And I follow "Listaa jäsenet"

  Scenario:
#    And I press "Lähetä laskut"
#    And I should not see "Laskunlähetys"

  Scenario: Select all
#    And I should see "Liisa"
#    And I should see "Janne"
#    And I check "member_checkbox"
#    And I press "Lähetä laskut"
#    And I should see "Laskunlähetys"
#
#  Scenario: Select one
#    And I check "member_checkbox"
#    And I press "Lähetä laskut"
#    And I should not see "Liisa"
#    And I should see "Janne"
#    And I should see "Laskunlähetys"
#
