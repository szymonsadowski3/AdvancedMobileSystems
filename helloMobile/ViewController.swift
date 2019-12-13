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
import Pastel

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var InputField: UITextField!
    
    @IBOutlet weak var FactLabel: UILabel!
    
    @IBOutlet weak var InsideScrollView: UIView!
    @IBOutlet weak var FactText: UITextView!
    @IBAction func ButtonSubmitted(_ sender: Any) {
        refreshFacts()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == InputField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    func refreshFacts() {
        print("making request...")
        
        if let inputtedNumber = InputField.text {
            print("http://numbersapi.com/\(inputtedNumber)")
            
            
            Alamofire.request("http://numbersapi.com/\(inputtedNumber)").response { response in
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
        super.viewDidLoad()
        
        InputField.delegate = self;
        ScrollView.configRefreshHeader(container:self) { [weak self] in
            self?.refreshFacts()
            
            self?.delay(1, closure: {
                self?.ScrollView.switchRefreshHeader(to: .normal(.success, 0.5))
            })
        }
        
        refreshFacts()
        
        let pastelView = PastelView(frame: InsideScrollView.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors([
            UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)
            ])
        
        pastelView.startAnimation()
        InsideScrollView.insertSubview(pastelView, at: 0)
    }
}

