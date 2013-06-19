Feature: reset password

  I want to reset an admin password

  Background: admins in database

    Given the following admins exist:
      | username | password  | email               |
      | admin    | qwerty123 | example@example.com |

    Given a clear email queue


    When I am on the login page
    And I follow "Palauta salasana"


  Scenario: I submit the correct e-mail address
    When I am on the new_password_reset page
    And I fill in "Otsikko" with "example@example.com"
    And I press "Palauta"
    And I should receive an email
    When I open the email
    Then I should see "Uusi salasana" in the email body



  Scenario: I submit an incorrect e-mail address
    When I am on the new_password_reset page
    And I fill in "Sähköposti" with "exampl@example.com"
    And I press "Palauta"
    And I should receive no emails



