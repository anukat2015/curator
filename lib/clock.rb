require 'clockwork'

include Clockwork

every(2.weeks, 'Queueing interval job') { puts "This is a test" }
