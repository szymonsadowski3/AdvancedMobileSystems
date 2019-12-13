//
//  ViewController.swift
//  helloMobile
//
//  Created by Daniel Mynarski on 12/12/2019.
//  Copyright © 2019 Daniel Mynarski. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var InputField: UITextField!
    
    @IBOutlet weak var FactLabel: UILabel!
    
    @IBOutlet weak var FactText: UITextView!
    @IBAction func ButtonSubmitted(_ sender: Any) {
        print("making request...")
        
        if let inputtedNumber = InputField.text {
            print("http://numbersapi.com/\(inputtedNumber)/math")
            
            
            Alamofire.request("http://numbersapi.com/\(inputtedNumber)/math").response { response in
                print(response.response)
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                    self.FactText.text = utf8Text
                }
            }
        }
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
}
}

