CREATE OR REPLACE VIEW roster$current_ela_enrollments AS
WITH ela_sections AS
(SELECT sd.*
 FROM roster$section_detail sd
 WHERE sd.end_date >= current_date
   AND (sd.course_name LIKE 'ELA%' OR
        sd.course_name LIKE 'English%' OR 
        sd.course_name LIKE 'Reading%')
   AND sd.course_name <> 'English as a second language'
),
ela_enr AS
(SELECT DISTINCT es.course_name,
        es.start_date,
        es.end_date,
        es.site_name,
        es.room_number,
        es.teacher_first,
        es.teacher_last,
        ss.student_id
 FROM ela_sections es
   JOIN il_public.section_student_aff ss
     ON es.section_id = ss.section_id
 WHERE ss.active = TRUE
   AND ss.leave_date IS NULL
),
ela_rollup AS
(SELECT course_name,
       start_date,
       end_date,
       site_name,
       room_number,
       student_id,
       LISTAGG(teacher_last, '|') WITHIN GROUP (ORDER BY teacher_last) AS teachers
FROM ela_enr
GROUP BY course_name,
         start_date,
         end_date,
         site_name,
         room_number,
         student_id
)
SELECT er.*,
       s.grade
FROM ela_rollup er
JOIN roster$current_students s
  ON er.student_id = s.student_id


