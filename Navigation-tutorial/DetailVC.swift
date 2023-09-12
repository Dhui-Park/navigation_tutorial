//
//  DetailVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    var someValue: String = "" {
        didSet {
            print(#fileID, #function, #line, "- someValue: \(someValue)")
        }
    }
    @IBOutlet weak var userInputTextField: UITextField!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    var dismissedWithData: ((_ userInput: String) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        bigLabel.text = someValue
        self.title = "Detail"
    }
    
    @IBAction func dismissBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        
        self.navigationController?.popViewController(completion: {
            self.dismissedWithData?(self.userInputTextField.text ?? "")
        })
    }
}
