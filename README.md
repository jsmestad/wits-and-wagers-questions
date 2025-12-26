# Wits & Wagers Generator

A web-based trivia game generator inspired by the board game *Wits & Wagers*. This project displays random trivia questions with numeric answers, perfect for playing the betting game where players wager on which answer is closest to the correct number.

## How It Works

The game presents trivia questions one at a time. Players can:
- View the question and category
- Reveal the numeric answer
- Skip to the next question

## Setup

1. Open `index.html` in a web browser
2. Make sure `questions.js` is in the same directory

That's it! No server or build process required.

## Data Source

The questions are filtered from the [Jeopardy! dataset](https://www.kaggle.com/datasets/tunguz/200000-jeopardy-questions), containing over 200,000 questions. The included Ruby script (`data/filter.rb`) processes the CSV to extract only questions with numeric answers (integers only), making them suitable for the Wits & Wagers format.

## Files

- `index.html` - Main game interface
- `questions.js` - Question database (contains filtered Jeopardy questions)
- `data/filter.rb` - Ruby script used to filter the original Jeopardy dataset
- `data/200000-jeopardy-questions.zip` - Original dataset source

## License

The Jeopardy! dataset is used under fair use for educational purposes. This project is for personal/educational use only.

