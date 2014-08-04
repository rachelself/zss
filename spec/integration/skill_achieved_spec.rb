RSpec.describe "Marking the skill as achieved or not" do
  let!(:path1){ TrainingPath.create(name: "Weapons") }
  let!(:path2){ TrainingPath.create(name: "Insults") }

  context "a skill that has not previously been mastered" do
    let(:output){ run_zss_with_input('2', '1') } # Insults > Cursing
    let(:output2){ run_zss_with_input('2', '2', 'y') } # Insults > Name Calling
    let(:output3){ run_zss_with_input('2', '2', 'n') } # Insults > Name Calling

    before do
      Skill.create(name: "Cursing", training_path: path2, description: "Bring out the inner sailor")
      Skill.create(name: "Name Calling", training_path: path2, description: "Bring out the shame")

    end

    it "should display the description of the correct skill" do
      expect(output).to include("Bring out the inner sailor")
    end
    it "should ask the user if they have achieved the skill yet" do
      expect(output).to include("Mark as achieved? y/n")
    end

    context "user answers yes" do
      it "should print a congratulatory message" do
        expect(output2).to include("Congrats, you mastered a new skill!")
      end
    end

    context "user answers no" do
      it "should print a motivational message" do
        expect(output3).to include("Really?! All you had to do was read this paragraph. Would you agree with that?")
      end
    end
  end

end
