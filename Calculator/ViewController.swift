//
//  ViewController.swift
//  Calculator
//
//  Created by Wayne on 2/4/15.
//  Copyright (c) 2015 Wayne. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddelOfTypingANumber = false


    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddelOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text! = digit
            userIsInTheMiddelOfTypingANumber = true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddelOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation() { $0 * $1}
        case "÷": performOperation() { $1 / $0}
        case "+": performOperation() { $0 + $1}
        case "−": performOperation() { $1 - $0}
        case "√": performOperation() { sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }


    @IBAction func enter() {
        userIsInTheMiddelOfTypingANumber = false
        operandStack.append(displayValue)
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddelOfTypingANumber = false
        }
    }
}

