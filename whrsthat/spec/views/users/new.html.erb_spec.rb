require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :phone => "MyString",
      :fname => "MyString",
      :lname_initial => "MyString",
      :email => "MyString",
      :prof_img_url => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_phone[name=?]", "user[phone]"

      assert_select "input#user_fname[name=?]", "user[fname]"

      assert_select "input#user_lname_initial[name=?]", "user[lname_initial]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_prof_img_url[name=?]", "user[prof_img_url]"
    end
  end
end
