--DROP VIEW assess$agg_student_responses$clean

CREATE OR REPLACE VIEW assess$agg_student_responses$clean AS
WITH tag_rn AS
(SELECT student_assessment_id,
        _fivetran_synced,
        ROW_NUMBER() OVER (PARTITION BY student_assessment_id
                           ORDER BY _fivetran_synced DESC) AS rn
 FROM il_dna_dna_assessments.agg_student_responses r
),
dedupe AS
(SELECT *
 FROM tag_rn WHERE rn = 1
)
SELECT r.*
FROM il_dna_dna_assessments.agg_student_responses r
JOIN dedupe
  ON r.student_assessment_id = dedupe.student_assessment_id
 AND r._fivetran_synced = dedupe._fivetran_synced