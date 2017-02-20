class K4tLessonMgr

  attr_accessor :lessons_a, :lessons_b
  def initialize
    @lessons_a = K4tLessonMgr.lessons_to_cal_list(K4tLessonMgr.get_lessons(:a))
    @counter_a = 0

    @lessons_b = K4tLessonMgr.lessons_to_cal_list(K4tLessonMgr.get_lessons(:b))
    @counter_b = 0

  end


  # For building calendar, getting the next lesson
  def next_a
    return {} if @lessons_a.size <= @counter_a
    @counter_a += 1
    return @lessons_a[@counter_a - 1]
  end

  def next_b
    return {} if @lessons_b.size <= @counter_b
    @counter_b += 1
    return @lessons_b[@counter_b - 1]
  end

  def self.lessons_to_cal_list(lessons)
    list = [{name: 'Opening Night', num:1}]
    lessons.each do |lesson|
      lesson[:num].times do |l|
        list << lesson
      end
      list << {doctrine: lesson[:doctrine], name: 'Review/Catch-up', num: 1}
    end
    return list
  end

  def self.get_lessons(year=:both) # :both, :a, or :b
    a = [
      {doctrine: 1,  name: "God's Word - The Bible", num: 4},
      {doctrine: 2,  name: "The Greatness of God", num: 4},
      {doctrine: 3,  name: "The Goodness of God", num: 4},
      {doctrine: 4,  name: "The Trinity", num: 4},
      {doctrine: 5,  name: "God's Creation", num: 4},
      {doctrine: 6,  name: "God's View of You", num: 3}
    ]
    return a if year == :a
    b = [
      {doctrine: 7,  name: "God's Law", num: 4},
      {doctrine: 8,  name: "Who is Jesus?", num: 4},
      {doctrine: 9,  name: "What is Salvation?", num: 4},
      {doctrine: 10, name: "God's Purpose for his Children", num: 4},
      {doctrine: 11, name: "God's Word - Past and Present", num: 4},
      {doctrine: 12, name: "God's Plan for the Future", num: 3}
    ]
    return b if year == :b
    return a + b
  end


end
