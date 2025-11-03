
class LaunchDiscussionWorkflow
  def initialize(discussion, host, participants_email_string)
    @discussion = discussion
    @host = host
    @participants_email_string = participants_email_string
    @participants = []
  end

  def run
    return unless valid?

    begin
      ActiveRecord::Base.transaction do
        @discussion.save!
        create_discussion_roles!
      end
      puts "Discussion launched successfully!"
    rescue StandardError => e
      puts "Error launching discussion: #{e.message}"
    end
  end

  def generate_participant_users_from_email_string
    return if @participants_email_string.nil? || @participants_email_string.strip.empty?

    emails = @participants_email_string.split.uniq.map(&:downcase)
    @participants = emails.map do |email|
      User.create(email: email, password: Devise.friendly_token)
    end
  end

  private

  def valid?
    if @discussion.nil? || @host.nil?
      puts "Missing discussion or host."
      return false
    end
    true
  end

  def create_discussion_roles!
    DiscussionRole.create(user: @host, discussion: @discussion, role: "host")
    @participants.each do |participant|
      DiscussionRole.create(user: participant, discussion: @discussion, role: "participant")
    end
  end
end