require 'net/http'
require 'zlib'
require 'rubygems/package'
require 'dcf'


module CRAN::Repository
    FORMAT = ".tar.gz"

    module ClassMethods

        def max_packages
            CRAN.config.max_downloaded_packages ? CRAN.config.max_downloaded_packages : retrieve_package_list.size
        end 


        def retrieve_package_list
            @package_list ||=  get(packages_file)
            parse_package_metadata
        end

        def retrieve_package_metadata(package_name, package_version)
            @package_file = package_filename(package_name, package_version)

            download_package
            read_file_content
            parse_description_metadata
        end

        private

        def package_filename(package, version)
            "#{package}_#{version}#{FORMAT}"
        end


        def packages_file
            CRAN.config.mirror + "PACKAGES"
        end

        # TODO: fix 404 
        def download_package
            File.write(APP_ROOT+local_filename, get(remote_filename))
        end

        def parse_description_metadata
            Dcf.parse(@description_content).first
        end

        def parse_package_metadata
            @packages = Dcf.parse(@package_list)
        end

        def get(url)
            Net::HTTP.get(URI.parse(url))
        end

        def local_filename
            CRAN.config.local_mirror + @package_file
        end

        def remote_filename
            CRAN.config.mirror + @package_file
        end

        def read_file_content
            @description_content = Zlib::GzipReader.open(APP_ROOT+local_filename) do |gzipped|
                raw_content = Gem::Package::TarReader.new(gzipped)
                raw_content.find { |f| f.full_name =~ /\A[^\/]+?\/DESCRIPTION\z/ }.read
            end
        end
    end
    
    def self.included(receiver)
        receiver.extend         ClassMethods
    end
end
