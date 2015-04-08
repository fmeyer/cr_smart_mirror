module CRANrepo
    class << self
        attr_accessor :config
    end

    #Configure block
    def self.configure
        self.config ||= Configuration.new
        yield(self.config)
    end
end