CRAN smart mirror
---------------


Design Ideas
============

I decided to encapsulate all repository integration to its own library.
Thus, I can move it to a gem in some imaginary future. 
I prefer to use fat models with working with databases; the "repository"
pattern fits quite well when you need to avoid creating unnecessary
helper classes. I decided to implement a regular expression to parse the
name|email format from users and contributors.
MongoDB comes in handy when working with this kind of data, I wouldn't
dare to use a relational database to store this metadata. 
The application lacks a logging system, whenever I interface with
another server, I tend abuse on logging. Unfortunately, I didn't have
enough time to refactory and fit a better logger. 

If I had more time I'd split up the CRAN::Repository in two, one logical
interface, dealing with metadata, and other to perform file retrieve. 

My first approach was to use libarchive to expand the .tar.gz,
unfortunately, my Mac wasn't collaborating and I couldn't compile the lib. So, I've found this trick http://stackoverflow.com/a/11505644 to open a tar file using Gem::Package::TarReader


I could've used a better scheduler than crontab, but I had to finish this 
thing before Christmas =) 

Best, 
FM

Configuration 
=============

APP config file `cran.yml` 

    production:
        cran_mirror: http://cran.r-project.org/src/contrib/
        max_downloaded_packages: 0 # all packages
        local_mirror: public/mirror/

DB config file `mongoid.yml`

    production:
      sessions:
        default:
          database: crsmartmirror_production
          hosts:
            - localhost:27017



### Scheduling 

Setup the following scheduler on app_user's crontab.

    0 12 * * * ${BASE_APP}bin/index.sh

Usage
=====

    $ bundle
    $ ./bin/index.sh # to retrieve the packages
    $ foreman start


Future
====== 

-   The application needs a better log system, 
-   Better error handling
-   Index using elastic search aiming a package query interface
