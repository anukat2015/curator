require "rails_helper"

RSpec.describe WelcomeController, :type => :controller do
  describe 'GET #index' do
    before(:all) do
      Report.delete_all

      Report.create!(symbol: 'AAPL', return_on_capital: 0.12, earnings_yield: 0.21)
      Report.create!(symbol: 'TSRA', return_on_capital: 0.21, earnings_yield: 0.12)
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

    it 'returns no reports if report_params is blank' do
      report_params = {}
      get :index
      expect(assigns(:reports)).to be nil
    end

    it 'returns reports according to passed params' do
      report1 = Report.where(symbol: 'AAPL').select(
        :symbol, :return_on_capital, :earnings_yield
      )
      report2 = Report.where(symbol: 'TSRA').select(
        :symbol, :return_on_capital, :earnings_yield
      )

      get :index, :sort_by => "return_on_capital", :limit => "1"

      expect(assigns(:reports).first.attributes).to eq(report2.first.attributes)
    end
  end
end
