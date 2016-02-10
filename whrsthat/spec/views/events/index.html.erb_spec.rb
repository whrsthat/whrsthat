require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :title => "Title",
        :caption => "Caption",
        :time_at => "Time At",
        :event_img_url => "Event Img Url",
        :lng => 1,
        :lat => 2
      ),
      Event.create!(
        :title => "Title",
        :caption => "Caption",
        :time_at => "Time At",
        :event_img_url => "Event Img Url",
        :lng => 1,
        :lat => 2
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => "Time At".to_s, :count => 2
    assert_select "tr>td", :text => "Event Img Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
