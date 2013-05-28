Feature: filter members

  I want to search the exact member object and see the change in the screen

  Background: admins in database
    Given the following admins exist:
      | login | password  |
      | admin | qwerty123 |
    When I am on the login page
    And I fill in "login" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Jäsenien lisäykseen"
    When I fill in the following:
      | Etunimet         | Janne                 |
      | Sukunimi         | Jäsen                 |
      | Kunta            | Vantaa                |
      | Katuosoite       | Jokiniementie         |
      | Postinumero      | 54321                 |
      | Postitoimipaikka | Stadi                 |
      | Sähköposti       | janne.jasen@yahoo.com |
      | Jäsennumero      | 123                   |
    And I select "Varsinainen jäsen" from "Jäsenryhma"
    And I select "2013/11/12" as the member "expirationdate" date
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    And I follow "Listaa jäsenet"
    And I follow "Jäsenien lisäykseen"
    When I fill in the following:
      | Etunimet         | Liisa                      |
      | Sukunimi         | Mehiläinen                 |
      | Kunta            | Espoo                      |
      | Katuosoite       | Jokintie                   |
      | Postinumero      | 12345                      |
      | Postitoimipaikka | Stadi                      |
      | Sähköposti       | liisa.mehilainen@gmail.com |
      | Jäsennumero      | 124                        |
    And I select "Varsinainen jäsen" from "Jäsenryhmä"
    And I select "2013/11/12" as the member "expirationdate" date
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    And I follow "Listaa jäsenet"
    And I follow "Jäsenien lisäykseen"
    When I fill in the following:
      | Etunimet         | Jaana                   |
      | Sukunimi         | Jäsen                   |
      | Kunta            | Espoo                   |
      | Katuosoite       | Jokintie                |
      | Postinumero      | 12345                   |
      | Postitoimipaikka | Stadi                   |
      | Sähköposti       | jaana.jasen@hotmail.com |
      | Jäsennumero      | 125                     |
    And I select "Varsinainen jäsen" from "Jäsenryhmä"
    And I select "2013/11/12" as the member "expirationdate" date
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    And I follow "Listaa jäsenet"

  Scenario: filter members by first name
    When I am on the members page
    And I fill in "keyword" with "Ja"
    And I check "search_fields[firstnames]"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should not see "Liisa"

  Scenario: filter members by last name
    When I am on the members page
    And I fill in "keyword" with "Jäsen"
    And I check "search_fields[surname]"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should not see "Liisa"

  Scenario: filter members by municipality
    When I am on the members page
    And I fill in "keyword" with "Espoo"
    And I check "search_fields[municipality]"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should not see "Janne"
    Then I should see "Liisa"

  Scenario: filter members by address
    When I am on the members page
    And I fill in "keyword" with "jokin"
    And I check "search_fields[municipality]"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should see "Liisa"

  Scenario: filter members by address
    When I am on the members page
    And I fill in "keyword" with "jokin"
    And I check "search_fields[municipality]"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should see "Liisa"

  Scenario: filter members by zipcode
    When I am on the members page
    And I fill in "keyword" with "12345"
    And I check "search_fields[zipcode]"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should not see "Janne"
    Then I should see "Liisa"

  Scenario: filter members by post office
    When I am on the members page
    And I fill in "keyword" with "helsinki"
    And I check "search_fields[postoffice]"
    And I press "Hae"
    Then I should not see "Jaana"
    Then I should not see "Janne"
    Then I should not see "Liisa"

  Scenario: filter members by email
    When I am on the members page
    And I fill in "keyword" with "liisa"
    And I check "search_fields[email]"
    And I press "Hae"
    Then I should not see "Jaana"
    Then I should not see "Janne"
    Then I should see "Liisa"

  Scenario: filter members by member number
    When I am on the members page
    And I fill in "keyword" with "125"
    And I check "search_fields[email]"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should not see "Janne"
    Then I should not see "Liisa"