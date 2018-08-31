#*#*#*#*#*#*#*#*#

class HomePage < SitePrism::Page

	set_url 'https://redfin.com'

	element :current_tab, 'div.current'
	element :search_field, '#search-box-input'


	def click_search_button
		within('div.current') do
		    click_button('Search')
		    SearchResultsPage.new
		end
	end

end



class SearchResultsPage < SitePrism::Page

	element :expand_filters_button, 'button[data-rf-test-id=filterButton]'
	element :minimum_beds_dropdown, 'span.minBeds>span.input'
	element :minimum_beds_selections, 'span.minBeds>span.input>div.Flyout'
  element :maximum_sq_ft_dropdown, 'span.sqftMax>span.input'
  element :maximum_sq_ft_selections, 'span.sqftMax>span.input>div.Flyout'
  element :property_type_buttons, '#propertyTypeFilter'
  #elements :results, '[id*="MapHomeCard_"]'

  def apply_filters
    click_button('Apply Filters')
  end

end



# class TopMenuBar < SitePrism::Section
# end


###########################################################################
###########################################################################
###########################################################################
#*#*#*#*#*#*#*#*#

Given(/^I am on the Redfin homepage$/) do
  @home = HomePage.new
  @home.load
end


#*#*#*#*#*#*#*#*# HomePage

When(/^I enter "([^"]*)" into the search field$/) do |location|
	within @home.current_tab do
		@home.search_field.set location
	end
end



When(/^click the Search button$/) do
  @search_results = @home.click_search_button
end


#*#*#*#*#*#*#*#*# SearchResultsPage

Then(/^I should see the search results page for properties in "([^"]*)"$/) do |city|
  expect(@search_results).to have_content(city + ' Real Estate')
end



When(/^I expand the filters section$/) do
  @search_results.expand_filters_button.click
end

When(/^I set the minimum number of beds to "([^"]*)"$/) do |min_beds|
	@search_results.minimum_beds_dropdown.click
	#puts(find(:css, 'div.Flyout')['innerHTML']) # quick helper to find javascript generated element
	within(@search_results.minimum_beds_selections) do
    find(:xpath, '//div[@class="option"]/span[text()="' + min_beds + '"]').click # sets minimum beds to number specified in feature
	end
end



When(/^set the property type to "([^"]*)"$/) do |property_type|
  within(@search_results.property_type_buttons) do
    click_button(property_type)
  end
end



When(/^set the maximum square footage to "([^"]*)"$/) do |max_sqr_ft|
  @search_results.maximum_sq_ft_dropdown.click
  #puts(find(:css, 'div.Flyout')['innerHTML']) # quick helper to find javascript generated element
  within(@search_results.maximum_sq_ft_selections) do
    find(:xpath, '//div[@class="option"]/span[text()="' + max_sqr_ft + '"]').click # sets max square footage to 1000
  end
end



Then(/^click the Apply Filters button$/) do
  @search_results.apply_filters
end



Then(/^the results should have a minimum of "([^"]*)" bedrooms$/) do |num_beds|
  #num_results = @search_results.results.length # <--- this was giving me all the cards from when the page first loaded I think.
  num_results = page.all(:css, '[id*="MapHomeCard_"]').length # this is inconsistent because it takes a second to load the new home cards after the apply filter button has been clicked
  x = 0
  while x < num_results
    within('#MapHomeCard_' + x.to_s) do
        within('div.HomeStats') do
        num_baths = find(:css, 'div:nth-of-type(2) > div.value').text.to_i # number baths
        num_baths.should >= 2
      end
    end
      x+=1
  end
end

Then(/^the results should be of the property type "([^"]*)"$/) do |prop_type|
  num_results = page.all(:css, '[id*="MapHomeCard_"]').length
  x = 0
  while x < num_results
    within('#MapHomeCard_' + x.to_s) do
      if prop_type == 'House'
        find('span.homeIcon')
      end
      # more if statements to handle each property type
    end
    x+=1
  end
end



Then(/^the results should be under "([^"]*)" sq ft$/) do |sq_ft|
  num_results = page.all(:css, '[id*="MapHomeCard_"]').length
  x = 0
  while x < num_results
    within('#MapHomeCard_' + x.to_s) do
      within('div.HomeStats') do
        sqr_ft = find(:css, 'div:nth-of-type(3) > div.value').text # sqr footage
        sqr_ft = sqr_ft.sub(',','').to_i
        sqr_ft.should <= sq_ft.to_i
      end
    end
    x+=1
  end
end


#*#*#*#*#*#*#*#*# TopNavBar

When(/^I log in with username "([^"]*)" and password "([^"]*)"$/) do |username, password|
  click_button('Log In')
  begin
  click_button('Continue with Email') # added this just in case this is re-used in the middle of another test.
  rescue
  puts 'Skipping step'
  end
  fill_in 'emailInput', with: username
  fill_in 'passwordInput', with: password
  click_button('Sign In')
end



Then(/^I should see a user menu with my first name, "([^"]*)"$/) do |firstname|
  find(:xpath, "//span[text()=\""+firstname+"\"]")
end