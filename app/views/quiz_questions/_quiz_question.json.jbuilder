json.extract! quiz_question, :id, :prompt, :justified, :explanation, :breakdown_id, :created_at, :updated_at
json.url quiz_question_url(quiz_question, format: :json)
