Feature: edit member

  I want to edit the member object and see the change in the database

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name           | fee  | onetimefee |
      | 1  | Ainaisjäsen    | 10.0 | true       |
      | 2  | Varsinaisjäsen | 10.0 | false      |

    Given the following members exist:
      | id | firstnames | surname     | municipality | address  | zipcode | postoffice | country | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active |
      | 1  | Matti      | Meikeläinen | Vaasa        | zigtie 5 | 00666   | Vaasa      | Finland | Matti.M@jeejee.com         | 11111        | 1              | 2013           | true          | 2013.01.01  | true   |
      | 2  | Liisa      | Mehiläinen  | Espoo        | Jokintie | 12345   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12466        | 2              | 2013           | false         | 2013.01.01  | true   |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: edit member with correct values
    When I am on the members page
    And I follow "11111"
    And I fill in "member[firstnames]" with "Janne"
    And I fill in "member[surname]" with "Jaesen"
    And I fill in "member[municipality]" with "Vantaa"
    And I select "Varsinaisjäsen" from "member_membergroup_id"
    And I press "Tallenna muutokset"
    Then I should see "Tiedot muutettu"
    And I follow "Jäsenten hallinta"
    When I am on the members page
    Then I click a text ".membergroup_menu .header"
    And I uncheck "Ainaisjäsen"
    And I click a text "#hide_layout"
    Then I should see "Janne"
    And I should see "Jaesen"
    And I should see "Vantaa"
    And I should see "Varsinaisjäsen"

  Scenario: edit member with incorrect values
    When I am on the members page
    And I follow "11111"
    And I fill in "member[email]" with "google"
  #    And I fill in "member[membernumber]" with "1"
    And I press "Tallenna muutokset"
    Then I should see "Sähköpostiosoitteen muoto on väärä"
    Then I should see "Jäsennumeron tulee olla tasan 5 merkkiä pitkä"
    And I fill in "member[membernumber]" with "aaa"
    And I press "Tallenna"
    Then I should see "Jäsennumerossa tulee olla vain numeroita"

  Scenario: edit member with incorrect values2
    When I am on the members page
    And I follow "11111"
    And I fill in "member[firstnames]" with ""
    And I fill in "member[surname]" with ""
    And I fill in "member[municipality]" with ""
    And I fill in "member[address]" with ""
    And I fill in "member[zipcode]" with ""
    And I fill in "member[postoffice]" with ""
    And I fill in "member[email]" with ""
    And I press "Tallenna muutokset"
    Then I should see "Sukunimi puuttuu"
    Then I should see "Kunta puuttuu"
    Then I should see "Osoite puuttuu"
    Then I should see "Postinumero puuttuu"
    Then I should see "Postitoimipaikka puuttuu"
    Then I should see "Sähköpostiosoite puuttuu"

  Scenario: I try to tag an indebted member as paid
    When I am on the members page
    And I check "member_2"
    And I press "Merkitse maksaneeksi"
    Then I should see "Maksustatus muutettu maksaneeksi"
    Then I click a text ".paymentstatus_menu .header"
    And I uncheck "Ei"
    And I click a text "#hide_layout"
    Then I should see "Mehiläinen"

  Scenario: I try to tag a paid member as paid
    When I am on the members page
    And I check "member_1"
    And I press "Merkitse maksaneeksi"
    Then I should see "Jäsen on jo maksanut"

  Scenario: I try to tag a paid member as indebted
    When I am on the members page
    And I check "member_1"
    And I press "Merkitse maksamattomaksi"
    Then I should see "Maksustatus muutettu maksamattomaksi"
    Then I click a text ".paymentstatus_menu .header"
    And I uncheck "Kyllä"
    And I click a text "#hide_layout"
    Then I should see "Meikeläinen"

  Scenario: I try to tag an indebted member as indebted
    When I am on the members page
    And I check "member_2"
    And I press "Merkitse maksamattomaksi"
    Then I should see "Jäsen on jo maksamaton"