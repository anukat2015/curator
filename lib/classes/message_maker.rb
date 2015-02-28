class MessageMaker

  def make_message
    message_obj = "Sorting by "

    if sort_by == "return_on_capital"
      message_obj << "Return on Capital"
    elsif sort_by == "earnings_yield"
      message_obj << "Earnings Yield"
    else
      message_obj << "nothing"
    end

    if limit == "3000" || limit.nil?
      message_obj << "\nLimit: None"
    else
      message_obj << "\nLimit: #{limit}"
    end
  end

  private

  def initialize(params)
    @sort_by = params[:sort_by]
    @limit   = params[:limit]
  end

  attr_reader :sort_by, :limit
end
