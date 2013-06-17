Feature: check member status

  I want to check member status as a partner

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following partners exist:
      | username | password  |
      | partner  | qwerty123 |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |

    Given the following members exist:
      | id | firstnames | surname     | municipality | address  | zipcode | postoffice | country | email              | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active |
      | 1  | Matti      | Meikeläinen | Vaasa        | zigtie 5 | 00666   | Vaasa      | Finland | Matti.M@jeejee.com | 11111        | 1              | 2013           | true          | 2013.01.01  | true   |
      | 2  | Miska      | Meikeläinen | Vaasa        | zigtie 6 | 00666   | Vaasa      | Finland | Miska.M@jeejee.com | 11112        | 1              | 2012           | false         | 2013.01.01  | false  |


    When I am on the partner_login page
    And I fill in "username" with "partner"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: check for a member with a valid membership status
    When I am on the partners page
    And I fill in "number" with "11111"
    And I press "Hae"
    Then I should see "Henkilön jäsenyys on voimassa."

  Scenario: check for a member with an invalid membership status
    When I am on the partners page
    And I fill in "number" with "11112"
    And I press "Hae"
    Then I should see "Henkilön jäsenyys ei ole voimassa."

  Scenario: check for a member with an invalid member number
    When I am on the partners page
    And I fill in "number" with "11113"
    And I press "Hae"
    Then I should see "Henkilön jäsenyys ei ole voimassa."
