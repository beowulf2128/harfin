class AddIsScoretypeIdToTruthbooksection < ActiveRecord::Migration[5.1]
  def change
    add_column :truthbooksections, :scoretype_id, :integer
  end

  def self.fill_scoretype_ids

    puts " - - filling scoretype ids"
		sst = {}
		sst['Section'] = Scoretype.find_by_name('Section')
		sst['Training'] = Scoretype.find_by_name('Training')
		sst['Final'] = Scoretype.find_by_name('Final')


    Truthbooksection.all.each do |tbs|
      if tbs.section == "Final"
        st = sst['Final']
      elsif tbs.section == 'Training'
        st = sst['Training']
      else
        st = sst['Section']
      end
      tbs.scoretype_id = st.id
      tbs.save!
    end
  end
end
