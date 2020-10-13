# frozen_string_literal: true
require 'rails_helper'
describe 'User creates a blog' ,:type=>:feature do
  it 'and check whether it is displaying or not' do
    @user = User.create('email'=>'testemail@gmail.com','password'=>'test123')
    visit '/users/sign_in'
    within('.new_user') do
      fill_in 'Email', :with => @user.email
      fill_in 'Password', :with => @user.password
    end
    click_button 'Log in'
    visit '/blogs/new'
    fill_in 'Title', :with => 'Testing Blog'
    fill_in 'Text', :with => 'Using feature spec'
    click_button 'Create Blog'
    visit '/blogs'
    expect(page.body).to have_text('Testing Blog')
    expect(page.body).to have_text('Using feature spec')
  end
end
