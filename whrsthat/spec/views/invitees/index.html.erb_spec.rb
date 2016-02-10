require 'rails_helper'

RSpec.describe "invitees/index", type: :view do
  before(:each) do
    assign(:invitees, [
      Invitee.create!(
        :attending => false
      ),
      Invitee.create!(
        :attending => false
      )
    ])
  end

  it "renders a list of invitees" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
