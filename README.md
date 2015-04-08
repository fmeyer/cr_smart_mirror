CRAN smart mirror
---------------

Design Ideas
============

    CRANRepo::Package.index! -> index the full repo + download files locally 

    CRANRepo::Package.index_metadata! -> index only available packackes without downloading then. 
    CRANRepo::Package.index_package_contents! -> index only if localmetadata + localfiles available

private: 

    CRANRepo::Package.mirror -> download packages


    CRANRepo::Mirror.retrieve_package_list
    CRANRepo::Mirror.download(package_name, package_version)


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

config.yml 

    production:
        cran_mirror: http://cran.r-project.org/src/contrib/
        max_downloaded_packages: 0 # all packages

