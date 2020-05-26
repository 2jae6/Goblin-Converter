//
//  ViewController.swift
//  Goblin Converter
//
//  Created by 1 on 2020/03/02.
//  Copyright © 2020 wook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
      //  self.view.backgroundColor = UIColor(red: 9.3, green: 9.3, blue: 9.3, alpha: 9.3)
        // Do any additional setup after loading the view.
        version = 0
        
        //텍스트뷰 둥글게
        beforeText.layer.cornerRadius = 10
        afterText.layer.cornerRadius = 10
        
        //텍스트뷰 테두리
        self.beforeText.layer.borderWidth = 1.0
        self.beforeText.layer.borderColor = UIColor.black.cgColor
        
        self.afterText.layer.borderWidth = 1.0
        self.afterText.layer.borderColor = UIColor.black.cgColor
        
        //버튼 테두리
        beforeDeleteButton.layer.cornerRadius = 0.5 * beforeDeleteButton.bounds.size.height
        afterDeleteButton.layer.cornerRadius = 0.5 * afterDeleteButton.bounds.size.height
        convertButton.layer.cornerRadius = 0.5 * convertButton.bounds.size.height
        afterCopyButton.layer.cornerRadius = 0.5 * afterCopyButton.bounds.size.height
    
        
    }
    
    @IBOutlet var beforeText: UITextView!
    @IBOutlet weak var afterText: UITextView!
    @IBOutlet weak var goblinSwitchOutlet: UISegmentedControl!
    
    
    @IBOutlet weak var afterCopyButton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    
    
    
    @IBOutlet weak var afterDeleteButton: UIButton!
    
    @IBOutlet weak var beforeDeleteButton: UIButton!
    
    
    
    
    
    
    
    
    var version: Int?
    
    @IBAction func goblinSwitch(_ sender: Any) {
        switch goblinSwitchOutlet.selectedSegmentIndex
        {
        case 0:
            print( "First Segment Selected")
            version = 0
            
        case 1:
            print( "Second Segment Selected")
            version = 1
        default:
            break
        }
    }

    @IBAction func copyButton(_ sender: Any) {
         
        UIPasteboard.general.string = afterText.text
        let alert = UIAlertController(title: "성공", message: "클립보드로 복사 완료!", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    @IBAction func afterDeleteButton(_ sender: Any) {
        afterText.text = ""
    }
    
    @IBAction func beforeDeleteButton(_ sender: Any) {
        beforeText.text = ""
    }
    
    @IBAction func convertButton(_ sender: Any) {
        self.view.endEditing(true)
        var resultText: String
        
        resultText = beforeText.text
        if resultText == ""{
            return
        }
        if version == 0{
            print("version 0 start")
            var imsi1: String = ""
            for i in 0 ... resultText.count - 1{
                imsi1 = imsi1 + goblinChange(text: "\(resultText[resultText.index(resultText.startIndex, offsetBy: i)])")
            }
            resultText = imsi1
            
            
        }else{
            print("version 1 start")
            var imsi2: String = ""
            for i in 0 ... resultText.count - 1{
                imsi2 = imsi2 + ghostChange(text: "\(resultText[resultText.index(resultText.startIndex, offsetBy: i)])")
            }
            resultText = imsi2
        }
        
        afterText.text = resultText
    }
 
    //Mark: CustomMethod
    func goblinChange(text: String)->String{
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return  text}
        
        if (value < 0xAC00 || value > 0xD7A3) { return text }   // 한글아니면 반환
        let x =  (value - 0xac00) / 28 / 21
        let y =  ((value - 0xac00) / 28) % 21
        let z =  (value - 0xac00) % 28
        let i =  UnicodeScalar(0x1100 + x)! //초성
        let j =  UnicodeScalar(0x1161 + y)! //중성
        var k =  UnicodeScalar(0x11a6 + 1 + z)! //종성
        
        var dnr = UnicodeScalar(0x1100 + 7)!
        
        if k == "\u{11A7}"{
            return "\(i)\(j)" + "\(dnr)\(j)"
        }else{
            return "\(i)\(j)" + "\(dnr)\(j)\(k)"
        }
    }
    
    func ghostChange(text: String)->String{
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return  text}
        
        if (value < 0xAC00 || value > 0xD7A3) { return text }   // 한글아니면 반환
        let x =  (value - 0xac00) / 28 / 21
        let y =  ((value - 0xac00) / 28) % 21
        let z =  (value - 0xac00) % 28
        let i =  UnicodeScalar(0x1100 + x)! //초성
        let j =  UnicodeScalar(0x1161 + y)! //중성
        var k =  UnicodeScalar(0x11a6 + 1 + z)! //종성
        
        let wo = UnicodeScalar(0x1100 + 9)!
        
        if k == "\u{11A7}"{
            return "\(i)\(j)" + "\(wo)\(j)"
        }else{
            return "\(i)\(j)" + "\(wo)\(j)\(k)"
        }
    }
    
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

