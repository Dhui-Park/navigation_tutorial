//
//  SecondVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import Foundation
import UIKit

class SecondVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func navToThirdVCAction(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "navToThirdVC", sender: self)
    }
}
