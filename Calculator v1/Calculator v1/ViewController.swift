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

    var leftOperand = Double() // expresess, leftoperand
    var rightOperand = Double() // rightOperand
    var lastOperator: operatorType?     // +, -, *, /
    var isTypingNumber : Bool = false   //是否再輸入數字的判斷
//
    var tempFinaNumber = Double()
    var tempFirstNumber = Double() // ??
    var tempSign = String()

    var previousRightOperand: Double?

    @IBOutlet var messageLabel: UILabel! {
        didSet {
            messageLabel.numberOfLines = 0
        }
    }
    
//    數字鍵,小數點
    @IBAction func numberButtonClick(_ sender: UIButton) {
//        若是螢幕正在輸入數字，後面輸入的數字會繼續加入螢幕
//        避免第一個數字是0一直按0會變成"000000"
        if isTypingNumber == true && messageLabel.text == "0" && sender.currentTitle! == "0" {
                messageLabel.text = "0"
        }else if isTypingNumber == true && messageLabel.text != "0" && sender.currentTitle! != "0" {
            messageLabel.text = messageLabel.text! + sender.currentTitle!
        } else {
//            顯示第一個輸入的數字
            messageLabel.text = sender.currentTitle!
//            開啟<螢幕正在輸入數字>
            isTypingNumber = true
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
    @IBAction func backButtinClick(_ sender: Any) {
        messageLabel.text = String((messageLabel.text?.dropLast())!)
//        如果刪除到最後一個數字時再補0,避免messageLabel出現空白
        if messageLabel.text == "" {
           messageLabel.text = "0"
        }
    }
    
    @IBAction func clearButtonClick(_ sender: Any) {
        reset()
    }
    
    private func reset() {
        messageLabel.text = "0"
        leftOperand = 0
        rightOperand = 0
        isTypingNumber = false
        
        //        暫存給重複按下"="計算
        tempFinaNumber = 0
        tempFirstNumber = 0
        tempSign = ""
    }
    
//     +
    @IBAction func plusButtonClick(_ sender: Any) {
        //將目前的messageLabel存入firstNumber
//        leftOperand = Double(messageLabel.text!)!
        //在把firstNumber存入tempFirstNumber
//        tempFirstNumber = firstNumber
        
        calculateResultIfNeed()
        
        print("firstNumber:", leftOperand)

        //紀錄算法，最後由等號的條件判斷來計算值
        lastOperator = operatorType.add
        //輸入數字輸入停止
        isTypingNumber = false
        //格式%g，可以去掉Double小數點後的零
        messageLabel.text = String(format: "%g", leftOperand)
    }
    
//     -
    @IBAction func substracButtonClick(_ sender: Any) {

        calculateResultIfNeed()
        
        tempFirstNumber = leftOperand
        print("tempFirstNumber:", tempFirstNumber)
        lastOperator = operatorType.subtract
        isTypingNumber = false
        messageLabel.text = String(format: "%g", leftOperand)
    }

//     *
    @IBAction func multiButtonClick(_ sender: Any) {

        calculateResultIfNeed()
        
        tempFirstNumber = leftOperand
        print("tempFirstNumber:", tempFirstNumber)
        lastOperator = operatorType.multiply
        isTypingNumber = false
        messageLabel.text = String(format: "%g", leftOperand)
    }
//     /
    @IBAction func divisionButtonClick(_ sender: Any) {
        
        calculateResultIfNeed()
        
        tempFirstNumber = leftOperand
        print("tempFirstNumber:", tempFirstNumber)
        lastOperator = operatorType.divide
        isTypingNumber = false
        messageLabel.text = String(format: "%g", leftOperand)
    }
    
//     =
    @IBAction func equalToButtonClick(_ sender: Any) {
        if let finalOperator = lastOperator {
//            使用紀錄的最後一個計算法，來計算最後結果
            switch finalOperator {
            case .add:
                
                if let previousRightOperand = previousRightOperand {
                    rightOperand = previousRightOperand
//                如果tempEqual = +,表示按了二次以上"="
//                if tempSign == "+" {
//                    print("1")
//                    tempFinaNumber = tempFirstNumber + rightOperand
//                    messageLabel.text! = format(labelText:String(tempFinaNumber))
//                    print(tempFinaNumber, "=", tempFirstNumber, "+", rightOperand)
//                    tempFirstNumber = Double(messageLabel.text!)!
//                    tempSign = "+"
                    
                }else{
//                    print("2")
//                    第一次按下"="來到這
                    
//                    將messageLabel目前顯示的String轉換成Double再給secondNumber
//                    rightOperand = Double(messageLabel.text!)!
//                    tempFinaNumber = leftOperand + rightOperand
//                    calculateResultIfNeed()
//                    messageLabel.text! = format(labelText:String(leftOperand))
//                    print(tempFinaNumber, "=", leftOperand, "+", rightOperand)
//                    messageLabel.text = "\(leftOperand)"
//                    暫存符號tempSign,給在按下"="做判斷
                    tempSign = "+"
//                    把最後顯示出來的messageLabel轉換成數字暫存給tempFirstNumber,給在按下"="做計算
                    tempFirstNumber = Double(messageLabel.text!)!


                }
                calculateResultIfNeed()
                messageLabel.text! = format(labelText:String(leftOperand))
                
            case .subtract:
                if tempSign == "-" {
                    print("1")
                    tempFinaNumber = tempFirstNumber - rightOperand
                    messageLabel.text! = format(labelText:String(tempFinaNumber))
                    print(tempFinaNumber, "=", tempFirstNumber, "-", rightOperand)
                    tempFirstNumber = Double(messageLabel.text!)!
                    tempSign = "-"
                }
                else{
                    print("2")
                    rightOperand = Double(messageLabel.text!)!
                    tempFinaNumber = tempFirstNumber - rightOperand
                    messageLabel.text! = format(labelText:String(tempFinaNumber))
                    print(tempFinaNumber, "=", leftOperand, "-", rightOperand)
                    tempSign = "-"
                    tempFirstNumber = Double(messageLabel.text!)!
                    
                }

            case .multiply:
                if tempSign == "*" {
                    print("1")
                    tempFinaNumber = tempFirstNumber * rightOperand
                    messageLabel.text! = format(labelText:String(tempFinaNumber))
                    print(tempFinaNumber, "=", tempFirstNumber, "*", rightOperand)
                    tempFirstNumber = Double(messageLabel.text!)!
                    tempSign = "*"
                }
                else{
                    print("2")
                    rightOperand = Double(messageLabel.text!)!
                    tempFinaNumber = tempFirstNumber * rightOperand
                    messageLabel.text! = format(labelText:String(tempFinaNumber))
                    print(tempFinaNumber, "=", leftOperand, "*", rightOperand)
                    tempSign = "*"
                    tempFirstNumber = Double(messageLabel.text!)!

                }
                
            case .divide:
                if tempSign == "/" {
                    print("1")
                    tempFinaNumber = tempFirstNumber / rightOperand
                    messageLabel.text! = format(labelText:String(tempFinaNumber))
                    print(tempFinaNumber, "=", tempFirstNumber, "/", rightOperand)
                    tempFirstNumber = Double(messageLabel.text!)!
                    tempSign = "/"
                }
                else{
                    print("2")
                    rightOperand = Double(messageLabel.text!)!
                    tempFinaNumber = tempFirstNumber / rightOperand
                    messageLabel.text! = format(labelText:String(tempFinaNumber))
                    print(tempFinaNumber, "=", leftOperand, "/", rightOperand)
                    tempSign = "/"
                    tempFirstNumber = Double(messageLabel.text!)!
                    
                }
            }
        }
//        messageLabel.text = String(format: "%g", tempFinaNumber)
//        //將內存的值歸0，從新開始
//        leftOperand = 0
        isTypingNumber = false
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