module ActiveModel
  module SecurePassword
    extend ActiveSupport::Concern

    module ClassMethods
      
      def has_secure_password
        # Load bcrypt-ruby only when has_secure_password is used.
        # This is to avoid ActiveModel (and by extension the entire framework) being dependent on a binary library.
        #gem 'bcrypt-ruby', '~> 3.0.0'
        gem 'bcrypt-ruby', '~> 3.1.0'
        require 'bcrypt'

        attr_reader :password

        validates_confirmation_of :password
        validates_presence_of     :password_digest

        include InstanceMethodsOnActivation

        if respond_to?(:attributes_protected_by_default)
          def self.attributes_protected_by_default
            super + ['password_digest']
          end
        end
      end
    end
  end
end
