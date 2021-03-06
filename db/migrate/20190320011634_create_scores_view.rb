class CreateScoresView < ActiveRecord::Migration[5.1]
  def up
    puts "Create scores view..."
    execute <<-SQL
      -- In Postgres syntax.
      CREATE OR REPLACE VIEW vwscores AS
        SELECT
          s.*,
          st.name                AS score_type_name,
          clubb_p.first_name     AS clubber_first_name,
          clubb_p.last_name      AS clubber_last_name,
          recby_p.first_name     AS recby_first_name,
          recby_p.last_name      AS recby_last_name,
          (CASE
              WHEN tbsigs.id IS NULL THEN FALSE
              ELSE TRUE
          END)                   AS is_truthbooksignature,
          tbs.name               AS truthbook_name,
          tbsecs.unit            AS truthbook_unit,
          tbsecs.section         AS truthbook_section,
          tbsecs.sort            AS truthbook_section_sort,
          sdays.sd_date          AS sessionday_date,
          sdays.sessionyear_id   AS sessionyear_id

        FROM scores s
          INNER JOIN scoretypes st              ON st.id = s.scoretype_id
          INNER JOIN persons clubb_p            ON clubb_p.id = s.clubber_id
          INNER JOIN persons recby_p            ON recby_p.id = s.recorded_by_id

          LEFT JOIN truthbooksignatures tbsigs  ON tbsigs.id = s.truthbooksignature_id
          LEFT JOIN truthbooksections tbsecs    ON tbsecs.id = tbsigs.truthbooksection_id
          LEFT JOIN truthbooks tbs              ON tbs.id = tbsecs.truthbook_id

          LEFT JOIN sessiondays sdays           ON sdays.id = s.sessionday_id
          --left join sessionyears syrs          on syrs.id = sdays.sessionyear_id
    SQL
  end

  def down
    execute " DROP VIEW IF EXISTS vwscores"
  end
end
