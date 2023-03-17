//
//  ViewController.swift
//  calculator
//
//  Created by Shubham Mittal on 16/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 90)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

           setupNumberPad()
       }
    
    private func setupNumberPad(){
        let buttonsize: CGFloat = view.frame.size.width / 4
        
        let zerobutton = UIButton(frame: CGRect(x: 0, y: view.frame.size.height-buttonsize, width: buttonsize*3, height: buttonsize))
        zerobutton.setTitleColor(.black, for: .normal)
        zerobutton.backgroundColor = .white
        zerobutton.setTitle("0", for: .normal)
        zerobutton.tag = 1
        holder.addSubview(zerobutton)
        
        zerobutton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonsize*CGFloat(x), y: view.frame.size.height-(buttonsize*2), width: buttonsize, height: buttonsize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            holder.addSubview(button1)
            button1.tag = x+2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)

        }
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonsize*CGFloat(x), y: view.frame.size.height-(buttonsize*3), width: buttonsize, height: buttonsize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            holder.addSubview(button2)
            button2.tag = x+5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)

        }
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonsize*CGFloat(x), y: view.frame.size.height-(buttonsize*4), width: buttonsize, height: buttonsize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x+7)", for: .normal)
            holder.addSubview(button3)
            button3.tag = x+8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        let clearbutton = UIButton(frame: CGRect(x: 0, y: view.frame.size.height-(buttonsize*5), width: view.frame.size.width - 90, height: buttonsize))
        clearbutton.setTitleColor(.black, for: .normal)
        clearbutton.backgroundColor = .white
        clearbutton.setTitle("Clear All", for: .normal)
        holder.addSubview(clearbutton)
        
        let operation = ["=", "+", "-", "x", "/"]
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonsize*3, y: view.frame.size.height-(buttonsize*CGFloat(x+1)), width: buttonsize, height: buttonsize))
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .orange
            button4.setTitle(operation[x], for: .normal)
            holder.addSubview(button4)
            button4.tag = x+1
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        resultLabel.frame = CGRect(x: 20, y: clearbutton.frame.origin.y - 110.0 , width: view.frame.width-40, height: 100)
        holder.addSubview(resultLabel)
        
        clearbutton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }
    
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
    }
    @objc func zeroTapped() {

           if resultLabel.text != "0" {
               if let text = resultLabel.text {
                   resultLabel.text = "\(text)\(0)"
               }
           }
       }

    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = currentOperation{
                var secondNumber = 0
                    if let text = resultLabel.text, let value = Int(text) {
                        secondNumber = value
                }
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                }
            }
            
        }else if tag == 2{
            currentOperation = .add
        }else if tag == 3{
            currentOperation = .subtract
        }else if tag == 4{
            currentOperation = .multiply
        }else if tag == 5{
            currentOperation = .divide
        }
    }

}

