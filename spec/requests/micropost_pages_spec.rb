require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it { should have_content('0 microposts') }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
      it "should have the correct post counts" do
        expect(page).to have_content('0 microposts' )
        fill_in 'micropost_content', with: "Lorem ipsum"
        click_button "Post"
        expect(page).to have_content('1 micropost ')
        fill_in 'micropost_content', with: "Lorem ipsum"
        click_button "Post"
        expect(page).to have_content('2 microposts')
      end
    end
  end

  describe "pagination" do

    #let(:user)  { FactoryGirl.create(:user) }
    before(:all) { 50.times { FactoryGirl.create(:micropost, user: user, content: "FooBar") } }
    #after(:all)  { user.microposts.delete_all }

    it { should have_selector('div.pagination') }

    it "should list each post" do
      user.microposts.paginate(page: 2).each do |post|
        page.should have_selector('li', text: post.content)
      end
    end
  end


  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "delete links" do
    describe "when visiting another users page" do
      let(:different_user) { FactoryGirl.create(:user) }
      before(:all) do
        5.times { FactoryGirl.create(:micropost, user: different_user, content: "FooBar") }
        visit user_path(different_user)
      end
      #after(:all)  {different_user.microposts.delete_all }
      it { should_not have_link('delete') }
    end
    describe "when visiting profile page" do
      before do
        5.times { FactoryGirl.create(:micropost, user: user, content: "FooBar") }
        visit user_path(user)
      end
      it { should have_link('delete') }
    end

  end

end