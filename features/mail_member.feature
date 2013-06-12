Feature: send mail to members

  I want to see if we are sending mail to the right members


  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name           | fee  |
      | 1  | Ainaisjäsen    | 40.0 |
      | 2  | Varsinaisjäsen | 20.0 |

    Given the following members exist:
      | id | firstnames | surname | municipality | address       | zipcode | postoffice | email                 | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | deleted |
      | 1  | Janne      | Jäsen   | Vantaa       | Jokiniementie | 54321   | Stadi      | janne.jasen@yahoo.com | 12345        | 1              | 2013           | true          | 2013.01.01  | false   |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"


  Scenario: Select all to mail page and send mail
    And I should see "Janne"
    And I check "check_all"
    And I press "Lähetä sähköpostia"
    And I should see "Sähköpostin varmistus"
    And I fill in "subject" with "Otsikko"
    And I fill in "additional_message" with "viestia"
    And I press "Lähetä sähköposti"
    Then I should see "Sähköposti lähetetty"

  Scenario: Delete one on mail page
    And I should see "Janne"
    And I check "check_all"
    And I press "Lähetä sähköpostia"
    And I should see "Sähköpostin varmistus"
    And I press "Poista"
    Then I should not see "Janne"