Feature: Add a new membergroup

  I want to add a new membergroup and see if it was successfully created


  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |



    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Jäsenryhmät"

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
    And I check "member_lender"
    And I check "member_support"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"

  Scenario: Add a new member with wrongly formatted e-mail
    When I fill in the following:
      | Etunimet         | jasen  |
      | Sukunimi         | aaa    |
      | Kunta            | gfdal  |
      | Katuosoite       | gda    |
      | Postinumero      | 12345  |
      | Postitoimipaikka | gda    |
      | Sähköposti       | gf.com |
      | Jäsennumero      | 12345  |
    And I press "Lisää"
    And I check "member_lender"
    Then I should see "Sähköpostiosoitteen muoto on väärä"

  Scenario: Add a new member with too short member number
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
    Then I should see "Jäsennumeron tulee olla tasan 5 merkkiä pitkä"

  Scenario: Add a new member with a membernumber already in use
    When I fill in the following:
      | Etunimet         | jasen      |
      | Sukunimi         | aaa        |
      | Kunta            | gfdal      |
      | Katuosoite       | gda        |
      | Postinumero      | 12345      |
      | Postitoimipaikka | gda        |
      | Sähköposti       | gf@kkk.com |
      | Jäsennumero      | 12345      |
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    When I fill in the following:
      | Etunimet         | jasen      |
      | Sukunimi         | aaa        |
      | Kunta            | gfdal      |
      | Katuosoite       | gda        |
      | Postinumero      | 12345      |
      | Postitoimipaikka | gda        |
      | Sähköposti       | gf@ggg.com |
      | Jäsennumero      | 12345      |
    And I press "Lisää"
    Then I should see "Jäsennumero on jo käytössä"
