class ErrorChecker
  def check_for_errors
    warn_if_error
    warn_if_errors
    warn_if_response_is_not_a_hash
    slow_down if requesting_too_fast?
  end

  private

  attr_reader :response, :ticker, :timeout

  def initialize(options = {})
    @response = options[:response]
    @ticker = options[:ticker]
    @timeout = options[:timeout]
  end

  def warn_if_error
    if response['error'] && !response['error'].empty?
      warn "#{ticker} ----- " + response['error']
    end
  end

  def warn_if_errors
    if response['errors'] && !response['errors'].empty?
      warn "#{ticker} ----- " + response['errors']
    end
  end

  def warn_if_response_is_not_a_hash
    if !response.is_a?(Hash)
      warn response.to_s
    end
  end

  def requesting_too_fast?
    response.include? "too quickly"
  end

  def slow_down
    puts "Pausing for #{timeout} seconds..."
    sleep timeout
    puts "Resuming..."
  end
end
