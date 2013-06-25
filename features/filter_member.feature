Feature: filter members

  I want to search the exact member object and see the change on the screen

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name           | fee   |
      | 1  | Ainaisjäsen    | 100.0 |
      | 2  | Varsinaisjäsen | 10.0  |

    Given the following members exist:
      | id | firstnames | surname    | municipality | address       | zipcode | postoffice | country | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active | support | lender |
      | 1  | Janne      | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | Finland | janne.jasen@yahoo.com      | 12345        | 1              | 2013           | true          | 2013.01.01  | true   | false   | false  |
      | 2  | Liisa      | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12466        | 1              | 2013           | true          | 2013.01.01  | true   | false   | false  |
      | 3  | Jaana      | Jäsen      | Espoo        | Jokintie      | 12345   | Stadi      | Finland | jaana.jasen@hotmail.com    | 12543        | 2              | 2013           | false         | 2013.01.01  | true   | true    | true   |
      | 4  | Pelle      | Poistettu  | Limbo        | Olematontie   | 54321   | Poissa     | Finland | pelle.poistettu@eioo.com   | 99999        | 1              | 2013           | true          | 2013.01.01  | false  | false   | false  |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: I filter members by first name
    When I am on the members page
    And I fill in "searchfield" with "Ja"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should not see "Liisa"


  Scenario: I try to hide the name column
    When I am on the members page
    Then I should see "Janne"
    And I click a text "#column_select"
    And I uncheck "Nimi"
    And I click a text "#hide_layout"
    Then I should see "12345"
    Then I should not see "Janne"

  Scenario: I filter members by last name
    When I am on the members page
    And I fill in "searchfield" with "Jäsen"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should not see "Liisa"

  Scenario: I filter members by e-mail
    When I am on the members page
    And I fill in "searchfield" with "liisa"
    And I press "Hae"
    Then I should not see "Jaana"
    Then I should not see "Janne"
    Then I should see "Liisa"

  Scenario: I try to show e-mail addresses
    When I am on the members page
    And I click a text "#column_select"
    And I check "Sähköposti"
    And I click a text "#hide_layout"
    Then I should see "janne.jasen@yahoo.com"

  Scenario: I filter members by municipality
    When I am on the members page
    And I fill in "searchfield" with "Espoo"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should not see "Janne"
    Then I should see "Liisa"

  Scenario: I try to block a municipality
    When I am on the members page
    Then I should see "Espoo"
    Then I click a text ".municipality_menu .header"
    And I uncheck "Espoo"
    And I click a text "#hide_layout"
    Then I should see "Vantaa"
    And I should not see "Valitse kaikki"
    And I should not see "Espoo"

  Scenario: I filter members by address
    When I am on the members page
    And I fill in "searchfield" with "jokin"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should see "Liisa"

  Scenario: I try to show addresses
    When I am on the members page
    And I click a text "#column_select"
    And I check "Osoite"
    And I click a text "#hide_layout"
    Then I should see "Jokiniementie"

  Scenario: I filter members by zipcode
    When I am on the members page
    And I fill in "searchfield" with "12345"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should see "Liisa"

  Scenario: I try to show zipcodes
    When I am on the members page
    Then I should not see "54321"
    And I click a text "#column_select"
    And I check "Postinumero"
    And I click a text "#hide_layout"
    Then I should see "54321"

  Scenario: I filter members by post office
    When I am on the members page
    And I fill in "searchfield" with "helsinki"
    And I press "Hae"
    Then I should not see "Jaana"
    Then I should not see "Janne"
    Then I should not see "Liisa"

  Scenario: I try to show post offices
    When I am on the members page
    Then I should not see "Stadi"
    And I click a text "#column_select"
    And I check "Postitoimipaikka"
    And I click a text "#hide_layout"
    Then I should see "Stadi"


  Scenario: I filter members by member number
    When I am on the members page
    And I fill in "searchfield" with "125"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should not see "Janne"
    Then I should not see "Liisa"

  Scenario: I try to hide the member number column
    When I am on the members page
    Then I should see "12345"
    And I click a text "#column_select"
    And I uncheck "Jäsennumero"
    And I click a text "#hide_layout"
    Then I should not see "12345"

  Scenario: I filter members by membergroup
    When I am on the members page
    And I fill in "searchfield" with "125"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should not see "Janne"
    Then I should not see "Liisa"

  Scenario: I try to hide the membergroup column
    When I am on the members page
    Then I should see "Ainaisjäsen"
    And I click a text "#column_select"
    And I uncheck "Jäsenryhmä"
    And I click a text "#hide_layout"
    Then I should not see "Ainaisjäsen"
    And I should not see "Jäsenryhmä"

  Scenario: I try to block a membergroup
    When I am on the members page
    Then I should see "Ainaisjäsen"
    Then I click a text ".membergroup_menu .header"
    And I uncheck "Ainaisjäsen"
    And I click a text "#hide_layout"
    Then I should not see "Ainaisjäsen"
    And I should not see "Valitse kaikki"
    And I should not see "Janne"
    And I should see "Jaana"

  Scenario: I filter members by country
    When I am on the members page
    And I fill in "searchfield" with "Finland"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should see "Liisa"
    Then I should not see "Pelle"

  Scenario: I try to show countries
    When I am on the members page
    Then I should not see "Finland"
    And I click a text "#column_select"
    And I check "Maa"
    And I click a text "#hide_layout"
    Then I should see "Finland"

  Scenario: I try to hide the membershipyear column
    When I am on the members page
    Then I should see "2013"
    And I click a text "#column_select"
    And I uncheck "Jäsenyys voimassa"
    And I click a text "#hide_layout"
    Then I should not see "Finland"

  Scenario: I try to hide the invoicedate column
    When I am on the members page
    Then I should see "Laskun lähetyspäivä"
    And I click a text "#column_select"
    And I uncheck "Laskun lähetyspäivä"
    And I click a text "#hide_layout"
    Then I should not see "Laskun lähetyspäivä"

  Scenario: I try to hide the payment status column
    When I am on the members page
    Then I should see "Maksustatus"
    And I click a text "#column_select"
    And I uncheck "Maksustatus"
    And I click a text "#hide_layout"
    Then I should not see "Maksustatus"

  Scenario: I try to block a payment status category
    When I am on the members page
    Then I should see "Janne"
    And I should see "Jaana"
    Then I click a text ".paymentstatus_menu .header"
    And I uncheck "Kyllä"
    And I click a text "#hide_layout"
    And I should not see "Valitse kaikki"
    And I should not see "Janne"
    And I should see "Jaana"

  Scenario: I try to show the blocked members
    When I am on the members page
    Then I should not see "Aktiivisuus"
    And I click a text "#column_select"
    And I check "Aktiivisuus"
    And I click a text "#hide_layout"
    Then I should see "Aktiivisuus"
    And I should see "Janne"
    And I should not see "Pelle"
    Then I click a text ".active_menu .header"
    And I check "Näytä poistetut jäsenet"
    And I click a text "#hide_layout"
    Then I should see "Pelle"
    And I should not see "Janne"


  Scenario: I try to show the support status column and block a support status category
    When I am on the members page
    Then I should not see "Tukihenkilö"
    And I should see "Janne"
    And I should see "Jaana"
    And I click a text "#column_select"
    And I check "Tukihenkilö"
    And I click a text "#hide_layout"
    Then I should see "Tukihenkilö"
    Then I click a text ".support_menu .header"
    And I uncheck "Kyllä"
    And I click a text "#hide_layout"
    And I should not see "Valitse kaikki"
    And I should see "Janne"
    And I should not see "Jaana"

  Scenario: I try to show the lender status column and block a support status category
    When I am on the members page
    Then I should not see "Lainaamo"
    And I click a text "#column_select"
    And I check "Lainaamo"
    And I click a text "#hide_layout"
    Then I should see "Lainaamo"
    Then I click a text ".lender_menu .header"
    And I uncheck "Kyllä"
    And I click a text "#hide_layout"
    And I should not see "Valitse kaikki"
    And I should see "Janne"
    And I should not see "Jaana"

  Scenario: I try to search with two parameters
    When I am on the members page
    And I fill in "searchfield" with "Janne|Vantaa"
    And I press "Hae"
    Then I should not see "Jaana"
    Then I should see "Janne"
    Then I should not see "Liisa"

  Scenario: I try to search with three parameters and extra whitespaces
    When I am on the members page
    And I fill in "searchfield" with "Janne|    Vantaa   |     Stadi     "
    And I press "Hae"
    Then I should not see "Jaana"
    Then I should see "Janne"
    Then I should not see "Liisa"
