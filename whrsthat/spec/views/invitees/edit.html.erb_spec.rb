require 'rails_helper'

RSpec.describe "invitees/edit", type: :view do
  before(:each) do
    @invitee = assign(:invitee, Invitee.create!(
      :attending => false
    ))
  end

  it "renders the edit invitee form" do
    render

    assert_select "form[action=?][method=?]", invitee_path(@invitee), "post" do

      assert_select "input#invitee_attending[name=?]", "invitee[attending]"
    end
  end
end
