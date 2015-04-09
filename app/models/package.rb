class Package
    include Mongoid::Document
    include CRAN::Repository

    field :name, type: String
    field :title, type: String    
    field :description, type: String
    field :version, type: String
    field :publication_date, type: Date

    field :status, type: String, default: "created"

    embeds_many :maintainers
    embeds_many :authors

    def fetch_cran_package_metadata!
        metadata = self.class.retrieve_package_metadata(name, version)

        update( title: metadata["Title"], 
                description: metadata["Description"], 
                publication_date: metadata["Date/Publication"], 
                status: "downloaded")
    end

    def self.fetch_cran_packages
        retrieve_package_list[0, max_packages].each do |package|
            create!(name: package["Package"], 
                    version: package["Version"]) unless where(  name: package["Package"], version: package["Version"]).exists? 
        end
        all
    end

    def self.all_with_versions
        all.group_by(&:name)
    end

    def to_s
        "#{name}, #{title}, #{version}, #{description}"
    end
end