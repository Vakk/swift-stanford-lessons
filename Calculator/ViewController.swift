//
//  ViewController.swift
//  Calculator
//
//  Created by Valera on 8/23/17.
//  Copyright © 2017 Valera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hintDescription: UILabel!
    var brain : CalculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var display: UILabel!
    
    let formatter : NumberFormatter = NumberFormatter()
    
    var displayValue : Double? {
        set {
            display.text = forTailingZero(newValue!)
        }
        
        get {
            if let currentTitle = display.text {
                return Double(currentTitle)
            }
            return nil
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
            if let title = sender.currentTitle {
                if userIsInMiddleOfTyping {
                    if let currentDisplayValue = display.text {
                        if title != "." || !currentDisplayValue.contains("."){
                            display.text = currentDisplayValue + title
                        }
                    }
                    } else {
                        display.text = title
                        userIsInMiddleOfTyping = true
                    }
            }
    }

    
    @IBAction func clearAllValues(_ sender: UIButton) {
        displayValue = 0
        userIsInMiddleOfTyping = false
        brain.clearValues()
        hintDescription.text = brain.description
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
    userIsInMiddleOfTyping = false
        if let displayValue = displayValue {
            brain.setOperand(displayValue)
        }
        if let operation = sender.currentTitle {
            brain.performOperation(operation)
        if let result = brain.result {
            displayValue = result
        }
        hintDescription.text = brain.description
        }
    }
    
    var userIsInMiddleOfTyping: Bool = false
    
    
    func forTailingZero(_ temp: Double) -> String{
        let tempVar = String(format: "%g", temp)
        return tempVar
    }

}

