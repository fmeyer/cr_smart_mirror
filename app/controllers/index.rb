get '/' do
    @packages = Package.all_with_versions
    
    erb :index
end
