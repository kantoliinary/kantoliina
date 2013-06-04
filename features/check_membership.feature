Feature: check member status

  I want to check member status as a partner

  Background: admins in database

    Given the following admins exist:
      | username | password  |
      | admin    | qwerty123 |

    Given the following partners exist:
      | username | password  |
      | partner  | qwerty123 |

    Given the following membergroups exist:
      | id | name        | fee  |
      | 1  | Ainaisjäsen | 10.0 |

#    Given the following members exist:
#      | id | firstnames | surname     | municipality | address  | zipcode | postoffice | email              | membernumber | membergroup_id | membershipyear | paymentstatus | invoicedate | membership |
#      | 1  | Matti      | Meikeläinen | Vaasa        | zigtie 5 | 666     | Vaasa      | Matti.M@jeejee.com | 11111        | 1              | 2013           | true          | 2013.01.01  | true       |
#      | 2  | Miska      | Meikeläinen | Vaasa        | zigtie 6 | 666     | Vaasa      | Miska.M@jeejee.com | 11112        | 1              | 2012           | false         | 2013.01.01  | false      |

    When I am on the login page
    And I fill in "username" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | aaa      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | 12345    |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 11111    |
    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    And I follow "Listaa jäsenet"

    And I follow "Lisää jäsen"
    When I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | bbb      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | 12345    |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 11112    |
    And I select "Ainaisjäsen" from "member[membergroup_id]"
    And I press "Lisää"
    Then I should see "Jäsen lisätty!"
    And I follow "Listaa jäsenet"





    When I am on the partner_login page
    And I fill in "username" with "partner"
    And I fill in "password" with "qwerty123"
    And I press "Login"

  Scenario: check for a member with a valid membership status
    When I am on the partners page
    And I fill in "number" with "11111"
    And I press "Hae"
    Then I should see "Henkilön jäsenyys on voimassa."

#  Scenario: check for a member with an invalid membership status
#    When I am on the partners page
#    And I fill in "number" with "11112"
#    And I press "Hae"
#    Then I should see "Henkilön jäsenyys ei ole voimassa."

  Scenario: check for a member with an invalid member number
    When I am on the partners page
    And I fill in "number" with "11113"
    And I press "Hae"
    Then I should see "Henkilön jäsenyys ei ole voimassa."
