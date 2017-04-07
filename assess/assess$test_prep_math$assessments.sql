CREATE OR REPLACE VIEW assess$test_prep_math$assessments AS
SELECT a.assessment_id
      ,a.academic_year
      ,a.title
      ,a.administered_at
      ,a.tags
      ,a.performance_band_set_id
      ,subj.code_translation AS subject_area
      ,scope.code_translation AS scope
      ,u.state_id
  FROM il_dna_dna_assessments.assessments a
  JOIN il_dna_public.users u
    ON a.user_id = u.user_id
  LEFT OUTER JOIN il_dna_codes.dna_subject_areas subj
    ON a.code_subject_area_id = subj.code_id
  LEFT OUTER JOIN il_dna_codes.dna_scopes scope
    ON a.code_scope_id = scope.code_id
 WHERE a.deleted_at IS NULL
   AND subj.code_translation = 'Mathematics'
   AND a.academic_year = 2017
   -- KAS
   --AND u.user_id = 309
   AND (a.title LIKE '2016-17 Math Test Prep%' OR
        a.title LIKE '%2016-17 NY MS Math Quiz Week%')
   AND a.title NOT LIKE 'Copy of [External]%'
ORDER BY a.title ASC;
