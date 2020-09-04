module DynaModel
  module Validations
    extend ActiveSupport::Concern
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks

    module ClassMethods
    end
  end
end
