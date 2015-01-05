module ErrorChecker
  def self.check_for_errors(response, ticker)
    if response['error'] && !response['error'].empty?
      warn "#{ticker} ----- " + response['error']
    elsif response['errors'] && !response['errors'].empty?
      warn "#{ticker} ----- " + response['errors']
    elsif !response.is_a?(Hash)
      warn response.to_s
    end
  end
end
