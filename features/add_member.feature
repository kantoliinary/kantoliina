Feature: Add a new member

  I want to add a new member and see if it was successfully created


  Background: An admin and a membergroup exist in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |

    Given the following members exist:
      | id | firstnames | surname | municipality | address       | zipcode | postoffice | country | email                 | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active | support | lender | reminderdate |
      | 1  | Janne      | Jaesen  | Vantaa       | Jokiniementie | 65432   | Stadi      | Finland | janne.jasen@yahoo.com | 10000        | 1              | 2015           | true          | 2015.01.01  | true   | false   | false  | 2015.01.01   |

    When I am on the login page
    And I fill in "username" with "admin"
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

    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I select "Andorra" from "member_country"
    And I check "member_lender"
    And I check "member_support"
    And I check "member[paymentstatus]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    And I follow "Jäsenten hallinta"
    Then I should see "aaa jasen"
    Then I should see "2013"

  Scenario: Add a new member with wrongly formatted e-mail
    When I fill in the following:
      | Etunimet         | jasen  |
      | Sukunimi         | aaa    |
      | Kunta            | gfdal  |
      | Katuosoite       | gda    |
      | Postinumero      | 12345  |
      | Postitoimipaikka | gda    |
      | Sähköposti       | gf.com |
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
      | Etunimet         | huba       |
      | Sukunimi         | haba       |
      | Kunta            | gfdal      |
      | Katuosoite       | gda        |
      | Postinumero      | 12345      |
      | Postitoimipaikka | gda        |
      | Sähköposti       | gf@ggg.com |
      | Jäsennumero      | 10000      |
    And I press "Lisää"
    Then I should see "Jäsennumero on jo käytössä"

  Scenario: I try to add a member with a name-address combination already in use
    And I fill in the following:
      | Etunimet         | Janne         |
      | Sukunimi         | Jaesen        |
      | Kunta            | Vantaa        |
      | Katuosoite       | Jokiniementie |
      | Postinumero      | 65432         |
      | Postitoimipaikka | gda           |
      | Sähköposti       | gf@ggg.com    |
    And I press "Lisää"
    Then I should see "Jäsen samoilla nimi- ja osoitetiedoilla on jo olemassa"
