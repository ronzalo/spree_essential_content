# frozen_string_literal: true

class DatetimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    date = begin
             DateTime.parse(value.to_s)
           rescue StandardError
             ArgumentError
           end
    record.errors.add(attribute, I18n.t(:invalid_date_time, scope: %i[activerecord errors messages])) if date == ArgumentError
  end
end
