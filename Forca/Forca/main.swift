//
//  main.swift
//  Forca
//
//  Created by IFPB on 23/05/21.
//  Copyright © 2021 IFPB. All rights reserved.
//
	
import Foundation

class Hangman: NSObject {
  var word: String
  var hint: String
  var wordLetters: [Character]
  var foundLetters: [Character]
  var guessedLetters: [Character] = Array()
  var retries = 10
  var isGameOver = false

  init(word: String, hint: String) {
      self.word = word
      self.hint = hint
      self.wordLetters = Array(word)
      self.foundLetters = self.wordLetters.map({ (_) -> Character in
        return "_"
      })
  }

  func guessLetter(guess: Character) {
    if (isGuessValid(guess: guess)) {
        self.updateFoundLetters(guess: guess)
    } else {
        self.handleGuessNotFound(guess: guess)
    }

    self.guessedLetters.append(guess)
    self.checkGameOverConditions()
  }

  func isGuessValid(guess: Character) -> Bool {
    return self.wordLetters.contains(guess) &&
        !self.guessedLetters.contains(guess) &&
        !self.isGameOver
  }

  func checkGameOverConditions() {
    print(!self.foundLetters.contains("_"))
    if (self.retries
 <= 0 || !self.foundLetters.contains("_")) {
        self.isGameOver = true
    }
  }

  func handleGuessNotFound(guess: Character) {
    if (self.retries
 > 0 && !self.isGameOver) {
        self.retries
     -= 1
    }
  }

  func updateFoundLetters(guess: Character) {
    for (index, letter) in self.wordLetters.enumerated() {
        if (letter == guess) {
            foundLetters[index] = letter
        }
    }
  }
  
  override var description: String {
      return "- Word:           \(self.word)" +
        "\n- Word Letters:      \(self.wordLetters)" +
        "\n- Guessed Letters:   \(self.guessedLetters)" +
        "\n- Found Letters:     \(self.foundLetters)" +
        "\n- Remaining Guesses: \(self.retries)" +
        "\n- Game Over:         \(self.isGameOver)"
  }
}

func main() {
  let game = Hangman(word: "teste1234", hint: "some hint")

  while (!game.isGameOver) {
      print("Input guess:")
      if let guess = readLine() {
        game.guessLetter(guess: Character(guess))
      } else {
        print("enter a valid guess")
      }

    print(game)
  }
}

main()
