require "rails_helper"

RSpec.describe WelcomeController, :type => :controller do
  describe 'GET #index' do
    before(:all) do
      CompanyReportByEarningsYield.delete_all
      CompanyReportByReturnOnCapital.delete_all
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

    it 'loads all of the ey_reports into @ey_reports' do
      ey_report1 = CompanyReportByEarningsYield.create!
      ey_report2 = CompanyReportByEarningsYield.create!
      get :index

      expect(assigns(:ey_reports)).to match_array([ey_report1, ey_report2])
    end

    it 'loads all of the roc_reports into @roc_reports' do
      roc_report1 = CompanyReportByReturnOnCapital.create!
      roc_report2 = CompanyReportByReturnOnCapital.create!
      get :index

      expect(assigns(:roc_reports)).to match_array([roc_report1, roc_report2])
    end
  end
end
