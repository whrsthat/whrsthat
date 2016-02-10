require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :phone => "Phone",
        :fname => "Fname",
        :lname_initial => "Lname Initial",
        :email => "Email",
        :prof_img_url => "Prof Img Url"
      ),
      User.create!(
        :phone => "Phone",
        :fname => "Fname",
        :lname_initial => "Lname Initial",
        :email => "Email",
        :prof_img_url => "Prof Img Url"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Fname".to_s, :count => 2
    assert_select "tr>td", :text => "Lname Initial".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Prof Img Url".to_s, :count => 2
  end
end
