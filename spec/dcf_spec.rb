require 'spec_helper'

describe "DCF Module" do
  describe '#parse ' do
    before :each do
        @acne = DCF.parse(Fixture.load("ACNE")).first
    end

    it 'Should load a signle package and its contents' do
        expect(@acne["Package"]).to eq("ACNE")
        expect(@acne["Version"]).to eq("0.8.0")
    end
  end
end