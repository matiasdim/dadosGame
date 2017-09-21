//
//  ViewController.swift
//  DadosGame
//
//  Created by Matias on 9/21/17.
//  Copyright © 2017 Matias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImage: UIImageView!
    @IBOutlet weak var playerAScoreLabel: UILabel!
    @IBOutlet weak var playerBScoreLabel: UILabel!
    var playerATurn: Bool = true
    var playerAScore: Int = 0
    var playerBScore: Int = 0
    @IBOutlet weak var roundCounterLabel: UILabel!
    @IBOutlet weak var playerAButton: UIButton!
    @IBOutlet weak var playerBButton: UIButton!
    var roundCounter: Int = 0
    
    
    @IBOutlet weak var turnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playPressed(_ sender: Any) {
        let currentNumber = self.rollDice()
        self.updateDiceIMAGE(num: currentNumber)
        if currentNumber != 1{
            if playerATurn{
                playerAScore += currentNumber
                playerAScoreLabel.text = "\(playerAScore)"
            }else{
                playerBScore += currentNumber
                playerBScoreLabel.text = "\(playerBScore)"
                if roundCounter == 5 && playerBScore > playerAScore {
                    self.roundCounterLabel.text = "Player B Wins"
                    self.playerAButton.isEnabled = false
                    self.playerBButton.isEnabled = false
                }
            }
        }else{
            if playerATurn{
                playerAScore = 0
                playerAScoreLabel.text = "\(playerAScore)"
            }else{
                playerBScore = 0
                playerBScoreLabel.text = "\(playerBScore)"
            }
            self.setNewTurn()
        }
    }
    
    @IBAction func passButtonPressed(_ sender: Any) {        
        self.setNewTurn()
    }
    @IBAction func restartPressed(_ sender: Any) {
        initialGame()
    }
    
    func initialGame() -> Void {
        playerATurn = true
        playerAScore = 0
        playerBScore = 0
        playerAScoreLabel.text = "\(playerAScore)"
        playerBScoreLabel.text = "\(playerBScore)"
        self.playerAButton.isEnabled = true
        self.playerBButton.isEnabled = false
        roundCounter = 1
        self.roundCounterLabel.text = "Round \(roundCounter)/5"
        self.turnLabel.text = "Player A turn!"
    }
    func setNewTurn() -> Void{
        if roundCounter == 5 && !playerATurn {
            if playerAScore == playerBScore {
                self.roundCounterLabel.text = "There is a tie!"
            }else{
                self.roundCounterLabel.text = playerAScore > playerBScore ? "Player A Wins" : "Player B Wins"
                self.playerAButton.isEnabled = false
                self.playerBButton.isEnabled = false
            }
        }else{
            if !playerATurn {
                roundCounter += 1
                self.roundCounterLabel.text = "Round \(roundCounter)/5"
            }
            playerATurn = !playerATurn
            self.turnLabel.text = "Player \(playerATurn ? "A" : "B") turn!"
            self.toggleButtonsEnabled()
        }
    }
    
    func toggleButtonsEnabled()->Void {
        self.playerAButton.isEnabled = !self.playerAButton.isEnabled
        self.playerBButton.isEnabled = !self.playerBButton.isEnabled
    }
    
    func rollDice()->Int{
        let num = Int(arc4random_uniform(6))
        if num != 0 {
            return num
        }else{
            return 1
        }
    }
    
    func updateDiceIMAGE(num: Int)-> Void{
        switch num {
        case 1:
            self.diceImage.image = UIImage(named: "Dice1")
        case 2:
            self.diceImage.image = UIImage(named: "Dice2")
        case 3:
            self.diceImage.image = UIImage(named: "Dice3")
        case 4:
            self.diceImage.image = UIImage(named: "Dice4")
        case 5:
            self.diceImage.image = UIImage(named: "Dice5")
        case 6:
            self.diceImage.image = UIImage(named: "Dice6")
        default:
            self.diceImage.image = UIImage(named: "Dice1")
        }
    }
}

