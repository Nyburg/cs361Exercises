#-------------------------------------------------------------
# Exercise 5 Part 1 (Exception Handling)
#-------------------------------------------------------------
class ServiceUnavailable < StandardError; end

class MentalState
  def auditable?
    true
  end
  def audit!
    raise ServiceUnavailable, "offline" unless auditable?
    Struct.new(:ok?).new(true)
  end
  def do_work
    # Amazing stuff...
  end
end

class MorningMentalState < MentalState
  def initialize(status = :unknown)
    @status = status
  end
end

def audit_sanity(bedtime_mental_state)
  raise "Service Unavailable" unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin
  bedtime_mental_state = MentalState.new
  new_state = audit_sanity(bedtime_mental_state)
rescue => e
  puts "error: #{e.message}"
end

#-------------------------------------------------------------
# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)
#-------------------------------------------------------------

class BedtimeMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  return nil unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work

#-------------------------------------------------------------
# Exercise 5 Part 3 (Wrapping APIs)
#-------------------------------------------------------------

require 'candy_service'

machine = CandyMachine.new
machine.prepare

if machine.ready?
  machine.make!
else
  puts "sadness"
end