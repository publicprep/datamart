CREATE OR REPLACE VIEW roster$section_detail AS
SELECT sc.section_id,
       sc.course_id,
       c.short_name AS course_name,
       st.user_id,
       r.room_id,
       r.room_number,
       st.start_date,
       st.end_date,
       sites.site_name,
       users.first_name AS teacher_first,
       users.last_name AS teacher_last
FROM il_dna_public.sections
JOIN il_dna_public.section_course_aff sc
  ON sections.section_id = sc.section_id
JOIN il_dna_public.section_teacher_aff st
  ON sections.section_id = st.section_id
 AND st.primary_teacher = TRUE
JOIN il_dna_public.courses c
  ON sc.course_id = c.course_id
LEFT OUTER JOIN il_dna_public.rooms r
  ON sections.room_id = r.room_id
JOIN il_dna_public.sites
  ON r.site_id = sites.site_id
JOIN il_dna_public.users
  ON st.user_id = users.user_id;