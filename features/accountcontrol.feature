Feature: account control

  I want to edit the admin and partner password

  Background: admins and partners in database

    Given the following admins exist:
      | username | password  |
      | admin    | qwerty123 |

    Given the following partners exist:
      | username | password  |
      | partner  | qwerty123 |


    When I fill inside "adminaccount" the following:
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press ""
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

  Scenario: edit member with correct values
    When I am on the members page
    And I follow "12345"
    Then I should see "Jäsenen tietojen muokkaus"
    And I fill in "member[firstnames]" with "Janne"
    And I fill in "member[surname]" with "Jäsen"
    And I press "Tallenna"
    Then I should see "Tiedot muutettu!"
    And I follow "Listaa jäsenet"
    When I am on the members page
    Then I should see "Janne"
    Then I should see "Jäsen"


  Scenario: edit member with incorrect values
    When I am on the members page
    And I follow "12345"
    Then I should see "Jäsenen tietojen muokkaus"
    And I fill in "member[email]" with "google"
    And I fill in "member[membernumber]" with "1"
    And I press "Tallenna"
    Then I should see "Sähköpostiosoitteen muoto on väärä!"
    Then I should see "Jäsennumeron tulee olla tasan 5 merkkiä pitkä!"
    And I fill in "member[membernumber]" with "aaa"
    And I press "Tallenna"
    Then I should see "Jäsennumerossa tulee olla vain numeroita!"

  Scenario: edit member with incorrect values
    When I am on the members page
    And I follow "12345"
    Then I should see "Jäsenen tietojen muokkaus"
    And I fill in "member[firstnames]" with ""
    And I fill in "member[surname]" with ""
    And I fill in "member[municipality]" with ""
    And I fill in "member[address]" with ""
    And I fill in "member[zipcode]" with ""
    And I fill in "member[postoffice]" with ""
    And I fill in "member[email]" with ""
    And I fill in "member[membernumber]" with ""
    And I press "Tallenna"
    Then I should see "Etunimi puuttuu!"
    Then I should see "Sukunimi puuttuu!"
    Then I should see "Kunta puuttuu!"
    Then I should see "Osoite puuttuu!"
    Then I should see "Postinumero puuttuu!"
    Then I should see "Postitoimipaikka puuttuu!"
    Then I should see "Sähköpostiosoite puuttuu!"
    Then I should see "Jäsennumero puuttuu!"
