class Maintainer
    include Mongoid::Document
    
    field :name, type: String
    field :email, type: String

    belongs_to :package

    def self.parse(maintainer)
      maintainer.split(/\sand\s|,/).map do |p|
        if match = p.strip.match(/([\w\ .-]+)(?:\<([\w@.-]+)\>)?/)
            p = self.find_or_create_by(name: $1.strip)
            p.update(email: $2)
            p
        end
      end
    end

    # index({ name: 1, email: 1 }, { unique: true })

end

class Author < Maintainer

end


