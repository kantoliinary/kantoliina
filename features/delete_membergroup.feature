Feature: Edit a membergroup

  I want to delete a membergroup and see if it was really deleted


  Background: There is an admin and membergroups in the database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name      | fee  | onetimefee |
      | 1  | Rivijäsen | 10.0 | false      |
      | 2  | Bilejäsen | 2.0  | true       |

    Given the following members exist:
      | id | firstnames         | surname    | municipality | address       | zipcode | postoffice | country | email                      | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active |
      | 1  | Maksamatonnormaali | Jäsen      | Vantaa       | Jokiniementie | 54321   | Stadi      | Finland | janne.jasen@yahoo.com      | 12345        | 1              | 2013           | false         | 2013.01.01  | true   |
      | 2  | Maksanutainais     | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12466        | 1              | 2013           | true          | 2013.01.01  | true   |
      | 3  | Maksanutnormaali   | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12467        | 1              | 2013           | true          | 2013.01.01  | true   |
      | 4  | Maksamatonainais   | Mehiläinen | Espoo        | Jokintie      | 12345   | Stadi      | Finland | liisa.mehilainen@gmail.com | 12468        | 1              | 2013           | false         | 2013.01.01  | true   |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I am on the membergroups page
    Then I should see "Rivijäsen"
    And I should see "Bilejäsen"

  @javascript
  Scenario: Delete a membergroup
    Given I follow "Bilejäsen"
    Given I expect to click "OK" on a confirmation box
    When I press "Poista jäsenryhmä"
    Then I should see "Jäsenryhmä poistettu"
    And I should see "Rivijäsen"
    And I should not see "Bilejäsen"

  @javascript
  Scenario: Try to delete a membergroup with members
    Given I follow "Rivijäsen"
    Then I should not see "Poista jäsenryhmä"


  @javascript
  Scenario: Almost delete a membergroup
    Given I follow "Bilejäsen"
    And I expect to click "cancel" on a confirmation box
    When I press "Poista jäsenryhmä"
  #    Then I should see "Lisää jäsenryhmä"
    And I am on the membergroups page
    And I should see "Rivijäsen"
