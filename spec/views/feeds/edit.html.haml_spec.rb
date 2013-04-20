require 'spec_helper'

describe "feeds/edit" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed,
      :title => "MyString",
      :feed_url => "MyString",
      :html_url => "MyString",
      :type => ""
    ))
  end

  it "renders the edit feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", feed_path(@feed), "post" do
      assert_select "input#feed_title[name=?]", "feed[title]"
      assert_select "input#feed_feed_url[name=?]", "feed[feed_url]"
      assert_select "input#feed_html_url[name=?]", "feed[html_url]"
      assert_select "input#feed_type[name=?]", "feed[type]"
    end
  end
end
