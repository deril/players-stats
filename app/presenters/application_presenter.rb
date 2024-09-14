# frozen_string_literal: true

class ApplicationPresenter
  def initialize(*pos, **args)
    fail ArgumentError, "Positional Args not Allowed for presenters" unless pos.empty?

    args.each do |key, val|
      instance_variable_set(:"@#{key}", val)
      self.class.send(:attr_reader, key) unless respond_to?(key)
    end
  end
end
