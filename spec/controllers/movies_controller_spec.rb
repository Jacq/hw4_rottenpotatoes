require 'spec_helper'

describe MoviesController do
  def valid_attributes
    {}
  end
  def valid_session
    {}
  end

  before :each do
    @my_movie = mock('Movie', :title => 'My Movie', :director => '', :id => 1)
  end

  describe 'find movies with same director' do
    context 'no director info' do
      it 'should redirect to index template' do
		Movie.stub(:find).with(@my_movie.id.to_s).and_return(@my_movie)
        Movie.stub(:find_all_by_director).with(@my_movie.director).and_return([])
        post :find_movies_with_same_director, {:id => @my_movie.id}
        response.should redirect_to(movies_path)
      end
    
    context 'director info' do
      before :each do
	@m1 = mock('Movie', :director => 'director1', :id=>1)
	@m2 = mock('Movie', :director => 'director1', :id=>2)
        @my_movies = [@m1,@m2]		
        Movie.stub(:find_movies_with_same_director).with(@id.to_s).and_return(@my_movies)
      end
    end
  end

  before :each do
    @my_movie = mock('Movie', :title => 'My Movie', :director => '', :id => 1)
  end
  describe 'show' do
    it 'should render show' do
      Movie.stub(:find).with(@my_movie.id.to_s)
      get :show, {:id => @my_movie.id}
      response.should render_template('show')
    end
    it 'should assign the requested movie' do     
      Movie.stub(:find).with(@my_movie.id.to_s).and_return(@my_movie)
      get :show, {:id => @my_movie.id}
      assigns(:movie).should == @my_movie
    end
  end
  describe 'new' do
      it 'should render new' do
      get :new, {:id => @my_movie.id}
      response.should render_template('new')
    end
  end

  before :each do
    @my_movie = mock('Movie', :title => 'My Movie', :director => '', :id => 1)
  end
  describe '#create' do
    it 'should redirect to movies index page' do      
      Movie.stub(:create!).and_return(@my_movie)
      post :create, {:movie => {'title' => 'My Movie'}}
      response.should redirect_to(movies_path)
    end
  end
 end

  describe "GET show" do # ***
    it "assigns @movie" do
      movie = Movie.create! valid_attributes
      get :show, {:id => movie.to_param}, valid_session
      assigns(:movie).should eq(movie)
    end
  end
  describe "GET edit" do # ***
    it "assigns @movie" do
      movie = Movie.create! valid_attributes
      get :edit, {:id => movie.to_param}, valid_session
      assigns(:movie).should eq(movie)
    end
  end
  describe "create movie" do # ***
    describe "create with valid params" do
      it "create new Movie" do
        expect {post :create, {:movie => valid_attributes}, valid_session
		}.to change(Movie, :count).by(1)
      end

      it "assigns a new movie" do
        post :create, {:movie => valid_attributes}, valid_session
        assigns(:movie).should be_a(Movie)
        assigns(:movie).should be_persisted
      end

      it "redirects to new movie" do
        post :create, {:movie => valid_attributes}, valid_session
        response.should redirect_to(movies_path)
      end
    end

  end

  describe "PUT update" do # ***
    describe "update with valid params" do
      it "updates movie" do
        movie = Movie.create! valid_attributes
        Movie.any_instance.should_receive(:update_attributes!).with({'these' => 'params'}) 
        put :update, {:id => movie.to_param, :movie => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}, valid_session
        assigns(:movie).should eq(movie)
      end

      it "redirects to the movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}, valid_session
        response.should redirect_to(movie)
      end
    end

  end
  describe "DELETE destroy" do
    it "destroys movie" do
      movie = Movie.create! valid_attributes
      expect {
        delete :destroy, {:id => movie.to_param}, valid_session
      }.to change(Movie, :count).by(-1)
    end

    it "redirects movies" do
      movie = Movie.create! valid_attributes
      delete :destroy, {:id => movie.to_param}, valid_session
      response.should redirect_to(movies_url)
    end
  end
end
