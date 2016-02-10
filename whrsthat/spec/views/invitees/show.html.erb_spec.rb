require 'rails_helper'

RSpec.describe "invitees/show", type: :view do
  before(:each) do
    @invitee = assign(:invitee, Invitee.create!(
      :attending => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
  end
end
