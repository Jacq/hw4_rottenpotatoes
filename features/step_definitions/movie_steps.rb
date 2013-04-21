# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.  
    @movie = Movie.create(movie)
  end
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  @i1 = page.body.index(e1);
  @i2 = page.body.index(e2);
  assert @i1<@i2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |r|
	r = "\"ratings["+r+"]\""
	step('I '+(uncheck.nil? ? '' : uncheck )+'check '+r)
  end
end

Then /^(?:|I )should see all the movies/ do
	assert page.body.scan(/<tr>/).count == 11 # including header
end

When /^(?:|I )go to the edit page for "(.*)"$/ do |movie_name|
	@movie = Movie.find_by_title(movie_name)	
	step('I am on movies page '+@movie.id.to_s)
	step('I follow "Edit"')
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_name, director|
  	@movie = Movie.find_by_title(movie_name)
	assert @movie.director == director
end

When /^(?:|I )am on the details page for "(.*)"$/ do |movie_name|
	@movie = Movie.find_by_title(movie_name)	
	step('I am on movies page '+@movie.id.to_s)
end

Then /^(?:|I )should be on the Similar Movies page for "(.*)"$/ do |movie_name|
	assert !page.body.index("Movies With The Same Director As #{movie_name}").nil?
end


