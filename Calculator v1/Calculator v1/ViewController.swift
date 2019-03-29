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
    var lastOperator: operatorType?     // +, -, *, /
    var isTypeDigit : Bool = false   //是否再輸入數字的判斷
//
    var lastOperand = Double()

    var previousRightOperand: Double?

    @IBOutlet var messageLabel: UILabel! {
        didSet {
            messageLabel.numberOfLines = 0
        }
    }
    
//    數字鍵,小數點
    @IBAction func digitButtonTuch(_ sender: UIButton) {
//        若是螢幕正在輸入數字，後面輸入的數字會繼續加入螢幕
//        避免第一個數字是0一直按0會變成"000000"
        if isTypeDigit == true && messageLabel.text == "0" && sender.currentTitle! == "0" {
                messageLabel.text = "0"
        }else if isTypeDigit == true && messageLabel.text != "0" && sender.currentTitle! != "0" {
            messageLabel.text = messageLabel.text! + sender.currentTitle!
        } else {
//            顯示第一個輸入的數字
            messageLabel.text = sender.currentTitle!
//            開啟<螢幕正在輸入數字>
            isTypeDigit = true
        }
        
        if let _ = lastOperator {
            rightOperand = Double(messageLabel.text!)!
        }
        else {
            leftOperand = Double(messageLabel.text!)!
        }
    }
    
//     ±
    @IBAction func plusOrMinus(_ sender: Any) {
        //如果messageLabel 是0就不動作
        if messageLabel.text == "0" {
            print("plusOrMinus messageLabel:", messageLabel.text!)
        }else{
//            將messageLabel原本String轉換成Double * -1,再將值傳回messageLabel
            messageLabel.text = String(Double(messageLabel.text!)! * -1)
            messageLabel.text! = format(labelText:String(messageLabel.text!))
            print("plusOrMinus messageLabel:", messageLabel.text!)
        }
    }
    
//     %
    @IBAction func percent(_ sender: Any) {
        //如果messageLabel 是0就不動作
        if messageLabel.text == "0" {
            print("percent messageLabel:", messageLabel.text!)
        }
        //將messageLabel原本String轉換成Double / 100,再將值傳回messageLabel
        messageLabel.text = String(Double(messageLabel.text!)! / 100)
        print("percent messageLabel:", messageLabel.text!)
    }
//     ←
    @IBAction func deleteLastDigitButtonTouch(_ sender: Any) {
        messageLabel.text = String((messageLabel.text?.dropLast())!)
//        如果刪除到最後一個數字時再補0,避免messageLabel出現空白
        if messageLabel.text == "" {
           messageLabel.text = "0"
        }
    }
    
    @IBAction func ResetButtonTouch(_ sender: Any) {
        reset()
    }
    
    private func reset() {
        messageLabel.text = "0"
        leftOperand = 0
        rightOperand = 0
        lastOperator = nil
        isTypeDigit = false
        previousRightOperand = 0
        
        //        暫存給重複按下"="計算
        lastOperand = 0

    }
    
//     +
    @IBAction func addButtonTouch(_ sender: Any) {
        //將目前的messageLabel存入firstNumber
//        leftOperand = Double(messageLabel.text!)!
        //在把firstNumber存入tempFirstNumber
//        tempFirstNumber = firstNumber
        
        calculateResultIfNeed()
        
        print("firstNumber:", leftOperand)

        //紀錄算法，最後由等號的條件判斷來計算值
        lastOperator = operatorType.add
        //輸入數字輸入停止
        isTypeDigit = false
        //格式%g，可以去掉Double小數點後的零
        messageLabel.text = String(format: "%g", leftOperand)
    }
    
//     -
    @IBAction func substracButtonTouch(_ sender: Any) {

        calculateResultIfNeed()
        
        lastOperand = leftOperand
        print("lastOperand:", lastOperand)
        lastOperator = operatorType.subtract
        isTypeDigit = false
        messageLabel.text = String(format: "%g", leftOperand)
    }

//     *
    @IBAction func multiplyButtonTouch(_ sender: Any) {

        calculateResultIfNeed()
        
        lastOperand = leftOperand
        print("lastOperand:", lastOperand)
        lastOperator = operatorType.multiply
        isTypeDigit = false
        messageLabel.text = String(format: "%g", leftOperand)
    }
//     /
    @IBAction func divisionButtonTouch(_ sender: Any) {
        
        calculateResultIfNeed()
        
        lastOperand = leftOperand
        print("lastOperand:", lastOperand)
        lastOperator = operatorType.divide
        isTypeDigit = false
        messageLabel.text = String(format: "%g", leftOperand)
    }
    
//     =
    @IBAction func equalToButtonTouch(_ sender: Any) {
        if let finalOperator = lastOperator {
//            使用紀錄的最後一個計算法，來計算最後結果
            switch finalOperator {
            case .add:
                
                if let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand

                }else{

                    lastOperand = Double(messageLabel.text!)!


                }
                calculateResultIfNeed()
                messageLabel.text! = format(labelText:String(leftOperand))
                
            case .subtract:
              
                if let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
                    
                }else{
                    
                    lastOperand = Double(messageLabel.text!)!
                    
                    
                }
                calculateResultIfNeed()
                messageLabel.text! = format(labelText:String(leftOperand))
                

            case .multiply:
            
                if let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
                    
                }else{
                    
                    lastOperand = Double(messageLabel.text!)!
                    
                    
                }
                calculateResultIfNeed()
                messageLabel.text! = format(labelText:String(leftOperand))
                
            case .divide:
            
                if let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
                    
                }else{
                    
                    lastOperand = Double(messageLabel.text!)!
                    
                    
                }
                calculateResultIfNeed()
                messageLabel.text! = format(labelText:String(leftOperand))
            }
        }
//        messageLabel.text = String(format: "%g", tempFinaNumber)
//        //將內存的值歸0，從新開始
//        leftOperand = 0
        isTypeDigit = false
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
            switch lastOperator {
            case .add:
                leftOperand += rightOperand
            case .divide:
                leftOperand /= rightOperand
            case .multiply:
                leftOperand *= rightOperand
            case .subtract:
                leftOperand -= rightOperand
            }
            
            
            previousRightOperand = rightOperand
            
            rightOperand = 0
            
//            self.lastOperator = nil
            
            print("result: \(leftOperand)")
        }
    }
}
