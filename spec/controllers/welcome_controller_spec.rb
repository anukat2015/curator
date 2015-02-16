require "rails_helper"

RSpec.describe WelcomeController, :type => :controller do
  describe 'GET #index' do
    before(:each) do
      Report.delete_all
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end

    it 'loads all of the reports into @reports' do
      report1 = Report.create!
      report2 = Report.create!
      get :index

      expect(assigns(:reports)).to match_array([report1, report2])
    end
  end
end
