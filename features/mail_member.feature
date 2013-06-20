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
      | id | firstnames | surname | municipality | address       | zipcode | postoffice | country | email                 | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | active |
      | 1  | Janne      | Jäsen   | Vantaa       | Jokiniementie | 54321   | Stadi      | Finland | example@example.com | 12345        | 1              | 2013           | true          | 2013.01.01  | true   |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I should see "Janne"
    And I check "check_all"
    And I press "Lähetä sähköpostia"


  Scenario: Select all to mail page and send mail
    And I should see "Lähtevä viesti"
    And I fill in "subject" with "Otsikko"
    And I fill in "additional_message" with "viestia"
    And I press "Lähetä sähköposti"
    Then I should see "Sähköposti lähetetty"

  Scenario: Delete one on mail page
    And I should see "Lähtevä viesti"
    And I press "Poista"
    Then I should not see "Janne"

  Scenario: Add an attachment to the email
    And I should see "Lähtevä viesti"
    And I fill in "subject" with "Attachment by kantopiina"
    And I fill in "additional_message" with "a valid message"
    And I upload an exact file
    And I press "Lähetä sähköposti"
    Then I should see "Sähköposti ja liitetiedosto lähetetty"


  Scenario: I send an e-mail to a member
    And I should see "Lähtevä viesti"
    And I fill in "subject" with "Otsikko tässä"
    And I fill in "additional_message" with "Tämä on viesti"
    And I press "Lähetä sähköposti"
    And I should receive an email
    When I open the email with subject "Otsikko tässä"
    Then I should see "Otsikko tässä" in the email subject
    Then I should see "Tämä on viesti" in the email body
    Then I should see no attachment with the email

  Scenario: I send an e-mail to a member with an attachment
    And I should see "Lähtevä viesti"
    And I fill in "subject" with "Otsikko tässä"
    And I fill in "additional_message" with "Tämä on viesti"
    And I upload an exact file
    And I press "Lähetä sähköposti"
    And I should receive an email
    When I open the email with subject "Otsikko tässä"
    Then I should see "Otsikko tässä" in the email subject
    Then I should see "Tämä on viesti" in the email body
    Then I should see an attachment with the email

  Scenario: I send an e-mail from a different address
    And I should see "Lähtevä viesti"
    And I fill in "subject" with "Otsikko tässä"
    And I fill in "additional_message" with "Tämä on viesti"
    And I upload an exact file
    And I press "Lähetä sähköposti"
    And I should receive an email
    When I open the email with subject "Otsikko tässä"
    Then I should see "Otsikko tässä" in the email subject
    Then I should see "Tämä on viesti" in the email body
    Then I should see an attachment with the email

