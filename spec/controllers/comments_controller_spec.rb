# frozen_string_literal: true

require 'rails_helper'
describe CommentsController do
  before(:each) do
    @blog = Blog.create('title'=>'Testing Blog', 'text'=>'Testing Blog')
    @comment = Comment.create('blog_id'=>@blog.id,'commenter'=>'Testing Comment','body'=>'Test comment')
  end
	#actions a logged-in user can perform on comments of a blog
  context 'logged-in user' do
    before do
      @user = User.create('email'=>'testemail@gmail.com','password'=>'test123')
      sign_in @user
    end
    it 'can comment on a blog' do 
      post :create, :params => { blog_id: @blog.id, comment: { 'commenter'=>'Tester','body'=>'Test comment body' } }
      expect(Comment.last.commenter).to eq('Tester')
      expect(Comment.count).to be(2)
    end
    it 'can update a comment on a blog ' do
      post :update, :params => { blog_id: @blog.id, id: @comment.id, comment: { 'commenter'=>'Updating comment','body'=>'Comment body' } }
      expect(Comment.count).to be(1)
      expect(Comment.last.commenter).to eq('Updating comment')
    end
  end
  
  #actions admin user can perform on comments of a blog
  context 'admin user' do
    before do
      @user = User.create('email'=>'testemail@gmail.com','password'=>'test123','admin'=>'true')
      sign_in @user
    end
    it 'can comment on a blog' do 
			post :create, :params => { blog_id: @blog.id, comment: { 'commenter'=>'Tester','body'=>'Test comment body' } }
			expect(Comment.last.commenter).to eq('Tester')
			expect(Comment.count).to be(2)
    end
    it 'can update comment on a blog' do
			post :update, :params => { blog_id: @blog.id, id: @comment.id, comment: { 'commenter'=>'Updating comment','body'=>'Comment body' } }
			expect(Comment.count).to be(1)
			expect(Comment.last.commenter).to eq('Updating comment')
    end
    it 'can delete comments on a blog' do
      delete :destroy, :params => { blog_id: @blog.id, id: @comment.id }
      expect(Comment.count).to be(0)
    end
  end

end