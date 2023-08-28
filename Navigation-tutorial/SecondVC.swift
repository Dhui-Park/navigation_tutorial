//
//  SecondVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import Foundation
import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var navToThirdVCBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navToThirdVCBtn.addTarget(self, action: #selector(navToThirdVC(_:)), for: .touchUpInside)
    }
    @objc fileprivate func navToThirdVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "navToThirdVC", sender: self)
    }
}
