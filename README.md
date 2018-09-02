# Acorns Assignment

Hi! First of all, thank you for your time and for giving me the opportunity to show you my work.
So I split up the assignment into two folders, Step\_1 and Step\_2 to match the email describing the assignment.

## Step_1

To run the tests, make sure you have Firefox installed, and have geckodriver installed and added to your path.
Navigate to the _Step\_1_ folder and run the commands _bundle install_, then _bundle exec cucumber_

The folder contains two scenarios,

1. Signing in with valid username and password. Verify that you are signed in.

2. Searching for a property in a city with at least 3 filters. Verify that you get results back and that each result matches your criteria.


The first scenario was pretty straight-forward and I wasn't sure if making it into a SitePrism Page object was too much or not.

The second scenario was a bit trickier since the pages js was constantly changing/adding/removing elements, but I got most of it handled. The one part I got a bit stuck on was verifying that all the results matched the filters that were set, since it takes a second for the js to run right after the 'apply filters' button is clicked.

## Step_2

To run the tests, navigate to the _Step\_2_ folder and run the command _bundle exec rspec_

The folder contains one test,

1. Search for a particular property and verify the response status and that the response body contains the results that match your criteria.


The test was fairly simple to write, but I was having trouble getting access to the API for a bit, since I had no idea you had to specifically check 'Real Estate Professional' to have access to most of the APIs.


Thank you again for looking over my work and I hope to hear from you soon!



