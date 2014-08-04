RSpec.describe "Adding skills to a training path" do
  context "valid input" do
    let!(:training_path1){ TrainingPath.create(name: "Weapon Skills") }
    let!(:training_path2){ TrainingPath.create(name: "Running") }
    let!(:output){ run_zss_with_input("2", "add", "Jogging") }

    it "prints a success message" do
     expect(output).to include("Jogging has been added to the Running training path")
    end

    it "saves the correct training path to the record" do
      expect(Skill.last.training_path_id).to eq training_path2.id
    end

    it "saves the skill name" do
      expect(Skill.last.name).to eq "Jogging"
    end

    it "asks for a skill description" do
      expect(output).to include("Please enter a description for Jogging")
    end

  end
  context "invalid input" do
    let!(:training_path){ TrainingPath.create(name: "Running") }
    let!(:output){ run_zss_with_input("1", "add", "") }

    it "prints an error message" do
      expect(output).to include("name cannot be blank")
    end

    it "doesn't create a skill" do
      expect(Skill.count).to eq 0
    end
  end
  context "description" do
    let!(:training_path){ TrainingPath.create(name: "Sneaking") }
    let!(:output1){ run_zss_with_input("1", "add", "Cool Shoes") }
    let!(:output2){ run_zss_with_input("1", "add", "Camoflauge", "You will need to blend in with stuff") }

    it "asks for a skill description" do
      expect(output1).to include("Please enter a description for Cool Shoes")
    end

    it "prints a success message" do
      expect(output2).to include("Description added for Camoflauge")
    end

    it "saves the skill description to the database" do
      expect(Skill.last.description).to include("You will need to blend in with stuff")
    end

  end
end
