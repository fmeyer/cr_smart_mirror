#!/bin/sh 

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ruby -r$DIR/../config/environment.rb -e "Package.index_all"


