require 'csv'
require 'json'

# CONFIGURATION
# ------------------------------------------------------------------
# Make sure this matches the filename you downloaded from Kaggle
INPUT_FILE = 'JEOPARDY_CSV.csv'
OUTPUT_FILE = 'wits_wagers_questions.json'

puts "Started processing #{INPUT_FILE}..."

numeric_questions = []
count = 0

# 1. READ THE CSV
# ------------------------------------------------------------------
# The Kaggle dataset headers are often:
# ["Show Number", " Air Date", " Round", " Category", " Value", " Question", " Answer"]
# Note the leading spaces in some headers like " Answer" and " Question".

CSV.foreach(INPUT_FILE, headers: true, encoding: 'ISO-8859-1:UTF-8') do |row|
  
  # Extract relevant columns
  question_text = row[' Question'].to_s
  answer_text   = row[' Answer'].to_s
  category      = row[' Category'].to_s

  # 2. CLEAN THE DATA
  # ------------------------------------------------------------------
  # Remove HTML tags if present (e.g. <i>War and Peace</i>)
  clean_answer = answer_text.gsub(/<[^>]*>/, '')

  # Remove currency symbols, commas, and whitespace
  # Example: "$1,200" becomes "1200"
  clean_answer = clean_answer.gsub(/[$,\s]/, '')

  # 3. FILTER LOGIC
  # ------------------------------------------------------------------
  # We strictly want digits ONLY.
  # This rejects answers like "The 1920s", "3.5", or "About 50"
  # to ensure the game logic is simple (integers only).
  
  if clean_answer.match?(/^\d+$/)
    
    # Optional: Filter out boring answers (e.g., very small numbers)
    # value = clean_answer.to_i
    # next if value < 5 

    numeric_questions << {
      category: category,
      question: question_text,
      answer: clean_answer.to_i,
      original_answer_text: answer_text # Kept for reference
    }
  end

  # Progress indicator
  count += 1
  print "." if count % 5000 == 0
end

puts "\n\nProcessing complete!"
puts "Total rows scanned: #{count}"
puts "Numeric questions found: #{numeric_questions.length}"

# 4. SAVE TO JSON
# ------------------------------------------------------------------
File.open(OUTPUT_FILE, 'w') do |f|
  f.write(JSON.pretty_generate(numeric_questions))
end

puts "Saved filtered list to #{OUTPUT_FILE}"
