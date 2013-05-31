Feature: add new member

  I want add new member and get and get information of that was successfull created or get error messages


  Background: admins in database

    Given the following admins exist:
      | login | password  |
      | admin | qwerty123 |

    Given the following membergroups exist:
      | id       | groupname                   | fee |
      | 1        | Ainaisjäsen                 | 10.0|



    When I am on the login page
    And I fill in "login" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Lisää jäsen"

  Scenario: add new member



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
    And I select "2013/11/12" as the member "expirationdate" date
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"

  Scenario: add new member with wrong format email
    When I fill in the following:
      | Etunimet         | jasen  |
      | Sukunimi         | aaa    |
      | Kunta            | gfdal  |
      | Katuosoite       | gda    |
      | Postinumero      | 12345  |
      | Postitoimipaikka | gda    |
      | Sähköposti       | gf.com |
      | Jäsennumero      | 12345|
    And I press "Lisää"
    Then I should see "Sähköpostiosoitteen muoto on väärä!"

  Scenario: add new member with wrong length membernumber
    When I fill in the following:
      | Etunimet         | jasen  |
      | Sukunimi         | aaa    |
      | Kunta            | gfdal  |
      | Katuosoite       | gda    |
      | Postinumero      | 12345  |
      | Postitoimipaikka | gda    |
      | Sähköposti       | gf.com |
      | Jäsennumero      | 12     |
    And I press "Lisää"
    Then I should see "Jäsennumeron tulee olla tasan 5 merkkiä pitkä!"

  Scenario: add new member with already taken membernumber
    When I fill in the following:
      | Etunimet         | jasen  |
      | Sukunimi         | aaa    |
      | Kunta            | gfdal  |
      | Katuosoite       | gda    |
      | Postinumero      | 12345  |
      | Postitoimipaikka | gda    |
      | Sähköposti       | gf@kkk.com |
      | Jäsennumero      | 12345  |
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    When I fill in the following:
      | Etunimet         | jasen  |
      | Sukunimi         | aaa    |
      | Kunta            | gfdal  |
      | Katuosoite       | gda    |
      | Postinumero      | 12345  |
      | Postitoimipaikka | gda    |
      | Sähköposti       | gf@ggg.com |
      | Jäsennumero      | 12345  |
    And I press "Lisää"
    Then I should see "Jäsennumero on jo käytössä!"
