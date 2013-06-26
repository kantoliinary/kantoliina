Feature: order members

  I want to order members and see that they're in the right order

  Background: An admin, a membergroup and several members exist in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name           | fee   |
      | 1  | Ainaisjäsen    | 10.0  |
      | 2  | Varsinaisjäsen | 100.0 |

    Given the following members exist:
      | id | firstnames | surname    | municipality | address       | zipcode | postoffice | country | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active | support | lender | reminderdate |
      | 1  | Janne      | Jäsen      | Vantaa       | Jokiniementie | 65432   | Stadi      | Finland | janne.jasen@yahoo.com      | 12345        | 1              | 2015           | true          | 2015.01.01  | true   | false   | false  | 2015.01.01   |
      | 2  | Liisa      | Mehiläinen | Espoo        | Jokintie      | 23456   | Espoo      | Finland | liisa.mehilainen@gmail.com | 12466        | 1              | 2014           | true          | 2014.01.01  | true   | false   | false  | 2014.01.01   |
      | 3  | Jaana      | Jäsen      | Espoo        | Kantajantie   | 23456   | Turku      | Zaire   | jaana.jasen@hotmail.com    | 12543        | 2              | 2013           | false         | 2013.01.01  | true   | true    | true   | 2013.01.01   |
      | 4  | Pelle      | Poistettu  | Limbo        | Olematontie   | 65432   | Poissa     | Finland | pelle.poistettu@eioo.com   | 99999        | 1              | 2013           | true          | 2013.01.01  | false  | false   | false  | 2013.01.01   |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: I don't order anything
    When I am on the members page
    Then I should see "12345" before "12466"
    And I should see "Janne" before "Liisa"
    And I should see "12466" before "12543"
    And I should see "Janne" before "Jaana"

#  @javascript
#  Scenario: I order members by name
#    When I am on the members page
#    And I click a text "#members_table thead #name"
#    Then I should see "Jaana" before "Janne"
#    And I should see "Jäsen" before "Mehiläinen"
#    And I should see "12543" before "12345"
#    Then I click a text "#members_table thead #name"
#    Then I should see "Janne" before "Jaana"
#    And I should see "Mehiläinen" before "Jäsen"
#    And I should see "12345" before "12543"
#
#  @javascript
#  Scenario: I order members by municipality
#    When I am on the members page
#    And I click a text "#members_table thead #municipality"
#    And I should see "Liisa" before "Janne"
#    And I should see "Espoo</td" before "Vantaa</td"
#    And I click a text "#members_table thead #municipality"
#    And I should see "Janne" before "Liisa"
#    And I should see "Vantaa</td" before "Espoo</td"

#  Scenario: I order members by address
#    When I am on the members page
#    And I click a text "#column_select"
#    And I check "Osoite"
#    And I click a text "#hide_layout"
#    And I click a text "#members_table thead #address"
#    And I should see "Jokiniementie" before "Jokintie"
#    And I should see "Liisa" before "Jaana"
#    Then I click a text "#members_table thead #address"
#    And I should see "Jokintie" before "Jokiniementie"
#    And I should see "Jaana" before "Liisa"

  Scenario: I order members by post office
    When I am on the members page
    And I click a text "#column_select"
    And I check "Postitoimipaikka"
    And I click a text "#hide_layout"
    And I click a text "#members_table thead #postoffice"
    And I should see "Espoo" before "Stadi"
    And I should see "Janne" before "Jaana"
    Then I click a text "#members_table thead #postoffice"
    And I should see "Stadi" before "Espoo"
    And I should see "Janne" before "Jaana"

  Scenario: I order members by country
    When I am on the members page
    And I click a text "#column_select"
    And I check "Maa"
    And I click a text "#hide_layout"
    And I click a text "#members_table thead #country"
    And I should see "Finland" before "Zaire"
    And I should see "Janne" before "Jaana"
    Then I click a text "#members_table thead #country"
    And I should see "Zaire" before "Finland"
    And I should see "Jaana" before "Janne"

  Scenario: I order members by the date of the last reminder
    And I click a text "#column_select"
    And I check "Maksumuistutuksen lähetyspäivä"
    And I click a text "#hide_layout"
    And I click a text "#members_table thead #reminderdate"
    Then I should see "01.01.2013" before "01.01.2014"
    And I should see "Liisa" before "Janne"
    And I click a text "#members_table thead #reminderdate"
    Then I should see "Janne" before "Liisa"
    And I should see "01.01.2014" before "01.01.2013"
#
#  Scenario: I order members by zipcode
#    When I am on the members page
#    And I click a text "#column_select"
#    And I check "Postinumero"
#    And I click a text "#hide_layout"
#    And I click a text "#members_table thead #zipcode"
#    And I should see "23456" before "65432"
#    And I should see "Liisa" before "Janne"
#    Then I click a text "#members_table thead #zipcode"
#    And I should see "65432" before "23456"
#    And I should see "Janne" before "Liisa"


#  @javascript
#  Scenario: I order members by membergroup
#    When I am on the members page
#    And I click a text "#members_table thead #membergroup"
#    Then I should see "Liisa" before "Janne"
#    And I should see "Ainaisjäsen</td" before "Varsinaisjäsen</td"
#    And I click a text "#members_table thead #membergroup"
#    Then I should see "Janne" before "Liisa"
#    And I should see "Varsinaisjäsen</td" before "Ainaisjäsen</td"
#
#  @javascript
#  Scenario: I order members by membership year
#    When I am on the members page
#    And I click a text "#members_table thead #membershipyear"
#    Then I should see "Liisa" before "Janne"
#    And I should see "2013" before "2014"
#    And I click a text "#members_table thead #membershipyear"
#    Then I should see "Janne" before "Liisa"
#    And I should see "2014" before "2013"
#
#  @javascript
#  Scenario: I order members by the date of the last invoice
#    When I am on the members page
#    And I click a text "#members_table thead #invoicedate"
#    Then I should see "01.01.2013" before "01.01.2014"
#    And I should see "Liisa" before "Janne"
#    And I click a text "#members_table thead #invoicedate"
#    Then I should see "Janne" before "Liisa"
#    And I should see "01.01.2014" before "01.01.2013"

