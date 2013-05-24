Feature: add new member

  I want add new member and get and get information of that was successfull created or get error messages

  Background: admins in database
    Given the following admins exist:
      | login | password  |
      | admin | qwerty123 |

    When I am on the login page
    And I fill in "login" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: add new member
    When I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | aaa      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | 12345    |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 123      |
    And I select "Varsinainen jäsen" from "member_membergroup"
    And I select "2013/11/12" as the member "payday" date
    And I press "Lisää"
    Then I should see "Jasen lisatty!"

  Scenario: add new member with invalid params
    When I press "Lisää"
    Then I should see "Etunimi puuttuu!"
    Then I should see "Sukunimi puuttuu!"
    Then I should see "Kunta puuttuu!"
    Then I should see "Osoite puuttuu!"
    Then I should see "Postinumero puuttuu!"
    Then I should see "Postitoimipaikka puuttuu!"
    Then I should see "Sahkopostiosoite puuttuu!"
    Then I should see "Jasennumero puuttuu!"

  Scenario: add new member with wrong length zipcode
    When I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | aaa      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | 1234     |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 123      |
    And I press "Lisää"
    Then I should see "Postinumeron tulee olla viiden merkin pituinen!"

  Scenario: add new member with chars in zipcode
    When I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | aaa      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | gfdaa    |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 123      |
    And I press "Lisää"
    Then I should see "Postinumeron tulee sisaltaa vain numeroita!"

  Scenario: add new member with wrong format email
    When I fill in the following:
      | Etunimet         | jasen  |
      | Sukunimi         | aaa    |
      | Kunta            | gfdal  |
      | Katuosoite       | gda    |
      | Postinumero      | 12345  |
      | Postitoimipaikka | gda    |
      | Sähköposti       | gf.com |
      | Jäsennumero      | 123    |
    And I press "Lisää"
    Then I should see "Sahkopostiosoitteen muoto on vaara!"

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
    Then I should see "Jasennumeron tulee olla 3-19 merkkia pitka!"