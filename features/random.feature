Feature: random members

  I want to find a random member and see the member on the screen

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |

    Given the following members exist:
      | id | firstnames | surname    | municipality | country | address       | zipcode | postoffice | email                  | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active |
      | 1  | Janne      | Jäsen      | Vantaa       | Finland | Jokiniementie | 54321   | Stadi      | example@example.com    | 12345        | 1              | 2013           | true          | 2013.01.01  | true   |
      | 2  | Liisa      | Mehiläinen | Espoo        | Finland | Jokintie      | 12345   | Stadi      | example@example.com    | 12466        | 1              | 2013           | true          | 2013.01.01  | true   |
      | 3  | Jaana      | Jäsen      | Espoo        | Finland | Jokintie      | 12345   | Stadi      | example@example.com    | 12543        | 1              | 2013           | false         | 2013.01.01  | true   |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"


  Scenario: Find a random member when selected all and send mail to the lucky one
    And I check "check_all"
    And I press "Arvo jäsen"
    And I press "Lähetä sähköpostia"
    And I fill in "sender" with "kantoliinatesti@gmail.com"
    And I press "Lähetä sähköposti"
    And I should see "Sähköposti lähetetty"
    And I should receive an email
