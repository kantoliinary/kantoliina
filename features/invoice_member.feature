Feature: invoice members

  I want to see if we are billing the right members

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name           | fee  |
      | 1  | Ainaisjäsen    | 40.0 |
      | 2  | Varsinaisjäsen | 20.0 |

    Given the following members exist:
      | id | firstnames | surname    | municipality | address       | zipcode | postoffice | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | deleted |
      | 1  | Janne      | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | janne.jasen@yahoo.com      | 12345        | 1              | 2013           | false         | 2013.01.01  | false   |
      | 2  | Liisa      | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | liisa.mehilainen@gmail.com | 12466        | 1              | 2013           | false         | 2013.01.01  | false   |



    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"


  Scenario: Select all
    And I should see "Liisa"
    And I should see "Janne"
    And I check "check_all"
    And I press "Luo laskut"
    And I should see "Laskun varmistus"

  Scenario: Select one
#    And I check "1"
#    And I press "Lähetä laskut"
#    And I should not see "Liisa"
#    And I should see "Janne"
#    And I should see "Laskunlähetys"
#

