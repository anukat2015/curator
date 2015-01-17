module ErrorChecker
  def self.check_for_errors(response, ticker)
    if response['error'] && !response['error'].empty?
      warn "#{ticker} ----- " + response['error']
    elsif response['errors'] && !response['errors'].empty?
      warn "#{ticker} ----- " + response['errors']
    elsif !response.is_a?(Hash)
      warn response.to_s
        slow_down if response.include? "too quickly"
    end
  end

  private

  def self.slow_down
    time_out = 30
    puts "Pausing for #{time_out} seconds..."
    sleep time_out
    puts "Resuming..."
  end
end
