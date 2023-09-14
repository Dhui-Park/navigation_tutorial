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
    
    var delegate: NavigationPoppedDelegate? = nil
    
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
        self.navigationController?
            .popToViewController(destinationVCType: sender.route.vcType,
                                 animated: true,
                                 completion: { _ in
                print(#fileID, #function, #line, "- 팝 완료됨.")
            })
        
        // 여기서 터뜨린다B
        self.delegate?.popped(sender: self)
        
    }
    
}
