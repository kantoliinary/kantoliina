Feature: reset password

  I want to reset an admin password

  Background: admins in database

    Given the following admins exist:
      | username | password  | email                    |
      | admin    | qwerty123 | kantoliinatesti@gmail.com |

#    Given a clear email queue


    When I am on the login page
    And I follow "Palauta salasana"


  Scenario: I submit the correct e-mail address
    When I am on the new_password_reset page
    And I fill in "Sähköposti" with "kantoliinatesti@gmail.com"
    Then I press "Palauta"
    Then "kantoliinatesti@gmail.com" should receive 1 emails
    When I open the email
    Then I should see "Saajan tilinumero: FI22 1228 3000 0038 46"



#    When I open the email
#    Then I should see "confirm" in the email body
#    When I follow "confirm" in the email
#    Then I should see "Confirm your new account"



#  Scenario: I submit an incorrect e-mail address




