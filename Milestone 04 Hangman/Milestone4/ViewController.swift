//
//  ViewController.swift
//  Milestone4
//
//  Created by Mike Killewald on 7/28/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

// MARK: TODO
// - fix/allow landscape view
// - allow player input of multiple characters. Will be useful to solve quickly or enter all vowels, etc.
// - devise better way to get character input 

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var badChars = [Character]()
    var goodChars = [Character]()
    var selectedWordIndex = 0
    var selectedWord = ""

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var guessedLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForLetter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords == [String]() {
            allWords = loadDefaultWords()
        }
        
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        startGame()
    }
    
    func startGame() {

        selectedWord = allWords[selectedWordIndex].lowercased()
        title = "Hangman"
        badChars = []
        goodChars = []
        guessedLabel.text = ""
        
        imageView.image = UIImage(named: "hangman0")
        
        var displayWord = ""
      
        for _ in selectedWord.characters {
            displayWord += "__  "
        }
        
        wordLabel.text = displayWord.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // increment selectedWord index for next game
        if selectedWordIndex == allWords.count - 1 {
            selectedWordIndex = 0
        } else {
            selectedWordIndex += 1
        }
    }
    
    func loadDefaultWords() -> [String] {
        return ["silkworm", "mustache", "karaoke", "rhythm"]
    }
    
    func promptForLetter() {
        let ac = UIAlertController(title: "Guess a single letter", message: "If more than one letter is sent, only the first letter will be used.", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction) in
            let guess = ac.textFields![0].text!.lowercased()
            
            if guess == "" {
                // players guess was blank, display error
                self.displayError(title: "You're guess was blank.")
            } else {
                // guess was not blank, ok to proceed
                let guessedChar = guess.characters[guess.startIndex] // this gets the first letter of the String as a Character
                let charSet = CharacterSet.letters
                
                if self.badChars.contains(guessedChar) || self.goodChars.contains(guessedChar) {
                    // same letter guessed more than once, display error
                    self.displayError(title: "Letter \(String(guessedChar).uppercased()) has already been guessed.")
                } else if String(guessedChar).rangeOfCharacter(from: charSet) == nil {
                    // guessedChar was not an alpha character, display error
                    self.displayError(title: "Invalid Character: \(String(guessedChar))")
                } else {
                    // submit guessed letter
                    self.submit(guessedChar: guessedChar)
                }
            }
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func displayError(title: String, message: String? = nil) {
        let errorAc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAc.addAction(UIAlertAction(title: "Please try again", style: .cancel))
        
        present(errorAc, animated: true)
    }
    
    func endGame(title: String, message: String? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Play again", style: .default) { [unowned self] (action: UIAlertAction) in
            self.startGame()
        })
        
        self.present(ac, animated: true)
    }
    
    func submit(guessedChar: Character) {
        
        if selectedWord.contains(String(guessedChar)) {
            // this was a good guess
            goodChars.append(guessedChar)
            
            // reveal guessed character locations in selectedWord and detect a win if all letters are revealed
            var displayWord = ""
            var win = true // will be set false in below loop if at least one character is still hidden
        
            for character in selectedWord.characters {
                if goodChars.contains(character) {
                    displayWord += "\(String(character).uppercased())  "
                } else {
                    displayWord += "__  "
                    win = false
                }
            }
            
            // if win is still true at this point, all letters have been revealed.
            if win {
                endGame(title: "You won, congratulations!")
            }
            
            wordLabel.text = displayWord.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            // this was a bad guess
            badChars.append(guessedChar)
            
            // update hangman image
            imageView.image = UIImage(named: "hangman\(badChars.count)")
            
            // generate list of bad guesses
            var guessedChars = ""
            
            for character in badChars {
                guessedChars += "\(String(character).uppercased())  "
            }
            guessedLabel.text = guessedChars.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // check if maximum bad guesses reached
            if badChars.count == 7 {
                endGame(title: "Sorry, you're out of guesses!", message: "The word was \(selectedWord).")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

