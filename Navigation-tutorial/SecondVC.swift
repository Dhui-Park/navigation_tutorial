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
    
    var dismissedWithData: ((String) -> Void)? = nil
    
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
    
    @IBAction func doThirdPushAction(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        
        if let thirdVC = ThirdVC.getInstance("ThirdVC") {
            self.navigationController?.pushViewController(thirdVC, animated: true)
        }
    }
    
    @IBAction func popToFirstVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        // TODO: 첫번째로 돌아가기
        // 나에게 주어진 도구가 무엇인지 본다 -
        // - 네비게이션 컨트롤러 - [화면, 화면] 안에 어떤 화면들이 있는지 알 수 있다.
        // - 특정 화면으로 이동할 수 있는 함수가 존대 - popToViewController
        
        self.navigationController?
            .popToViewController(destinationVCType: FirstVC.self,
                                 completion: {
                self.dismissedWithData?(self.userInputTextFieldFromSecondVC.text ?? "")
            })
    }
    
}

extension SecondVC: NavigationPoppedDelegate {
    
    func popped(sender: UIViewController) {
        print(#fileID, #function, #line, "- sender: \(sender)")
        
        if let thirdVC = sender as? ThirdVC {
            print(#fileID, #function, #line, "- userInput: \(thirdVC.userInputTextField.text ?? "")")
        }
    }
    
}


protocol Storyboarded {
    static func getInstance(_ storyboardName: String?) -> Self?
}

extension Storyboarded where Self: UIViewController {
    static func getInstance(_ storyboardName: String? = nil) -> Self? {
        
        let name = storyboardName ?? String(describing: self)
        // storyboard 가져오기
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self
    }
}

extension FirstVC: Storyboarded { }
extension SecondVC: Storyboarded { }
extension ThirdVC: Storyboarded { }
extension DetailVC: Storyboarded { }
