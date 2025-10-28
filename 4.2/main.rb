#-------------------------------------------------------------
# Exercise 5 Part 1 (Exception Handling)
#-------------------------------------------------------------
class ServiceUnavailable < StandardError; end

class MentalState
  def auditable?
    true
  end
  def audit!
    raise ServiceUnavailable, "Service Unavailable" unless auditable?
    Struct.new(:ok?).new(true)
  end
  def do_work
    puts "working with status=#{@status}"
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
  return MorningMentalState.new(:unknown) unless bedtime_mental_state.auditable?
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


begin
  require 'candy_service'
rescue LoadError
  class CandyMachine
    def prepare; @ready = true; end
    def ready?;  !!@ready; end
    def make!;   puts "[Candy] made a treat"; :ok; end
  end
end

class CandyMachineWrapper
  def initialize(machine = CandyMachine.new)
    @machine = machine
  end

  def prepare; @machine.prepare; end
  def ready?;  @machine.ready?; end

  def make!
    @machine.make!
  rescue StandardError => e
    raise "Candy make failed: #{e.message}"
  end
end

machine = CandyMachineWrapper.new
begin
  machine.prepare
  if machine.ready?
    machine.make!
  else
    puts "sadness"
  end
rescue => e
  warn "error: #{e.message}"
end