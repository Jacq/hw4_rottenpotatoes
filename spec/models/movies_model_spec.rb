require 'spec_helper'

describe Movie do
  def valid_attributes
    {}
  end
  def valid_session
    {}
  end

  describe "all_ratings" do
    it "returns all ratings" do
      Movie.all_ratings.should == ["G", "PG", "PG-13", "NC-17", "R"]
    end
  end

  describe "create" do
     it "create movie" do
       parameteres = Hash.new  	
       parameteres= { "title"=>"tit", "rating"=>"rat",
		"description"=>"des", "release_date"=>"1/1/2013",
		"created_at"=>"2/1/2013","updated_at"=>"3/1/2013",
		"director"=> "dir"}
       Movie.create!(parameteres)
       movie=Movie.find(1)
       movie.title.should == "tit"
       movie.director.should == "dir"
       movie=Movie.find_by_description("des")
       movie.rating.should == "rat"
     end
  end

  describe "find by rating" do
     it "find by and order" do
	movies=Movie.find_all_by_rating(["G", "PG", "PG-13", "NC-17", "R"], 'rating')
	#Movie.find_all_by_rating(["G", "PG", "PG-13", "NC-17", "R"], 'title')
	movies.should_not be_nil
    end
  end
end
