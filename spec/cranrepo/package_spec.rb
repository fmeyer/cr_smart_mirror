describe CRANrepo::Package do

    class Test 
        include CRANrepo::Package
    end
    
    context "download" do
        it "Should build a correct package filename" do
            package_filename = Test.class_eval { package_filename("package","0.0.1") } 
            expect(package_filename).to eq("package_0.0.1.tar.gz")
        end

        it "Should define the max download package number" do
            expect(Test.max_packages).to eq(50)
        end

        it "Should retrieve the package_list" do
            expect(Test).to receive(:get).with("http://mirr/PACKAGES")
            expect(Test).to receive(:process_metadata).and_return([])

            expect(Test.retrieve_package_list).to eq([])
        end
    end
end