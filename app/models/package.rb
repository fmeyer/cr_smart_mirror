class Package
    include Mongoid::Document
    include CRAN::Repository

    field       :name, type: String
    field       :title, type: String    
    field       :description, type: String
    field       :version, type: String
    field       :publication_date, type: Date

    field       :status, type: String, default: "created"

    has_one     :maintainer, autobuild: true
    has_many    :authors


    def maintainer_name
        maintainer.name
    end

    def authors_names
        authors.map {|a| a.name}.join(", ")
    end

    def fetch_cran_package_metadata!
        metadata = self.class.retrieve_package_metadata(name, version)

        update( title: metadata["Title"], 
                description: metadata["Description"], 
                publication_date: metadata["Date/Publication"], 
                status: "indexed",
                authors: Author.parse(metadata["Author"]),
                maintainer: Maintainer.parse(metadata["Maintainer"]).first)
        save
    end

    def self.fetch_cran_packages
        retrieve_package_list[0, max_packages].each do |package|
            create!(name: package["Package"], 
                    version: package["Version"]) unless where(  name: package["Package"], version: package["Version"]).exists? 
        end
        all
    end

    def self.index_all 
        fetch_cran_packages
        all.each do |p|
            puts "indexing package #{p.name}"
            p.fetch_cran_package_metadata!
        end
    end

    def self.all_with_versions
        all.group_by(&:name)
    end
end