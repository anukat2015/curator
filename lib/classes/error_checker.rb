class ErrorChecker
  def initialize(response:, ticker:)
    @response = response
    @ticker = ticker
  end

  def self.check_for_errors
    warn_if_error
    warn_if_errors
    warn_if_response_is_not_a_hash
    slow_down(60) if requesting_too_fast?
  end

  private

  attr_reader :response, :ticker

  def self.warn_if_error
    if response['error'] && !response['error'].empty?
      warn "#{ticker} ----- " + response['error']
    end
  end

  def self.warn_if_errors
    if response['errors'] && !response['errors'].empty?
      warn "#{ticker} ----- " + response['errors']
    end
  end

  def self.warn_if_response_is_not_a_hash
    if !response.is_a?(Hash)
      warn response.to_s
    end
  end

  def self.requesting_too_fast?
    response.include? "too quickly"
  end

  def self.slow_down(time)
    puts "Pausing for #{time} seconds..."
    sleep time
    puts "Resuming..."
  end
end