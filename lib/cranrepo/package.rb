require 'net/http'

module CRANrepo::Package
    PACKAGES_FILE = CRANrepo.config.cran_mirror + "PACKAGES"
    FORMAT = ".tar.gz"

    module ClassMethods


        def max_packages
            CRANrepo.config.max_downloaded_packages ? CRANrepo.config.max_downloaded_packages : retrieve_package_list.size
        end 

        def package_filename(package, version)
            "#{package}_#{version}#{FORMAT}"
        end

        def retrieve_package_list
            @package_list ||=  get(PACKAGES_FILE)
            parse_metadata
        end

        private

        def download_all
            retrieve_package_list[0, max_packages].each do |package|
                download(package["Package"], package["Version"]) 
            end
        end

        # TODO: fix 404 
        def download(package_name, package_version)
            package = package_filename(package_name, package_version)
            File.write(CRANrepo.config.local_mirror + package, get(CRANrepo.config.cran_mirror + package))
        end

        def parse_metadata
            @packages = DCF.parse(@package_list)
        end

        def get(url)
            puts url
            Net::HTTP.get(URI.parse(url))
        end
    end
    
    def self.included(receiver)
        receiver.extend         ClassMethods
    end
end