class Package
    include Mongoid::Document
    include CRAN::Repository

    field :name, type: String
    field :title, type: String    
    field :description, type: String
    field :version, type: String
    field :date_publication, type: Date

    field :status, type: String, default: "created"

    embeds_many :maintainers
    embeds_many :authors

    def download
        self.class.download(self.name, self.version)
    end

    # Fat models

    def self.retrieve_cran_metadata!
        retrieve_package_list[0, max_packages].each do |package|
            create!(name: package["Package"], version: package["Version"]) unless where(name: package["Package"], version: package["Version"]).exists?
        end
        all
    end

    def self.retrieve_cran_binaries!
        all.each do |package|
            package.download
            package.update(status: "downloaded")
        end
    end
end