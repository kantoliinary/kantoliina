Feature: Change paymentstatus to false

  I want to change member's paymentstatus to false and see if the changes was made

  Background: admins in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee     |
      | 1  | Ainaisjäsen | 10.0    |

    Given the following members exist:
      | id | firstnames  | surname | municipality | address       | zipcode | postoffice | email                 | membernumber | membergroup_id | membershipyear | paymentstatus  | deleted |
      | 1  | Janne       | Jäsen   | Vantaa       | Jokiniementie | 54321   | Stadi      | janne.jasen@yahoo.com | 12345        | 1              | 2013           | false          | false   |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    Then I am on the members page

  @javascript
  Scenario: I check all members and change their paymentstatus to true
    When I am on the members page
    Then I should see "Janne"
    And I check "check_all"
#    Given I expect to click "OK" on a confirmation box
    When I press "Maksettu"
    Then I should see "Maksustatus muutettu maksaneeksi"

  @javascript
  Scenario: I check all members and change their paymentstatus to false
    When I am on the members page
    Then I should see "Janne"
    And I check "check_all"
#    Given I expect to click "OK" on a confirmation box
    When I press "Maksamaton"
    Then I should see "Jäsen on jo maksamaton!"

