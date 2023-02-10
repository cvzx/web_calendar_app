# frozen_string_literal: true

class AppointmentDecorator < SimpleDelegator
  def as_json(_args)
    {
      id: id,
      title: title,
      desc: description,
      start: datetime_range.first,
      end: datetime_range.last
    }
  end
end
