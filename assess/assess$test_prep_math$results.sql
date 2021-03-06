--DROP VIEW assess$test_prep_math$results;

CREATE OR REPLACE VIEW assess$test_prep_math$results AS
WITH math_assess AS
    (SELECT *
     FROM assess$test_prep_math$assessments
    )
SELECT ma.*,
       r.student_id,
       r.student_assessment_id,
       r.date_taken,
       r.performance_band_level,
       r.mastered,
       r.percent_correct,
       r.points,
       r.points_possible
FROM math_assess ma
LEFT OUTER JOIN assess$agg_student_responses$clean r
  ON ma.assessment_id = r.assessment_id
;