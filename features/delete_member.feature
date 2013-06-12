Feature: Delete a new member

  I want to delete a member and see if the member was successfully destroyed

  Background: admins in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |

    Given the following members exist:
      | id | firstnames | surname     | municipality | address  | zipcode | postoffice | email              | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | deleted |
      | 1  | Matti      | Meikeläinen | Vaasa        | zigtie 5 | 00666   | Vaasa      | Matti.M@jeejee.com | 11111        | 1              | 2013           | true          | 2013.01.01  | false   |
      | 2  | Miska      | Meikeläinen | Vaasa        | zigtie 6 | 00666   | Vaasa      | Miska.M@jeejee.com | 11112        | 1              | 2012           | false         | 2013.01.01  | false   |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  @javascript
  Scenario: I try to delete a members from the list page
    When I am on the members page
    Then I should see "Matti"
    And I check "member_1"
    Given I expect to click "OK" on a confirmation box
    When I press "Poista"
    Then I should see "Jäsen poistettu"

  @javascript
  Scenario: I try to delete all members from the list page and press cancel on conf
    When I am on the members page
    Then I should see "Matti"
    And I check "check_all"
    Given I expect to click "cancel" on a confirmation box
    When I press "Poista"
    Then I should not see "Jäsen poistettu"

#  Scenario: deleting by main button
#    When I am on the members page
#    Then I should see "jasen"
#    And I check "check_all"
#    And I press "Poista Valitut"
#    Then I should not see "jasen"
