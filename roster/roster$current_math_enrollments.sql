CREATE OR REPLACE VIEW roster$current_math_enrollments AS
WITH math_sections AS
(SELECT sd.*
 FROM roster$section_detail sd
 WHERE sd.end_date >= current_date
   AND sd.course_name LIKE 'Math%'
),
math_enr AS
(SELECT DISTINCT ms.course_name,
        ms.start_date,
        ms.end_date,
        ms.site_name,
        ms.room_number,
        ms.teacher_first,
        ms.teacher_last,
        ss.student_id
 FROM math_sections ms
   JOIN il_public.section_student_aff ss
     ON ms.section_id = ss.section_id
 WHERE ss.active = TRUE
   AND ss.leave_date IS NULL
),
math_rollup AS
(SELECT course_name,
       start_date,
       end_date,
       site_name,
       room_number,
       student_id,
       LISTAGG(teacher_last, '|') WITHIN GROUP (ORDER BY teacher_last) AS teachers
FROM math_enr
GROUP BY course_name,
         start_date,
         end_date,
         site_name,
         room_number,
         student_id
)
SELECT mr.*,
       s.grade
FROM math_rollup mr
JOIN roster$current_students s
  ON mr.student_id = s.student_id