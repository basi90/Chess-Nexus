module Tableless
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
  end

  def persisted?
    false
  end
end
