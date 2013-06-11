Feature: send mail to members

  I want to see if we are sending mail to the right members


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
      | Sähköposti       | jggggg@hhhhhhh.com    |
      | Jäsennumero      | 12345                 |

    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    And I follow "Listaa jäsenet"


  Scenario: Select all to mail page and send mail
    And I should see "Janne"
    And I check "check_all"
    And I press "Lähetä sähköpostia"
    And I should see "Sähköpostin varmistus"
    And I fill in "subject" with "Otsikko"
    And I fill in "additional_message" with "viestia"
    And I press "Lähetä sähköposti"
    Then I should see "Sähköposti lähetetty"

  Scenario: Delete one on mail page
    And I should see "Janne"
    And I check "check_all"
    And I press "Lähetä sähköpostia"
    And I should see "Sähköpostin varmistus"
    And I press "Poista"
    Then I should not see "Janne"