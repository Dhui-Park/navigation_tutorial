//
//  FifthVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/09/08.
//

import Foundation
import UIKit

class FifthVC: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(#fileID, #function, #line, "- ")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#fileID, #function, #line, "- ")
    }
    
    override func loadView() {
        super.loadView()
        print(#fileID, #function, #line, "- ")
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        self.title = "다섯번쨰"
    }
}
