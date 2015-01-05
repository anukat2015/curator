module ErrorChecker
  def self.check_for_errors(response, ticker)
    if response['error']
      puts "#{ticker} ----- " + response['error']
    elsif response['errors'] && !response['errors'].empty?
      puts "#{ticker} ----- " + response['errors']
    end
  end
end
