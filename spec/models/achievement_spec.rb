RSpec.describe Achievement do
  let(:training_path){ TrainingPath.create(name: "Blending In") }
  context ".all" do
    context "with no training paths in the database" do
      it "should return an empty array" do
        expect(Skill.all).to eq []
      end
    end
  end
end
