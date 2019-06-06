module ApplicationHelper

  def gold_pace(stats)
    "#{num_to_pc stats[:pc_to_gold]} to gold (#{stats[:signas_to_gold]} to go!)"
  end
  def silver_pace(stats)
    "#{num_to_pc stats[:pc_to_silver]} to silver (#{stats[:signas_to_silver]} to go!)"
  end

  def num_to_pc(num)
    number_to_percentage(num *100, :precision => 0)
  end

  # Add up Book/Bible/section/all scores
  def accum_line_pts(line_data)
    pts = 0
    line_data[:scores].each do |score_type, scores| # key, val
      pts += scores.sum {|score| score.point_value }
    end
    pts
  end

  def book_bible_att(line_data)
    labelize_scores(line_data, %w{Book Bible Attendance})
  end

  def tb_signas(line_data)
    labelize_scores(line_data, %w{Section Training Final})
  end

  def other_scores(line_data)
    labelize_scores(line_data, %w{Friend ThemeParticipation Team})
  end

  # score_types - Book, Section, Friend, etc
  def labelize_scores(line_data, score_types)
    ld = line_data[:scores]
    s = []
    score_types.each do |st|
      if ld[st].present?
        scores = ld[st].map(&:out)
        s << scores.map {|s| %Q~<span class="badge label-#{st} margLR3">#{s}</span>~ }
      end
    end
    s.join(' ').html_safe
  end

  def team_color(registration)
    color = registration.team_name
    return "<span class='#{color.downcase}-team'>#{color} Team</span>".html_safe if color.present?
    return 'Team Color?'
  end

  def tbl_css
    "table table-striped table-hover table-sm table-responsive-sm"
  end

  def bg_scr_only
    "d-none d-md-block"
  end
  def sm_scr_only
    "d-md-none"
  end

  # Given "2019/03/01", return "03/01". For small screens
  def sm_date(date_str)
    date_str[5..-1]
  end

end
