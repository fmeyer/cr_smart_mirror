class Package
    include Mongoid::Document


    field :name, type: String
    field :title, type: String    
    field :description, type: String
    field :version, type: String
    field :date_publication, type: Date

    embeds_many :maintainers
    embeds_many :authors

end