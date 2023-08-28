//
//  ThirdVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import Foundation
import UIKit

class ThirdVC: UIViewController {
    
    var someValue: String = "" {
        didSet {
            print(#fileID, #function, #line, "- someValue: \(someValue)")
        }
    }
    
    var someText: String = "" {
        didSet {
            print(#fileID, #function, #line, "- someText: \(someText)")
        }
    }
    
    @IBOutlet weak var fromFirstVCLabel: UILabel!
    @IBOutlet weak var fromSecondVCLabel: UILabel!
    
    init?(coder: NSCoder, someText: String) {
        self.someText = someText
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        fromFirstVCLabel.text = someText
        fromSecondVCLabel.text = someValue
    }
    
    @IBAction func goBackToSecondVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "goBackToSecondVC", sender: self)
    }
}
