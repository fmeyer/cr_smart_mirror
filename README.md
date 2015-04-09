CRAN smart mirror
---------------

Design Ideas
============

    CRAN::Package.index! -> index the full repo + download files locally 

    CRAN::Package.index_metadata! -> index only available packackes without downloading then. 
    CRAN::Package.index_package_contents! -> index only if localmetadata + localfiles available

private: 

    CRAN::Package.mirror -> download packages


    CRAN::Repository.retrieve_package_list
    CRAN::Repository.download(package_name, package_version)


### Model

    Package.first.status => {metadata, downloaded, indexed}

    Package.first.name
    Package.first.date
    Package.first.title 
    ...

    Package.new should raise an exception 

    Package.first.versions => should store old package version metadata 



Configuration 
=============

cran.yml 

    production:
        cran_mirror: http://cran.r-project.org/src/contrib/
        max_downloaded_packages: 0 # all packages
        local_mirror: public/mirror/