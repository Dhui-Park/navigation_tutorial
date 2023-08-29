//
//  SecondVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import Foundation
import UIKit

class SecondVC: UIViewController {
    
    var someValue: String = "" {
        didSet {
            print(#fileID, #function, #line, "- someValue: \(someValue)")
        }
    }
    
    @IBOutlet weak var userInputTextFieldFromSecondVC: UITextField!
    
    init?(coder: NSCoder, someValue: String) {
        self.someValue = someValue
        super.init(coder: coder)
        print(#fileID, #function, #line, "- ")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#fileID, #function, #line, "- ")
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = someValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#fileID, #function, #line, "- ")
        
        if let thirdVC = segue.destination as? ThirdVC {
            thirdVC.someValue = userInputTextFieldFromSecondVC.text ?? "no Value"
            thirdVC.someText = someValue
        }
    }
    
    
    
    @IBAction func navToThirdVCAction(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "navToThirdVC", sender: self)
    }
    
    @IBAction func goBackToFirstVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "goBackToFirstVC", sender: self)
    }
    
    @IBAction func goBackToSecondVC(unwindSegue: UIStoryboardSegue) {
        print(#fileID, #function, #line, "- unwindSegueSecond: \(unwindSegue.source) ")
        
    }
}
