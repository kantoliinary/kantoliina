Feature: add new member

  I want add new member and get and get information of that was successfull created or get error messages

  Background: admins in database
    Given the following admins exist:
      | login | password |
      | admin | qwerty123 |

    When I am on the login page
    And I fill in "login" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Jäsenien lisäykseen"

  Scenario: add new member
    When I fill in the following:
      | Etunimet | jasen |
      | Sukunimi | aaa |
      | Kunta | gfdal |
      | Katuosoite | gda |
      | Postinumero | 12345 |
      | Postitoimipaikka | gda |
      | Sähköposti | gf@a.com |
      | Jäsennumero | 123 |
    And I select "Varsinainen jäsen" from "member_membergroup"
    And I select "2013/11/12" as the member "payday" date
    And I press "Lisää"
    Then I should see "Jasen lisatty!"

  Scenario: add new member with wrong format email
    When I fill in the following:
      | Etunimet | jasen |
      | Sukunimi | aaa |
      | Kunta | gfdal |
      | Katuosoite | gda |
      | Postinumero | 12345 |
      | Postitoimipaikka | gda |
      | Sähköposti | gf.com |
      | Jäsennumero | 123 |
    And I press "Lisää"
    Then I should see "Sähköpostiosoitteen muoto on väärä!"

  Scenario: add new member with wrong length membernumber
    When I fill in the following:
      | Etunimet | jasen |
      | Sukunimi | aaa |
      | Kunta | gfdal |
      | Katuosoite | gda |
      | Postinumero | 12345 |
      | Postitoimipaikka | gda |
      | Sähköposti | gf.com |
      | Jäsennumero | 12 |
    And I press "Lisää"
    Then I should see "Jasennumeron tulee olla 3-19 merkkia pitka!"