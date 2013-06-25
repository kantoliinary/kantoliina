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
      | id | firstnames | surname    | municipality | address       | zipcode | postoffice | country | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active |
      | 1  | Janne      | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | Finland | janne.jasen@yahoo.com      | 12345        | 2              | 2015           | true          | 2015.01.01  | true   |
      | 2  | Liisa      | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12466        | 1              | 2014           | true          | 2014.01.01  | true   |
      | 3  | Jaana      | Jäsen      | Espoo        | Jokintie      | 12345   | Stadi      | Finland | jaana.jasen@hotmail.com    | 12543        | 1              | 2013           | false         | 2013.01.01  | true   |
      | 4  | Pelle      | Poistettu  | Limbo        | Olematontie   | 54321   | Poissa     | Finland | pelle.poistettu@eioo.com   | 99999        | 1              | 2013           | true          | 2013.01.01  | false  |


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

  @javascript
  Scenario: I order members by first name
    When I am on the members page
    And I click a text "#members_table thead #name"
    Then I should see "Jaana" before "Janne"
    And I should see "Janne" before "Liisa"
    And I should see "12543" before "12345"
    Then I click a text "#members_table thead #name"
    Then I should see "Janne" before "Jaana"
    And I should see "Liisa" before "Janne"
    And I should see "12345" before "12543"

  #kokeilu
#  @javascript
#  Scenario: I order members by first name
#    When I am on the members page
#    And I click a text "#members_table thead .name"
#    And row 2 column 3 of table "members_table" should be "Jaana"
#    Then I click a text "#members_table thead .name"


  @javascript
  Scenario: I order members by municipality
    When I am on the members page
    And I click a text "#members_table thead #municipality"
    And I should see "Liisa" before "Janne"
    And I should see "Espoo</td" before "Vantaa</td"
    And I click a text "#members_table thead #municipality"
    And I should see "Janne" before "Liisa"
    And I should see "Vantaa</td" before "Espoo</td"


  @javascript
  Scenario: I order members by membergroup
    When I am on the members page
    And I click a text "#members_table thead #membergroup"
    Then I should see "Liisa" before "Janne"
    And I should see "Ainaisjäsen</td" before "Varsinaisjäsen</td"
    And I click a text "#members_table thead #membergroup"
    Then I should see "Janne" before "Liisa"
    And I should see "Varsinaisjäsen</td" before "Ainaisjäsen</td"

  @javascript
  Scenario: I order members by membership year
    When I am on the members page
    And I click a text "#members_table thead #membershipyear"
    Then I should see "Liisa" before "Janne"
    And I should see "2013" before "2014"
    And I click a text "#members_table thead #membershipyear"
    Then I should see "Janne" before "Liisa"
    And I should see "2014" before "2013"

  @javascript
  Scenario: I order members by the date of the last invoice
    When I am on the members page
    And I click a text "#members_table thead #invoicedate"
    Then I should see "01.01.2013" before "01.01.2014"
    And I should see "Liisa" before "Janne"
    And I click a text "#members_table thead #invoicedate"
    Then I should see "Janne" before "Liisa"
    And I should see "01.01.2014" before "01.01.2013"

