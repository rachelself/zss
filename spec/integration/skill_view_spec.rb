RSpec.describe "Viewing the skill itself" do
  let!(:path1){ TrainingPath.create(name: "Running") }
  let!(:path2){ TrainingPath.create(name: "Hand-to-Hand Combat") }

  context "a skill that is in the list" do
    let(:output){ run_zss_with_input('2', '2') } # Hand-to-Hand Combat

    before do
      Skill.create(name: "Walking", training_path: path1)
      Skill.create(name: "Jogging", training_path: path1)
      Skill.create(name: "Punching", training_path: path2)
      Skill.create(name: "Kicking", training_path: path2, description: "It will be helpful to knock the wind out of your enemies")

    end

    it "should include the name of the skill being viewed" do
      expect(output).to include("Kicking")
    end
    it "should list the description of this skill" do
      expect(output).to include("It will be helpful to knock the wind out of your enemies")
    end
    it "shouldn't list the titles of other skills" do
      expect(output).not_to include("Walking")
      expect(output).not_to include("Jogging")
    end
  end

  context "if we enter a skill the doesn't exist" do
    let(:output){ run_zss_with_input('1', '3') }
    it "prints an error message" do
      expect(output).to include("Sorry, Skill 3 doesn't exist in the Running training path")
    end
  end
end
