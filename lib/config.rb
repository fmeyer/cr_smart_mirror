module Config
	class << self
		attr_accessor :config
	end

    #Configure block
	def self.load
		self.config ||= Configuration.new
		yield(self.config)
	end


	class Configuration
		attr_accessor :cran_mirror
	end
end
