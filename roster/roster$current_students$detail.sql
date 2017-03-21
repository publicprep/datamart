CREATE OR REPLACE VIEW roster$current_students$detail AS
SELECT cur.*
      ,s.first_name
      ,s.last_name
      ,s.birth_date
      ,s.local_student_id AS OSIS
      ,s.district_enter_date
      ,CASE WHEN sped.specialed_id IS NOT NULL THEN 'IEP' ELSE 'No IEP' END AS iep
FROM roster$current_students cur
JOIN il_public.students s
  ON cur.student_id = s.student_id
LEFT OUTER JOIN il_public.student_specialed sped
  ON cur.student_id = sped.student_id;