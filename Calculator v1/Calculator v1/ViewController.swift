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
    var previousLastOperand = Double()
    
    var lastOperator: operatorType?     // +, -, *, /
    
    var equalToButtonPress : Bool = false
    var operatorTypeButtonPress : Bool = false
    //Judge for digit mode
    //Mode 1 true false => moreThanTwiceToucheQualToButton
    //Mode 2 true true => equalToButtonPressAddOperatorType
    //Mode 3 false false => onlyPressDigitButtonAndOperator
    
    @IBOutlet var messageLabel: UILabel! {
        didSet {
            messageLabel.numberOfLines = 0
        }
    }
    
//  Digit
    @IBAction func digitButtonTuch(_ sender: UIButton) {
        func messageLabelTextCheck() {
            if sender.currentTitle! == "0" {
                if messageLabel.text == "0" {
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
                        print("1")
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
            print("plusOrMinus messageLabel:", messageLabel.text!)
        }else{
            messageLabel.text = String(Double(messageLabel.text!)! * -1)
            messageLabel.text! = format(labelText:String(messageLabel.text!))
            print("plusOrMinus messageLabel:", messageLabel.text!)
        }
    }
    
//  percent
    @IBAction func percent(_ sender: UIButton) {
        if messageLabel.text == "0" {

        }
        messageLabel.text = String(Double(messageLabel.text!)! / 100)

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
        equalToButtonPress = false
        operatorTypeButtonPress = false
        previousLastOperand = 0
    }
    
//    add
    @IBAction func addButtonTouch(_ sender: UIButton) {
        if equalToButtonPress == true, operatorTypeButtonPress == true {
            equalToButtonPress = false
            operatorTypeButtonPress = true
        }else{
            operatorTypeButtonPress = true
        }
    
        if equalToButtonPress == false , operatorTypeButtonPress == true {
            onlyPressDigitButtonAndOperator()
        }
        if equalToButtonPress == true, operatorTypeButtonPress == false{
            onlyPressDigitButtonAndOperator()
            
        }
        lastOperator = operatorType.add
        digitInput = false
    }
    
//     substrac
    @IBAction func substracButtonTouch(_ sender: UIButton) {
        if equalToButtonPress == true, operatorTypeButtonPress == true {
            equalToButtonPress = false
            operatorTypeButtonPress = true
        }else{
            operatorTypeButtonPress = true
        }
        
        if equalToButtonPress == false , operatorTypeButtonPress == true {
            onlyPressDigitButtonAndOperator()
        }
        if equalToButtonPress == true, operatorTypeButtonPress == false{
            onlyPressDigitButtonAndOperator()
            
        }

        lastOperator = operatorType.subtract
        digitInput = false
        
    }
    
//     multiply
    @IBAction func multiplyButtonTouch(_ sender: UIButton) {
        if equalToButtonPress == true, operatorTypeButtonPress == true {
            equalToButtonPress = false
            operatorTypeButtonPress = true
        }else{
            operatorTypeButtonPress = true
        }
        
        if equalToButtonPress == false , operatorTypeButtonPress == true {
            onlyPressDigitButtonAndOperator()
        }
        if equalToButtonPress == true, operatorTypeButtonPress == false{
            onlyPressDigitButtonAndOperator()
            
        }
        lastOperator = operatorType.multiply
        digitInput = false
    }
//     division
    @IBAction func divisionButtonTouch(_ sender: UIButton) {
        if equalToButtonPress == true, operatorTypeButtonPress == true {
            equalToButtonPress = false
            operatorTypeButtonPress = true
        }else{
            operatorTypeButtonPress = true
        }

        if equalToButtonPress == false , operatorTypeButtonPress == true {
            onlyPressDigitButtonAndOperator()
        }
        if equalToButtonPress == true, operatorTypeButtonPress == false{
            onlyPressDigitButtonAndOperator()
            
        }
        lastOperator = operatorType.divide
        digitInput = false
    }
    
//  equal To
    @IBAction func equalToButtonTouch(_ sender: UIButton) {
        if equalToButtonPress == false , operatorTypeButtonPress == true {
            equalToButtonPress = false
            operatorTypeButtonPress = false
        }
        print(equalToButtonPress , operatorTypeButtonPress)

        if let finalOperator = lastOperator {

            switch finalOperator {
            case .add:
                
                if equalToButtonPress == true, operatorTypeButtonPress == false ,let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
                    moreThanTwiceToucheQualToButton()
//                    messageLabel.text! = format(labelText:String(lastOperand))
                }else if equalToButtonPress == true, operatorTypeButtonPress == true {
                    equalToButtonPressAddOperatorType()
                }else{
                    calculateResultIfNeed()
                    messageLabel.text! = format(labelText:String(lastOperand))
                }

            case .subtract:
              
                if equalToButtonPress == true, operatorTypeButtonPress == false ,let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
                    moreThanTwiceToucheQualToButton()
                    messageLabel.text! = format(labelText:String(lastOperand))
                }else if equalToButtonPress == true, operatorTypeButtonPress == true {
                    equalToButtonPressAddOperatorType()
                }else{
                    calculateResultIfNeed()
                    messageLabel.text! = format(labelText:String(lastOperand))
                }

            case .multiply:
            
                if equalToButtonPress == true, operatorTypeButtonPress == false ,let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
                    moreThanTwiceToucheQualToButton()
                    messageLabel.text! = format(labelText:String(lastOperand))
                }else if equalToButtonPress == true, operatorTypeButtonPress == true {
                    equalToButtonPressAddOperatorType()
                }else{
                    calculateResultIfNeed()
                    messageLabel.text! = format(labelText:String(lastOperand))
                }
                
            case .divide:
                if equalToButtonPress == true, operatorTypeButtonPress == false ,let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
                    moreThanTwiceToucheQualToButton()
                    messageLabel.text! = format(labelText:String(lastOperand))
                }else if equalToButtonPress == true, operatorTypeButtonPress == true {
                    equalToButtonPressAddOperatorType()
                }else{
                    calculateResultIfNeed()
                    messageLabel.text! = format(labelText:String(lastOperand))
                }
            }
            equalToButtonPress = true

        }
        digitInput = false
    }
    
    func format(labelText: String) -> String {
        var stringOfNumber :NSNumber
        stringOfNumber = formatter.number(from: labelText)!
        return String(describing: stringOfNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formatter.numberStyle = .decimal
    }
}


// Calculate
extension ViewController {
    func calculateResultIfNeed() {
        if abs(leftOperand) > 0, abs(rightOperand) > 0, let lastOperator = lastOperator {
            print("calculateResultIfNeed")
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
//
            rightOperand = 0
        }
    }
    
    func moreThanTwiceToucheQualToButton() {
        if abs(leftOperand) > 0, abs(rightOperand) > 0, let lastOperator = lastOperator {
            print("moreThanTwiceToucheQualToButton")
            leftOperand = Double(messageLabel.text!)!
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
            previousRightOperand = rightOperand
            messageLabel.text! = format(labelText:String(lastOperand))

        }
    }
    
    func equalToButtonPressAddOperatorType() {
        if let lastOperator = lastOperator {
            leftOperand = lastOperand
//            rightOperand = 0
            if operatorTypeButtonPress == false {
                rightOperand = Double(previousRightOperand!)
                print(rightOperand)
            }else{
            rightOperand = Double(messageLabel.text!)!
            }
            
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
                previousRightOperand = rightOperand
                rightOperand = 0
            messageLabel.text! = format(labelText:String(lastOperand))

        }
    }
    func onlyPressDigitButtonAndOperator() {
        if abs(leftOperand) > 0, abs(rightOperand) > 0, let lastOperator = lastOperator {
            
            if abs(previousLastOperand) > 0 {
            leftOperand = previousLastOperand
        }
            
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
            rightOperand = 0
            messageLabel.text! = format(labelText:String(lastOperand))

        }
    }
}
