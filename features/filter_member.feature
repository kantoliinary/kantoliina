Feature: filter members

  I want to search the exact member object and see the change on the screen

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |

    Given the following members exist:
      | id | firstnames | surname    | municipality | address       | zipcode | postoffice | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | deleted |
      | 1  | Janne      | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | janne.jasen@yahoo.com      | 12345        | 1              | 2013           | true          | 2013.01.01  | false   |
      | 2  | Liisa      | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | liisa.mehilainen@gmail.com | 12466        | 1              | 2013           | true          | 2013.01.01  | false   |
      | 3  | Jaana      | Jäsen      | Espoo        | Jokintie      | 12345   | Stadi      | jaana.jasen@hotmail.com    | 12543        | 1              | 2013           | false         | 2013.01.01  | false   |
      | 4  | Pelle      | Poistettu  | Limbo        | Olematontie   | 54321   | Poissa     | pelle.poistettu@eioo.com   | 99999        | 1              | 2013           | true          | 2013.01.01  | true    |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

#  Scenario: I filter members by first name
#    When I am on the members page
#    And I fill in "searchfield" with "Ja"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I filter members by last name
#    When I am on the members page
#    And I fill in "searchfield" with "Jäsen"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I filter members by municipality
#    When I am on the members page
#    And I fill in "searchfield" with "Espoo"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by address
#    When I am on the members page
#    And I fill in "searchfield" with "jokin"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by address
#    When I am on the members page
#    And I fill in "searchfield" with "espoo"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by zipcode
#    When I am on the members page
#    And I fill in "searchfield" with "12345"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by post office
#    When I am on the members page
#    And I fill in "searchfield" with "helsinki"
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should not see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I filter members by e-mail
#    When I am on the members page
#    And I fill in "searchfield" with "liisa"
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should not see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by member number
#    When I am on the members page
#    And I fill in "searchfield" with "125"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I filter members by membergroup
#    When I am on the members page
#    And I fill in "searchfield" with "125"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should not see "Liisa"

# odottavat kayttiksen muokkausta

  @javascript
  Scenario: I try to see the column for membership status
    When I am on the members page
    Then I should not see "Poistettu"
    Then I click a text ".column_menu .header"
    And I check "deleted"
    Then I should see "Poistettu"

#  @javascript
#  Scenario: I try to see deleted members
#    Then I click a text ".column_menu .header"
#    And I check "deleted"
#    Then I click a text ".deleted_menu .header"
#    And I check ".deleted_menu .deleted_yes"
#    And I uncheck ".deleted_menu .deleted_no"
#    Then I click a text ".deleted_menu .header"
#    Then I should not see "Jaana"
#    And I should not see "Janne"
#    And I should not see "Liisa"
#    And I should see "Pelle"



#
#  Scenario: I try to search with two parameters
#    When I am on the members page
#    And I fill in "searchfield" with "Janne|Vantaa"
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I try to search with three parameters and extra whitespaces
#    When I am on the members page
#    And I fill in "searchfield" with "Janne|    Vantaa   |     Stadi     "
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should see "Janne"
#    Then I should not see "Liisa"

