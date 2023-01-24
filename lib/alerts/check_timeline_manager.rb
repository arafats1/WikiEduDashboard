# frozen_string_literal: true

class CheckTimelineManager
  def initialize(course)
    @course = course
    create_alerts
  end

  def create_alerts
    return unless @course.approved?
    # if course doesn't have any training module, it will not create an alert
    return if @course.training_module_ids.any?
    alert = Alert.create(type: 'CheckTimeline',
                         course_id: @course.id,
                         message: CheckTimeline.default_message)
    alert.email_content_expert
  end
end
