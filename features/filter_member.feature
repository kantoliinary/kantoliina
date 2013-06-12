Feature: filter members

  I want to search the exact member object and see the change on the screen

  Background: admins in database

    Given the following admins exist:
      | username | password  | email          |
      | admin    | qwerty123 | testi@testi.fi |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |


    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | Janne                 |
      | Sukunimi         | Jäsen                 |
      | Kunta            | Vantaa                |
      | Katuosoite       | Jokiniementie         |
      | Postinumero      | 54321                 |
      | Postitoimipaikka | Stadi                 |
      | Sähköposti       | janne.jasen@yahoo.com |
      | Jäsennumero      | 12345                 |

    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    And I follow "Listaa jäsenet"
    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | Liisa                      |
      | Sukunimi         | Mehiläinen                 |
      | Kunta            | Espoo                      |
      | Katuosoite       | Jokintie                   |
      | Postinumero      | 12345                      |
      | Postitoimipaikka | Stadi                      |
      | Sähköposti       | liisa.mehilainen@gmail.com |
      | Jäsennumero      | 12466                      |

    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    And I follow "Listaa jäsenet"
    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | Jaana                   |
      | Sukunimi         | Jäsen                   |
      | Kunta            | Espoo                   |
      | Katuosoite       | Jokintie                |
      | Postinumero      | 12345                   |
      | Postitoimipaikka | Stadi                   |
      | Sähköposti       | jaana.jasen@hotmail.com |
      | Jäsennumero      | 12543                   |

    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty"
    And I follow "Listaa jäsenet"

  Scenario: I filter members by first name
    When I am on the members page
    And I fill in "searchfield" with "Ja"
    And I press "Hae"
    Then I should see "Jaana"
    Then I should see "Janne"
    Then I should not see "Liisa"

#  Scenario: I filter members by last name
#    When I am on the members page
#    And I fill in "keyword" with "Jäsen"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I filter members by municipality
#    When I am on the members page
#    And I fill in "keyword" with "Espoo"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by address
#    When I am on the members page
#    And I fill in "keyword" with "jokin"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by address
#    When I am on the members page
#    And I fill in "keyword" with "espoo"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by zipcode
#    When I am on the members page
#    And I fill in "keyword" with "12345"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by post office
#    When I am on the members page
#    And I fill in "keyword" with "helsinki"
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should not see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I filter members by e-mail
#    When I am on the members page
#    And I fill in "keyword" with "liisa"
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should not see "Janne"
#    Then I should see "Liisa"
#
#  Scenario: I filter members by member number
#    When I am on the members page
#    And I fill in "keyword" with "125"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I filter members by membergroup
#    When I am on the members page
#    And I fill in "keyword" with "125"
#   And I press "Hae"
#    Then I should see "Jaana"
#    Then I should not see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I try to see deleted members
#    When I am on the members page
#    And I choose "membership_1"
#    And I press "Hae"
#    Then I should see "Jaana"
#    Then I should see "Janne"
#    Then I should see "Liisa"
#
#
#  Scenario: I try to see existing members
#    When I am on the members page
#    And I choose "membership_0"
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should not see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I try to search with two parametres
#    When I am on the members page
#    And I fill in "keyword" with "Janne,Vantaa"
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should see "Janne"
#    Then I should not see "Liisa"
#
#  Scenario: I try to search with tree parametres and extra whitespaces
#    When I am on the members page
#    And I fill in "keyword" with "Janne,    Vantaa   ,     Stadi     "
#    And I press "Hae"
#    Then I should not see "Jaana"
#    Then I should see "Janne"
#    Then I should not see "Liisa"

