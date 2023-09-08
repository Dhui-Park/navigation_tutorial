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
    
    @IBOutlet weak var userInputTextField: UITextField!
    
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
    
    @IBAction func popToVC(_ sender: NavigationButton) {
        print(#fileID, #function, #line, "- sender: \(sender.route)")
        
        // 1. 넘어갈 화면이 기존 네비게이션 화면 스택에 있는지 찾는다.
        // 2. 찾은 화면으로
        // 3. 네비게이션 팝을 한다.
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        var vcToNavigation: UIViewController? = nil
        
        switch sender.route {
        case .firstVC:
            vcToNavigation = viewControllers.first(where: { $0 is FirstVC })
        case .secondVC:
            vcToNavigation = viewControllers.first(where: { $0 is SecondVC })
        default:
            break
        }
        
        if let vc = vcToNavigation {
            self.navigationController?.popToViewController(vc, animated: true)
        }
        
    }
    
    
}
