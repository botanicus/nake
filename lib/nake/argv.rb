# encoding: utf-8

module Nake
  module ArgvParsingMixin
    def extract!
      self.inject(Hash.new) do |options, argument|
        case argument
        when /^--no-([^=]+)$/ # --no-git-repository
          options[$1.gsub("-", "_").to_sym] = false
          self.delete(argument)
        when /^--([^=]+)$/    # --git-repository
          options[$1.gsub("-", "_").to_sym] = true
          self.delete(argument)
        when /^--([^=]+)=([^,]+)$/ # --controller=post
          key, value = $1, $2
          options[key.gsub("-", "_").to_sym] = value.dup
          self.delete(argument)
        when /^--([^=]+)=(.+)$/    # --controllers=posts,comments
          key, value = $1, $2
          options[key.gsub("-", "_").to_sym] = value.split(",")
          self.delete(argument)
        else
          # just extract options and ignore others
        end
        options
      end
    end
  end
end
