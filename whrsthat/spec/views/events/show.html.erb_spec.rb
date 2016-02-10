require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :title => "Title",
      :caption => "Caption",
      :time_at => "Time At",
      :event_img_url => "Event Img Url",
      :lng => 1,
      :lat => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Caption/)
    expect(rendered).to match(/Time At/)
    expect(rendered).to match(/Event Img Url/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
