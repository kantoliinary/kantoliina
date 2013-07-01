Feature: See statistics about members

  I want to see that there are information about amount of members, deleted, yearly incomes, membergroups and municipalities

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  | onetimefee |
      | 1  | Ainaisjäsen | 10.0 | true       |
      | 2  | Perhejäsen  | 20.0 | false      |

    Given the following members exist:
      | id | firstnames | surname    | municipality | address       | zipcode | postoffice | country | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active | created_at |
      | 1  | Janne      | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | Finland | janne.jasen@yahoo.com      | 12345        | 2              | 2013           | true          | 2013.01.01  | true   | 2010.01.01 |
      | 2  | Liisa      | Mehiläinen | Espoo        | Jokintie      | 12346   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12466        | 1              | 2013           | true          | 2013.01.01  | true   | 2010.01.02 |
      | 3  | Jaana      | Jäsen      | Espoo        | Jokintie      | 12346   | Stadi      | Finland | jaana.jasen@hotmail.com    | 12543        | 2              | 2013           | false         | 2013.01.01  | true   | 2011.01.01 |
      | 4  | Pelle      | Poistettu  | Limbo        | Olematontie   | 54321   | Poissa     | Finland | pelle.poistettu@eioo.com   | 99999        | 1              | 2013           | true          | 2013.01.01  | false  | 2011.02.01 |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Tilastoja jäsenistä"

  Scenario: I should see basic data
    Then I should see "Jäseniä: 3"
    Then I should see "Poistettuja: 1"
    Then I should see "Tulot vuodessa (€): 50.0"

  Scenario: I should see membergroups
    Then I should see "Perhejäsen 2"
    Then I should see "Ainaisjäsen 1"

  Scenario: I should see municipalities
    Then I should see "Espoo 2"
    Then I should see "Vantaa 1"

  Scenario: I should see paid and indebted members
    Then I should see "Maksaneita: 2"
    Then I should see "Maksamattomia: 1"

# Fails in Firefox
#
  Scenario: I try to filter members by creation time
    When I fill in "startdate" with "2010/01/01"
    And I fill in "enddate" with "2011/02/10"
    And I press "Hae"
    Then I should see "12345"
    Then I should see "12543"
    Then I should see "12466"
    Then I should not see "99999"
    When I fill in "startdate" with "2010/01/02"
    And I fill in "enddate" with "2011/01/01"
    And I press "Hae"
    Then I should see "12543"
    Then I should see "12466"
    Then I should not see "99999"