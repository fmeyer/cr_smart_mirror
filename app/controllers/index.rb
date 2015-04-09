get '/' do
    @packages = Package.all
    
    erb :index
end
