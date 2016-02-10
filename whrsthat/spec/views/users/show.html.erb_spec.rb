require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :phone => "Phone",
      :fname => "Fname",
      :lname_initial => "Lname Initial",
      :email => "Email",
      :prof_img_url => "Prof Img Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Fname/)
    expect(rendered).to match(/Lname Initial/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Prof Img Url/)
  end
end
