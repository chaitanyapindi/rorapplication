require 'rails_helper'
describe BlogsController do
  #Create a blog before performing each test
  before(:each) do
    @blog = Blog.create("title"=>"Testing Blog", "text"=>"Testing Blog")
  end

  #Actions a logged out user can perform on this application
  context "loggedout user can" do
    it "only view blogs" do
      get :show, :params => {"id" => @blog.id }
      expect(response).to be_successful
      expect(response.response_code).to be(200)
    end
  end

  #Actions a logged-in user can perform on this application
  context "loggedin user" do
    before do
      @user = User.create('email'=>'testemail@gmail.com','password'=>'test123')
      sign_in @user
    end

    it "can view blogs" do
      get :show, :params => {"id" => @blog.id }
      expect(response).to be_successful
    end

    it "can create a new blog" do 
      post :create, :params => {"blog"=>{"title"=>"new test", "text"=>"new blog test"}}
      expect(Blog.last.title).to eq("new test")
      expect(Blog.count).to be(3)
    end

    it "can update blogs" do
      post :update, :params => {"id" => @blog.id ,"blog"=>{"title"=>"testing", "text"=>"new blog test"}}
      @blog.reload
      expect(Blog.count).to be(2)
      expect(@blog.title).to eq("testing")
      expect(Blog.last.title).to eq("testing")
    end
  end
  
  #Actions a admin user can perform on this application
  context "admin user" do
    before do
      @user = User.create('email'=>'testemail@gmail.com','password'=>'test123','admin'=>'true')
      sign_in @user
    end

    it "allow shows a post" do
      get :show, :params => {"id" => @blog.id }
      expect(response).to be_successful
    end

    it "allow create posts" do 
      post :create, :params => {"blog"=>{"title"=>"new test", "text"=>"new blog test"}}
      expect(Blog.count).to be(3)
      expect(Blog.last.title).to eq("new test")
    end

    it "allow update posts" do
      post :update, :params => {"id" => @blog.id ,"blog"=>{"title"=>"new testing", "text"=>"new blog test"}}
      @blog.reload
      expect(Blog.count).to be(2)
      expect(@blog.title).to eq("new testing")
    end
    
    it "allow delete posts" do
      delete :destroy, :params => {"id" => @blog.id}
      expect(response).to redirect_to('/blogs')
      expect(Blog.count).to be(1)
    end
  end
end