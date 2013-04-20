require 'spec_helper'

describe "feeds/new" do
  before(:each) do
    assign(:feed, stub_model(Feed,
      :title => "MyString",
      :feed_url => "MyString",
      :html_url => "MyString",
      :type => ""
    ).as_new_record)
  end

  it "renders new feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", feeds_path, "post" do
      assert_select "input#feed_title[name=?]", "feed[title]"
      assert_select "input#feed_feed_url[name=?]", "feed[feed_url]"
      assert_select "input#feed_html_url[name=?]", "feed[html_url]"
      assert_select "input#feed_type[name=?]", "feed[type]"
    end
  end
end
