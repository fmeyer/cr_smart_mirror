describe CRAN::Repository do

    class Repo 
        include CRAN::Repository
    end
    
    context "download" do
        it "Should build a correct package filename" do
            package_filename = Repo.class_eval { package_filename("package","0.0.1") } 
            expect(package_filename).to eq("package_0.0.1.tar.gz")
        end

        it "Should define the max download package number" do
            expect(Repo.max_packages).to eq(50)
        end

        it "Should retrieve the package_list" do
            expect(Repo).to receive(:get).with("http://mirr/PACKAGES")
            expect(Repo).to receive(:parse_metadata).and_return([])

            expect(Repo.retrieve_package_list).to eq([])
        end
    end
end