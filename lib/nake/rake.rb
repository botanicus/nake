module Rake
  def self.method_missing
    raise NotImplementedError
  end

  def self.const_missing(constant)
    raise NotImplementedError, "Nake doesn't support Rake::#{constant}, please use normal Rake"
  end
end

# lazy-loading FTW!
def Object.const_missing(constant)
  if constant.eql?(:FileList)
    begin
      require "filelist"
      FileList
    rescue LoadError
      raise LoadError, "You have to install filelist gem!"
    end
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
