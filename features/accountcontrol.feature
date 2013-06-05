Feature: account control

  I want to edit the admin and partner password

  Background: admins and partners in database

    Given the following admins exist:
      | username | password  | email         |
      | admin    | qwerty123 | mail@mail.com |

    Given the following partners exist:
      | username | password  |
      | partner  | qwerty123 |


    When I fill inside "adminaccount" the following:
    And I press "Muokkaa"
    Then I should see "Tunnuksen muokkaus ei onnistunut!"

    When I fill inside "adminaccount" the following:
    And I fill in "username" with "admin"
    And I fill in "password" with "123qwerty"
    And I fill in "old_password" with "qwerty123"
    And I press "Muokkaa"
    Then I should see "Tunnusta muokattu."
