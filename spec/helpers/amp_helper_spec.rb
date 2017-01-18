require "rails_helper"

RSpec.describe AmpHelper, type: :helper do
  describe "#image_tag" do
    subject { helper.image_tag(source) }
    context "given an absolute URL" do
      let(:source) { "http://placehold.it/300x300.png" }
      it "builds an amp-img tag for a given URL" do
        expect(subject).to include("<amp-img")
      end
      it "adds width and height" do
        expect(subject).to include("width=\"300\" height=\"300\"")
      end
    end
  end
end
