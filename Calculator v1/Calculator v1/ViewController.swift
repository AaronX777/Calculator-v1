//
//  ViewController.swift
//  Calculator v1
//
//  Created by rd on 2019/3/19.
//  Copyright © 2019 aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let formatter = NumberFormatter()
    
    enum operatorType {
        case add        // +
        case subtract   // -
        case multiply   // *
        case divide     // /
    }

    var leftOperand = Double() // Express, leftoperand
    var rightOperand = Double() // rightOperand
    var lastOperand = Double()

    var digitInput : Bool = false

    var previousRightOperand: Double?
    var previousLastOperand: Double?
    var previousLeftOperand: Double?
    
    var lastOperator: operatorType?     // +, -, *, /
    
    @IBOutlet var messageLabel: UILabel! {
        didSet {
            messageLabel.numberOfLines = 0
        }
    }
    
//  Digit
    @IBAction func digitButtonTuch(_ sender: UIButton) {
        func messageLabelTextCheck() {
            if sender.currentTitle == "0" , digitInput == false {
                messageLabel.text = "0"
            }else if sender.currentTitle == "0" {
                if messageLabel.text == "0" {
                    messageLabel.text = "0"
                    
                }else if messageLabel.text == "00" {
                    messageLabel.text = "0"
                    
                }else{
                if digitInput == false {
                    messageLabel.text = ""
                    messageLabel.text = messageLabel.text! + sender.currentTitle!
                
                    }
                messageLabel.text = messageLabel.text! + sender.currentTitle!
                    digitInput = true
                }
            }else if sender.currentTitle == "." {
                if messageLabel.text == "0" {
                    messageLabel.text = "0."
                }else if !(messageLabel.text!.contains(".")) {
                    messageLabel.text! += "."

                }
            }else if sender.currentTitle != "0" {
                
                if messageLabel.text == "0" , digitInput == false {
                        messageLabel.text = ""
                    digitInput = true
                }else if messageLabel.text! != "0" , digitInput == false , abs(leftOperand) > 0 {
                        messageLabel.text = ""
                        digitInput = true
                    
                }
                    messageLabel.text = messageLabel.text! + sender.currentTitle!
                    digitInput = true
                
                }
        }

        if let _ = lastOperator {
            messageLabelTextCheck()
            rightOperand = Double(messageLabel.text!)!
        }else {

            messageLabelTextCheck()
            leftOperand = Double(messageLabel.text!)!

        }

    }
    
    
    
//  Plus Or Minus
    @IBAction func plusOrMinus(_ sender: UIButton) {
        if messageLabel.text == "0" {

        }else{

        if lastOperator == nil {
            messageLabel.text = (String(Double(messageLabel.text!)! * -1))
            leftOperand = Double(messageLabel.text!)!

        }else if rightOperand == 0 , lastOperator != nil {
            messageLabel.text = (String(Double(messageLabel.text!)! * -1))
            lastOperand = Double(messageLabel.text!)!
            
        }else{
            messageLabel.text = (String(Double(messageLabel.text!)! * -1))
            rightOperand = Double(messageLabel.text!)!
            
        }
        messageLabel.text! = format(labelText:String(messageLabel.text!))
        }

    }
    
//  percent
    @IBAction func percent(_ sender: UIButton) {
        if messageLabel.text == "0" {
            
        }else{
            if lastOperator == nil {
                messageLabel.text = (String(Double(messageLabel.text!)! / 100))
                leftOperand = Double(messageLabel.text!)!
                
            }else if rightOperand == 0 , lastOperator != nil {
                messageLabel.text = (String(Double(messageLabel.text!)! / 100))
                lastOperand = Double(messageLabel.text!)!
            }else{
                messageLabel.text = (String(Double(messageLabel.text!)! / 100))
                rightOperand = Double(messageLabel.text!)!
            }
            messageLabel.text! = format(labelText:String(messageLabel.text!))
        }
        
        
        
        
        
    }
//  Delete Last Digit
    @IBAction func deleteLastDigitButtonTouch(_ sender: UIButton) {
        messageLabel.text = String((messageLabel.text?.dropLast())!)
        if messageLabel.text == "" {
           messageLabel.text = "0"
        }
    }
    
    @IBAction func ResetButtonTouch(_ sender: UIButton) {
        reset()
    }

    private func reset() {
        messageLabel.text = "0"
        leftOperand = 0
        rightOperand = 0
        lastOperand = 0
        
        lastOperator = nil
        digitInput = false
        previousRightOperand = nil
        previousLastOperand = nil
        previousLeftOperand = nil

    }
    
//    add
    @IBAction func addButtonTouch(_ sender: UIButton) {
//        if abs(leftOperand) > 0 ,abs(rightOperand) > 0 {
        if abs(leftOperand) > 0 ,abs(rightOperand) > 0 {
            calculateResultIfNeed()
            leftOperand = lastOperand

            lastOperator = operatorType.add
            messageLabel.text! = format(labelText:String(lastOperand))
            digitInput = false

        }else{
        lastOperator = operatorType.add
        digitInput = false

        }

    }
    
//     substrac
    @IBAction func substracButtonTouch(_ sender: UIButton) {
        if abs(leftOperand) > 0 ,abs(rightOperand) > 0 {
            calculateResultIfNeed()
            leftOperand = lastOperand
            
            lastOperator = operatorType.subtract
            messageLabel.text! = format(labelText:String(lastOperand))
            digitInput = false
            
        }else{
            lastOperator = operatorType.subtract
            digitInput = false
            
        }
        
    }

    
//     multiply
    @IBAction func multiplyButtonTouch(_ sender: UIButton) {
        if abs(leftOperand) > 0 ,abs(rightOperand) > 0 {
            calculateResultIfNeed()
            leftOperand = lastOperand
            
            lastOperator = operatorType.multiply
            messageLabel.text! = format(labelText:String(lastOperand))
            digitInput = false
            
        }else{
            lastOperator = operatorType.multiply
            digitInput = false
            
        }
        
    }

 
//     division
    @IBAction func divisionButtonTouch(_ sender: UIButton) {
        if abs(leftOperand) > 0 ,abs(rightOperand) > 0 {
            calculateResultIfNeed()
            leftOperand = lastOperand
            
            lastOperator = operatorType.divide
            messageLabel.text! = format(labelText:String(lastOperand))
            digitInput = false
            
        }else{
            lastOperator = operatorType.divide
            digitInput = false
            
        }
        
    }
    
    
//  equal To
    @IBAction func equalToButtonTouch(_ sender: UIButton) {
        if let finalOperator = lastOperator {

            switch finalOperator {
            case .add:
                if lastOperand < 0 {
                    print(lastOperand)
                    rightOperand = Double(messageLabel.text!)!
                }else if let previousLastOperand = previousLastOperand , rightOperand != 0 {
                    rightOperand = Double(messageLabel.text!)!
                    leftOperand = previousLastOperand

                }else if let previousRightOperand = previousRightOperand {
                    leftOperand = lastOperand
                    rightOperand = previousRightOperand

                }
  
            case .subtract:
              
                if let previousLastOperand = previousLastOperand , rightOperand != 0 {
                    rightOperand = Double(messageLabel.text!)!
                    leftOperand = previousLastOperand
                    
                }else if let previousRightOperand = previousRightOperand {
                    leftOperand = lastOperand
                    rightOperand = previousRightOperand
                }

            case .multiply:
            
                if let previousLastOperand = previousLastOperand , rightOperand != 0 {
                    rightOperand = Double(messageLabel.text!)!
                    leftOperand = previousLastOperand
                    
                    
                }else if let previousRightOperand = previousRightOperand {
                    leftOperand = lastOperand
                    rightOperand = previousRightOperand
                    
                }
                
            case .divide:
                if let previousLastOperand = previousLastOperand , rightOperand != 0 {
                    rightOperand = Double(messageLabel.text!)!
                    leftOperand = previousLastOperand
                    
                    
                }else if let previousRightOperand = previousRightOperand {
                    leftOperand = lastOperand
                    rightOperand = previousRightOperand
                    
                }
                
                
            }
            calculateResultIfNeed()
            messageLabel.text! = format(labelText:String(lastOperand))
        }
        digitInput = false
    }
    
    func format(labelText: String) -> String {
        var stringOfNumber :NSNumber
        stringOfNumber = formatter.number(from: labelText)!
        return String(describing: stringOfNumber)
    }
    //describing
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formatter.numberStyle = .decimal
    }
}


// Calculate
extension ViewController {
    func calculateResultIfNeed() {
        if let lastOperator = lastOperator {
            switch lastOperator {
            case .add:
                lastOperand = leftOperand + rightOperand
                print(lastOperand, "=", leftOperand, "+", rightOperand)
            case .subtract:
                lastOperand = leftOperand - rightOperand
                print(lastOperand, "=", leftOperand, "-", rightOperand)
            case .multiply:
                lastOperand = leftOperand * rightOperand
                print(lastOperand, "=", leftOperand, "*", rightOperand)
            case .divide:
                lastOperand = leftOperand / rightOperand
                print(lastOperand, "=", leftOperand, "/", rightOperand)
            }
            previousLastOperand = lastOperand
            previousRightOperand = rightOperand
            previousLeftOperand = leftOperand
            rightOperand = 0
        }
    }
}
