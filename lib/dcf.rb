require 'yaml' 

# The instruction file explains about using treetop-dcf, but YAML works 
# fine with. 
module DCF
    def self.parse(input)
        input.split("\n\n").collect { |p| YAML::load(p) }
    end
end
