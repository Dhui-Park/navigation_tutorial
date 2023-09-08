//
//  FourthVC.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/09/08.
//

import Foundation
import UIKit

class FourthVC: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    
    var stepNumber: Int? = nil
    
    convenience init(stepNumber: Int) {
        self.init(nibName: nil, bundle: nil)
        self.stepNumber = stepNumber
        print(#fileID, #function, #line, "- ")
    }
    
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
        
        let nibName = String(describing: Self.self) // FourthVC
        
        let nib = Bundle.main.loadNibNamed(nibName, owner: self)
        
        guard let view = nib?.first as? UIView else { return }
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        self.titleLable.text = "step: \(stepNumber ?? 0)"
        self.title = "네번째 step: \(stepNumber ?? 0)"
    }
    
}
