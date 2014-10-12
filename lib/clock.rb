require 'clockwork'

include Clockwork

every(10.seconds, 'Queueing interval job') { puts "Hey Cal what's up?" }
