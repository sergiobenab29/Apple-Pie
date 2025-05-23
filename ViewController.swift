//
//  ViewController.swift
//  ApplePie
//
//  Created by Sergio Benavides Bendezú on 4/28/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet var treeImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var listOfWords = ["buccaneer", "swift", "fries", "soda", "milkshake", "nuggets"]
    
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else {
            enableLetterButtons(false)
        }
    }
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        
    let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }else{
            updateUI()
        }
    }
        func enableLetterButtons(_ enabled: Bool) {
            for button in letterButtons {
                button.isEnabled = enabled
            }
        }
    }

