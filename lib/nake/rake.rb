# encoding: utf-8

require "rake/filelist" # rake is distributed with Ruby 1.9 anyway

module Rake
  def self.method_missing
    raise NotImplementedError
  end

  def self.const_missing(constant)
    raise NotImplementedError, "Nake doesn't support Rake::#{constant}, please use normal Rake"
  end
end

module Nake
  module RakeDSL
    def task
    end

    def file
    end

    def rule
    end

    def multitask
      raise NotImplementedError, "Multitask method won't be supported"
    end
  end
end
