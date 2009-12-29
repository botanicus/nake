# encoding: utf-8

module Nake
  module ArgvParser
    def self.extract!(args)
      args.dup.inject(Hash.new) do |options, argument|
        key, value = self.parse(argument)
        if key
          options[key] = value
          args.delete(argument)
        end
        options
      end
    end

    def self.extract(args)
      args.inject(Hash.new) do |options, argument|
        key, value = self.parse(argument)
        if key
          options[key] = value
        end
        options
      end
    end

    def self.parse!(argument)
      self.parse(argument) || raise("Argument #{argument} can't be parsed!")
    end

    def self.parse(argument)
      case argument
      when /^--no-([^=]+)$/ # --no-git-repository
        return [$1.gsub("-", "_").to_sym, false]
      when /^--([^=]+)$/    # --git-repository
        return [$1.gsub("-", "_").to_sym, true]
      when /^--([^=]+)=([^,]+)$/ # --controller=post
        key, value = $1, $2
        return [key.gsub("-", "_").to_sym, value.dup]
      when /^--([^=]+)=(.+)$/    # --controllers=posts,comments
        key, value = $1, $2
        return [key.gsub("-", "_").to_sym, value.split(",")]
      else
        return false
      end
    end
  end
end
