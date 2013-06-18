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
      | 1  | Janne      | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | Finland | janne.jasen@yahoo.com      | 12345        | 2              | 2013           | true          | 2013.01.01  | true   |
      | 2  | Liisa      | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12466        | 1              | 2013           | true          | 2013.01.01  | true   |
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
    And I click a text "#members_table thead .name"
    Then I should see "Jaana" before "Janne"
    And I should see "Janne" before "Liisa"
    And I should see "12543" before "12345"
    Then I click a text "#members_table thead .name"
    Then I should see "Janne" before "Jaana"
    And I should see "Liisa" before "Janne"
    And I should see "12345" before "12543"

  @javascript
  Scenario: I order members by municipality
    When I am on the members page
    And I click a text "#members_table thead .municipality"
    And I should see "Liisa" before "Janne"
    And I should see "Espoo" before "Vantaa"
    And I click a text "#members_table thead .municipality"
    And I should see "Janne" before "Liisa"
    And I should see "Vantaa" before "Espoo"


  @javascript
  Scenario: I order members by membergroup
    When I am on the members page
    And I click a text "#members_table thead .membergroup"
    Then I should see "Liisa" before "Janne"
    And I should see "Ainaisjäsen" before "Varsinaisjäsen"
    And I click a text "#members_table thead .membergroup"
    Then I should see "Janne" before "Liisa"
    And I should see "Varsinaisjäsen" before "Ainaisjäsen"
