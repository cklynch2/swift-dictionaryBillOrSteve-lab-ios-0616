//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var steveButton: UIButton!
    @IBOutlet weak var billButton: UIButton!
    
    var billAndSteveFacts : [String : [String]] = [:]
    var currentFact : String = ""
    var currentPerson: String = ""
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFacts()
        showFact()
    }

    @IBAction func steveButtonTapped(sender: AnyObject) {
        if (currentPerson == "Steve Jobs") {
            score += 1
        }
        scoreLabel.text = "\(score)/9"
        removeFact()
        showFact()
        gameOver()
    }
    
    @IBAction func billButtonTapped(sender: AnyObject) {
        if (currentPerson == "Bill Gates") {
            score += 1
        }
        scoreLabel.text = "\(score)/9"
        removeFact()
        showFact()
        gameOver()
    }
    
    func showFact() {
        let currentTrivia = getRandomFact()
        
        currentPerson = currentTrivia.person
        print("The current person is \(currentPerson).")
        
        currentFact = currentTrivia.fact

        factLabel.text = currentFact
    }
    
    func removeFact() {
        
        if var facts = billAndSteveFacts[currentPerson] {
            if facts.isEmpty {
                billAndSteveFacts[currentPerson] = nil
            
            } else {
            for (index, fact) in facts.enumerate() {
                if fact == currentFact {
                    facts.removeAtIndex(index)
                    billAndSteveFacts[currentPerson] = facts
                }
            } }
        }
    }
    
    func gameOver() {
        if billAndSteveFacts.isEmpty {
            scoreLabel.text = "Game over!\nFinal score: \(score) out of 9"
        }
    }

    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func randomPerson() -> String? {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            if billAndSteveFacts.keys.contains("Steve Jobs") {
                return "Steve Jobs"
            }
        } else {
            if billAndSteveFacts.keys.contains("Bill Gates") {
                return "Bill Gates"
            }
        }
        return nil
    }
    
    func getRandomFact() -> (person: String, fact: String) {
        var personVar = ""
        var randomFact = ""
        
        if let person = randomPerson() {
            personVar += person
            if let facts = billAndSteveFacts[person] {
                let randomIndex = randomNumberFromZeroTo(facts.count - 1)
                randomFact += facts[randomIndex]
            }
        }
        return (person: personVar, fact: randomFact)
    }
    
    func createFacts() {
        var steveFacts = ["He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
                          "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
                          "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
                          "He was a pescetarian, meaning he ate no meat except for fish."]
        var billFacts = ["He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
                         "He scored 1590 (out of 1600) on his SATs.",
                         "His foundation spends more on global health each year than the United Nation's World Health Organization.",
                         "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
                         "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."]
        
        billAndSteveFacts["Bill Gates"] = billFacts
        billAndSteveFacts["Steve Jobs"] = steveFacts
    }
    
    
}
