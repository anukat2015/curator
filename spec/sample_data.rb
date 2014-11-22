def earnings_yield_data_1
    {
                       :symbol => "AAPL",
                   :total_debt => 35295000000.0,
              :total_debt_date => "2014-09-27",
                   :market_cap => 629384700370.0,
              :market_cap_date => "2014-10-27",
         :cash_and_equivalents => 13844000000.0,
    :cash_and_equivalents_date => "2014-09-27",
                         :ebit => 11472000000.0,
                    :ebit_date => "2014-09-27",
             :enterprise_value => 650835700370.0,
               :earnings_yield => 0.01762656841577401
    }
end

def earnings_yield_data_2
  {
                     :symbol => "SRCE",
                 :total_debt => 468492000.0,
            :total_debt_date => "2014-06-30",
                 :market_cap => 689213538.87,
            :market_cap_date => "2014-07-24",
       :cash_and_equivalents => 117378000.0,
  :cash_and_equivalents_date => "2014-06-30",
                       :ebit => 24110000.0,
                  :ebit_date => "2014-06-30",
           :enterprise_value => 1040327538.8699999,
             :earnings_yield => 0.023175393420987584
  }
end

def return_on_capital_data_1
  {
                :symbol => "AAPL",
                  :ebit => 11472000000.0,
             :ebit_date => "2014-09-27",
          :total_assets => 231839000000.0,
     :total_assets_date => "2014-09-27",
        :current_assets => 68531000000.0,
   :current_assets_date => "2014-09-27",
       :working_capital => 5083000000.0,
  :working_capital_date => "2014-09-27",
     :return_on_capital => 0.06812715643947717
  }
end

def return_on_capital_data_2
  {
                :symbol => "AIR",
          :total_assets => 2199500000.0,
     :total_assets_date => "2014-05-31",
        :current_assets => 1116900000.0,
   :current_assets_date => "2014-05-31",
       :working_capital => 714800000.0,
  :working_capital_date => "2014-05-31",
     :return_on_capital => 0.01874930455101814
  }
end

def csv_columns
  [
   "Symbol",
   "Ebit",
   "Ebit date",
   "Market cap",
   "Market cap date",
   "Cash and equivalents",
   "Cash and equivalents date",
   "Total debt",
   "Total debt date",
   "Enterprise value",
   "Earnings yield",
   "Total assets",
   "Total assets date",
   "Current assets",
   "Current assets date",
   "Working capital",
   "Working capital date",
   "Return on capital"
  ]
end
