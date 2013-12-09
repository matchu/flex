module Flex
  module ClassProxy
    module ModelSync

      def self.included(base)
        base.class_eval do
          attr_accessor :synced
        end
      end

      def sync(*synced)
        options = synced.extract_options!
        options[:callbacks] ||= [:save, :destroy]
        @synced = synced
        host_class.class_eval do
          raise NotImplementedError, "the class #{self} must implement :after_save and :after_destroy callbacks" \
                unless respond_to?(:after_save) && respond_to?(:after_destroy)
          after_save    { flex.sync } if options[:callbacks].include? :save
          after_destroy { flex.sync } if options[:callbacks].include? :destroy
        end
      end

    end
  end
end
