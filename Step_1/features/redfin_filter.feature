Feature: Search properties on Redfin website
Scenario: Search properties using 3 filters

 Given I am on the Redfin homepage

 When I enter "Irvine, CA" into the search field
 And click the Search button

 Then I should see the search results page for properties in "Irvine"

 When I expand the filters section
 And I set the minimum number of beds to "2"
 And set the property type to "House"
 And set the maximum square footage to "1,000"
 And click the Apply Filters button

 Then the results should have a minimum of "2" bedrooms
 And the results should be of the property type "House"
 And the results should be under "1000" sq ft