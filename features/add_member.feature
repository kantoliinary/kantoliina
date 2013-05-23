Feature: add new member

  I want add new member and get and get information of that was successfull created

  Scenario: add new member
    When I am on the new member page

    And I fill in the following:
      | Etunimet         | jasen    |
      | Sukunimi         | aaa      |
      | Kunta            | gfdal    |
      | Katuosoite       | gda      |
      | Postinumero      | 12345    |
      | Postitoimipaikka | gda      |
      | Sähköposti       | gf@a.com |
      | Jäsennumero      | 123      |
    And I select "Varsinainen jäsen" from "Jäsenryhmä"
    And I select "2013/11/12" as the member "payday" date
    And I press "Lisää"
    Then I should see "Jasen lisatty!"
