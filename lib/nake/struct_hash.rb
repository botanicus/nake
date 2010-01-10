# encoding: utf-8

# options.extend(HashStructMixin)
# options.name
# options.force?
module Nake
  module HashStructMixin
    def method_missing(name, *args, &block)
      if args.empty? && block.nil?
        # options.name
        if value = self[name]
          return value
        # options.force?
        elsif name.to_s.match(/^(.*)\?$/) && value = self[$1.to_sym]
          return value
        end
      end

      super(name, *args, &block)
    end
  end
end
