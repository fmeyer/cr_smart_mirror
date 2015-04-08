require 'spec_helper'

describe Package do
  describe '#retrieve ' do

    it 'Should retrieve CRAN metadata' do
        expect(Package).to receive(:retrieve_package_list).and_return([{"Package" => "P", "Version" => "0.1"}])

        packages = Package.retrieve_cran_metadata!
        expect(packages.first.name).to eq("P")
        expect(packages.first.version).to eq("0.1")
        expect(packages.first.status).to eq("created")
    end    
  end
end