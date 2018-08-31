Feature: Log in to Redfin website
Scenario: Log in with valid credentials

 Given I am on the Redfin homepage
 When I log in with username "and10rodr@gmail.com" and password "!NewPw"
 Then I should see a user menu with my first name, "Andy"