CREATE OR REPLACE VIEW roster$current_students AS
SELECT aff.student_id
      ,aff.session_id
      ,aff.grade_level_id
      ,aff.entry_date
      ,aff.leave_date
      ,sessions.site_id
      ,sites.site_name
      ,grade_levels.short_name AS grade
FROM il_dna_public.student_session_aff aff
JOIN il_dna_public.sessions
  ON aff.session_id = sessions.session_id
 AND sessions.academic_year = 2017
JOIN il_dna_public.sites
 ON sessions.site_id = sites.site_id
JOIN il_dna_public.grade_levels
  ON aff.grade_level_id = grade_levels.grade_level_id
WHERE aff.leave_date > current_date;