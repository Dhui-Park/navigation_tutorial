//
//  ThirdVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import Foundation
import UIKit

class ThirdVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
    }
    
    @IBAction func goBackToSecondVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "goBackToSecondVC", sender: self)
    }
}
