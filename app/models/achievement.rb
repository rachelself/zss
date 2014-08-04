class Achievement

  def initialize(options)
    @id = options[:id]
    @skill_id = options[:skill].id
    @achieved = options[:achieved]
  end

  def save
    Environment.database.execute("INSERT INTO achievements (id, skill_id, achieved) VALUES ('#{@id}', '#{@skill_id}', '#{@achieved}')")
    @id = Environment.database.last_insert_row_id
  end

  def find(skill)
    row = Environment.database.execute("SELECT id, skill_id, achieved FROM achievements WHERE id='#{skill.id}'")
    if row.nil?
      nil
    else
      Achievement.new(id: row[0], skill_id: row[1], achieved: row[2])
    end
  end

end
