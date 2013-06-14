Feature: Reminder members

  I want to see if the reminder functionality works

  Background: Admins, membergroups and members exist in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name           | fee  | onetimefee |
      | 1  | Ainaisjäsen    | 40.0 | true       |
      | 2  | Varsinaisjäsen | 20.0 | false      |

    Given the following members exist:
      | id | firstnames         | surname    | municipality | address       | zipcode | postoffice | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | deleted |
      | 1  | Maksamatonnormaali | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | janne.jasen@yahoo.com      | 12345        | 2              | 2013           | false         | 2013.01.01  | false   |
      | 2  | Maksanutainais     | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | liisa.mehilainen@gmail.com | 12466        | 1              | 2013           | true          | 2013.01.01  | false   |
      | 3  | Maksanutnormaali   | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | liisa.mehilainen@gmail.com | 12467        | 2              | 2013           | true          | 2013.01.01  | false   |
      | 4  | Maksamatonainais   | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | liisa.mehilainen@gmail.com | 12467        | 1              | 2013           | false         | 2013.01.01  | false   |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: Select all members and send a reminder to those applicable
    And I check "check_all"
    And I press "Luo karhukirjeet"
    Then I should see "Karhukirjeen varmistus"
    And I should not see "Maksanutainais"
    And I should see "Maksamatonnormaali"
    And I should not see "Maksanutnormaali"
    And I should see "Maksamatonainais"
    And I press "Lähetä karhukirjeet"
    Then I should see "Jäsenten listaus"
    And I should see "Karhukirjeet lähetetty"

  Scenario: Select all members and remove one in the reminder page
    And I check "check_all"
    And I press "Luo karhukirjeet"
    Then I should see "Karhukirjeen varmistus"
    And I should not see "Maksanutainais"
    And I should see "Maksamatonnormaali"
    And I should not see "Maksanutnormaali"
    And I should see "Maksamatonainais"
    And I press "Poista"
    Then I should not see "Janne"