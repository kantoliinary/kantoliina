Feature: Change paymentstatus to false

  I want to change member's paymentstatus to false and see if the changes was made

  Background: admins in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |

      | id | firstnames | surname          | municipality | address       | zipcode | postoffice | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | deleted    |
      | 1  | Janne      | Jäsen            | Vantaa       | Jokiniementie | 54321   | Stadi      | janne.jasen@yahoo.com      | 12345        | 3              | 2013           | true          | 2013.01.01  | false      |




  @javascript
  Scenario: I check all members and change their paymentstatus to false
    When I am on the members page
    Then I should see "jasen"
    And I check "check_all"
    Given I expect to click "OK" on a confirmation box
    When I press "Maksettu"
    Then I should see "Maksustatus muutettu"

