class Scholarship < ActiveRecord::Base
  belongs_to :student
  def event_formatted
    if self.event.end_with?('.xml')
      self.event[0..-5]
    else
      self.event
    end
  end
end
