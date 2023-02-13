# frozen_string_literal: true

class AppointmentDecorator < SimpleDelegator
  def as_json(_args)
    {
      id:,
      title:,
      desc: description,
      start: start_date,
      end: end_date
    }
  end
end
