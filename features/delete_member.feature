Feature: delete member

  I want delete the member and get and get information of that was successfully destroyed or get error messages

  Background: admins in database
    Given the following admins exist:
      | login | password  |
      | admin | qwerty123 |

    When I am on the login page
    And I fill in "login" with "admin"
    And I fill in "password" with "qwerty123"
    And I press "Login"
    And I follow "Jäsenien lisäykseen"
    When I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | aaa      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | 12345    |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 123      |
    And I select "Varsinainen jäsen" from "member_membergroup"
    And I select "2013/11/12" as the member "expirationdate" date
    And I press "Lisää"
    Then I should see "Jäsen lisatty!"
    And I follow "Listaa jäsenet"


  Scenario: delete member
       When I am on the members page
       And I press "Poista"
       Then I should see "Jäsen poistettu"
