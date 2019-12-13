//
//  ViewController.swift
//  helloMobile
//
//  Created by Daniel Mynarski on 12/12/2019.
//  Copyright © 2019 Daniel Mynarski. All rights reserved.
//

import UIKit
import Alamofire
import PullToRefreshKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var InputField: UITextField!
    
    @IBOutlet weak var FactLabel: UILabel!
    
    @IBOutlet weak var FactText: UITextView!
    @IBAction func ButtonSubmitted(_ sender: Any) {
        refreshFacts()
    }
    
    func refreshFacts() {
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
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    override func viewDidLoad() {
        
        ScrollView.configRefreshHeader(container:self) { [weak self] in
            self?.delay(2, closure: {
                self?.ScrollView.switchRefreshHeader(to: .normal(.success, 0.5))
            })
        }
        
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
}
}

