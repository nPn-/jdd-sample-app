require 'spec_helper'

describe "StaticPages" do
  
  titles = ["Home", "Help", "About"]
  
  titles.each do |title|
    describe "#{title} Page" do  
      it "should the correct h1 and title for the #{title} page" do
        visit "/static_pages/#{title.downcase}"
        title_string = "Ruby on Rails Rutorial Sample App | #{title}"
        page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | #{title}")
        page.should have_selector('h1', :text => title)
      end
    end
  end
 
  
end
