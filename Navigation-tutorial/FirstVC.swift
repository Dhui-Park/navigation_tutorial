//
//  ViewController.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import UIKit
import RxRelay
import RxSwift

class FirstVC: UIViewController {
    
    @IBOutlet weak var navToSecondVCBtn: UIButton!
    
    @IBOutlet weak var navToDetailVCBtn: UIButton!
    
    @IBOutlet weak var navToThirdVCBtn: UIButton!
    
    @IBOutlet weak var userInputTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var fromThirdVCLabel: UILabel!
    
    @IBOutlet weak var stepLabel: UILabel!
    
    
    var stepNumber: Int = 1 {
        // 프로퍼티 옵저버(stepNumber가 결정되면 어떤 로직을 굴리겠다.)
        didSet {
            self.title = "StepNumber: \(stepNumber)"
        }
    }
    var stepNumberToPop: Int = 0
    
    var disposable: Disposable? = nil
    
    // 1. 어디에서 팝을 시키는지
    // 2. 데이터도 보낸다
    var poppedEventRelay = PublishRelay<(UIViewController.Type, Any)>()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#fileID, #function, #line, "- ")
        
        // Notification event 받기
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .NavigationPopEvent, object: nil)
    }
    
    @objc fileprivate func handleNotification(_ sender: Notification) {
        print(#fileID, #function, #line, "- ")
        
        guard let userInfo = sender.userInfo,
              let senderType = userInfo["senderType"] as? UIViewController.Type,
              let receivedData = userInfo["dataToSend"] as? String else { return }
        
        print(#fileID, #function, #line, "- 현재 step: \(self.stepNumber) senderType: \(senderType) receivedData: \(receivedData)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#fileID, #function, #line, "- ")
        
        NotificationCenter.default.removeObserver(self, name: .NavigationPopEvent, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- stepNumber: \(stepNumber)")
        navToSecondVCBtn.addTarget(self, action: #selector(navToSecondVC(_:)), for: .touchUpInside)
        navToDetailVCBtn.addTarget(self, action: #selector(navToDetailVC(_:)), for: .touchUpInside)
        navToThirdVCBtn.addTarget(self, action: #selector(navToThirdVC(_:)), for: .touchUpInside)
        
        disposable = poppedEventRelay.subscribe { (from, receivedData) in
                print(#fileID, #function, #line, "- from: \(from), receivedData: \(receivedData)")
            }
    }
    
    // DetailVC의 viewDidLoad가 실행되기 전에 데이터를 넣어줄 수 있다.
    // (준비) A -> B
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(#fileID, #function, #line, "- segue: \(segue.destination)")
        
        if let detailVC = segue.destination as? DetailVC {
            detailVC.someValue = userInputTextField.text ?? "no Value"
        }
    }
    
    // iOS 13+
    @IBSegueAction func navToSecondVCWithData(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> SecondVC? {
        print(#fileID, #function, #line, "- segueIdentifier: \(segueIdentifier)")
        
        let dataToSend = userInputTextField.text ?? "no Value"
        
        return SecondVC(coder: coder, someValue: dataToSend)
    }
    
    @IBSegueAction func navToThirdVCWithData(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ThirdVC? {
        print(#fileID, #function, #line, "- segueIdentifier: \(segueIdentifier)")
        
        let dataToSend = userInputTextField.text ?? "no Value"
        
        return ThirdVC(coder: coder, someText: dataToSend)
    }
    
    @objc fileprivate func navToSecondVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "navToSecondVC", sender: self)
    }
    @objc fileprivate func navToDetailVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "navToDetailVC", sender: self)
    }
    @objc fileprivate func navToThirdVC(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        self.performSegue(withIdentifier: "navToThirdVC", sender: self)
    }


    @IBAction func onPushBtnClicked(_ sender: UIButton) {
        
        if let navigation = self.navigationController as? MyNavigationController {
            navigation.pushToVC(route: .first(stepNumber + 1))
        }
    }
    
    @IBAction func goBackToFirstVC(unwindSegue: UIStoryboardSegue) {
        print(#fileID, #function, #line, "- unwindSegue: \(unwindSegue.source) ")
        
        if let secondVC = unwindSegue.source as? SecondVC {
            self.titleLabel.text = secondVC.userInputTextFieldFromSecondVC.text
        }
        
        if let thirdVC = unwindSegue.source as? ThirdVC {
            self.fromThirdVCLabel.text = thirdVC.userInputTextField.text
        }
    }
    
    fileprivate func handleVCDismissed(_ receivedData: String) {
        print(#fileID, #function, #line, "- receivedData: \(receivedData)")
    }
    
    @IBAction func handlePushAction(_ sender: NavigationButton) {
        print(#fileID, #function, #line, "- sender: \(sender.route)")
        
        guard let navigation = self.navigationController as? MyNavigationController else { return }
        
        var vcToNavigation: UIViewController? = nil
        
        switch sender.route {
            
        case .detailVC:
            
            let dataToSend = userInputTextField.text ?? "값이 없음"
            navigation.pushToVC(route: .detail(dataToSend, handleVCDismissed(_:)))
          
        case .secondVC:
            let dataToSend = userInputTextField.text ?? "no Value"
            
            navigation.pushToVC(route: .second(dataToSend, handleVCDismissed(_:)))
            
        case .thirdVC:
            
            let dataToSend = userInputTextField.text ?? "no Value"
            navigation.pushToVC(route: .third(dataToSend, self))
            
        case .fourthVC:
            navigation.pushToVC(route: .fourth(340))
        case .fifthVC:
            navigation.pushToVC(route: .fifth(200))
        default:
            break
        }
        
        if let vc = vcToNavigation {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func handleStepNumber(_ sender: UIStepper) {
        print(#fileID, #function, #line, "- sender: \(sender.value)")
        
        let stepValue = Int(sender.value)
        
        stepNumberToPop = stepValue
        
        stepLabel.text = "이동할 FirstVC step: \(stepNumberToPop)"
        
    }
    
    // 첫번째로 돌아가기 with step
    @IBAction func popToFirstVCWithStep(_ sender: UIButton) {
        print(#fileID, #function, #line, "- stepNumberToPop: \(stepNumberToPop)")
        
        
        if let navigation = self.navigationController as? MyNavigationController {
            navigation.popToVC(senderVCType: FirstVC.self,
                               destinationVCType: FirstVC.self,
                               when: { $0.stepNumber == self.stepNumberToPop },
                               dataToSend: "\(self.stepNumber)에서 보낸다")
        }
    }
    
    @IBAction func handleNavStack(_ sender: NavigationButton) {
        print(#fileID, #function, #line, "- ")
        
        switch sender.navStackAction {
        case .popLast:
            print(#fileID, #function, #line, "- popLast")
            self.navigationController?.popViewController(animated: true)
        case .deleteAll:
            print(#fileID, #function, #line, "- deleteAll")
            self.navigationController?.popToRootViewController(animated: true)
        case .reset:
            print(#fileID, #function, #line, "- reset")
            
            var vcStack: [UIViewController] = []
            
            guard let secondVC = SecondVC.getInstance(),
                  let thirdVC = ThirdVC.getInstance(),
                  let detailVC = DetailVC.getInstance(),
                  let rootVC = self.navigationController?.topViewController,
                  let existingVCStack = self.navigationController?.viewControllers else { return }
            
            vcStack.append(contentsOf: existingVCStack)
            
            vcStack.append(contentsOf: [secondVC, thirdVC, detailVC])
                  
            
            self.navigationController?.setViewControllers(vcStack, animated: true)
        }
    }
}

//MARK: - 네비게이션 관련 델리겟
extension FirstVC: NavigationPoppedDelegate {
    
    func popped(sender: UIViewController) {
        if let thirdVC = sender as? ThirdVC {
            let receivedData = thirdVC.userInputTextField.text ?? ""
            print(#fileID, #function, #line, "- receivedData: \(receivedData)")
        }
    }
    
    
}
