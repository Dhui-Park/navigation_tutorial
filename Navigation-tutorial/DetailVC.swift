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
    
    @IBOutlet weak var bigLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        bigLabel.text = someValue
        self.title = "Detail"
    }
    
}
