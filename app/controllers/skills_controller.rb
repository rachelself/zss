class SkillsController

  attr_accessor :skill

  def initialize(origin_training_path)
    @origin_training_path = origin_training_path
  end

  def achieved?(skill)
    puts "====== @skill: #{@skill} === skill: #{skill} ======"
    puts "Mark as achieved? y/n"
    command = clean_gets
    achievement = Achievement.find(skill)

    case command
    when "y"
      if achievement
        achievement.update(true)
      else
        Achievement.new(skill_id: skill.id, achieved: true)
      end
      puts "Congrats, you mastered a new skill!"
    when "n"
      if achievement
        achievement.update(false)
      else
        Achievement.new(skill_id: skill.id, achieved: false)
      end
      puts "Really?! All you had to do was read this paragraph. Would you agree with that?"
    else
      puts "Sorry, that's not a valid command"
    end
  end

  def add
    puts "What #{@origin_training_path.name} skill do you want to add?"
    name = clean_gets
    @skill = Skill.create(name: name, training_path: @origin_training_path)
    if skill.new_record?
      puts skill.errors
    else
      puts "#{name} has been added to the #{@origin_training_path.name} training path"
    end
  end

  def get_description
    puts "Please enter a description for #{@skill.name}."
    description = clean_gets
    @skill.update_description(description)
    puts "Description added for #{@skill.name}"
  end

  def list
    puts "=============="
    puts "#{@origin_training_path.name.upcase} SKILLS"
    puts "=============="
    @origin_training_path.skills.each_with_index do |skill, index|
      puts "#{index + 1}. #{skill.name}"
    end
    Router.navigate_skills_menu(self)
  end

  def view(path_number)
    skill = skills[path_number - 1]
    if skill
      puts "=============="
      puts "#{skill.name.upcase} SKILLS"
      puts "=============="
      puts "#{skill.description}"
      self.achieved?(skill)
    else
      puts "Sorry, Skill #{path_number} doesn't exist in the #{@origin_training_path.name} training path"
    end
  end

  def skills
    skills ||= Skill.all("WHERE training_path_id='#{@origin_training_path.id}'")
  end


end
