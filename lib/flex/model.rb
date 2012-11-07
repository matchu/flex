module Flex
  module Model

    def self.included(base)
      base.class_eval do
        @flex ||= ClassProxy::Model.new(base)
        def self.flex; @flex end
        extend FlexResult
      end
    end

    def flex
      @flex ||= InstanceProxy::Model.new(self)
    end

    def flex_source
      attributes.reject {|k| k.to_s =~ /^_*id$/}.to_json
    end

    def flex_indexable?
      true
    end

  end
end