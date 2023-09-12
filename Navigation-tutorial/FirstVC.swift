//
//  ViewController.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import UIKit

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
        
        // storyboard 가져오기
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "FirstVC") as? FirstVC {
            vc.stepNumber = stepNumber + 1
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func handlePushAction(_ sender: NavigationButton) {
        print(#fileID, #function, #line, "- sender: \(sender.route)")
        
        var vcToNavigation: UIViewController? = nil
        
        switch sender.route {
        case .secondVC:
//            vcToNavigation = SecondVC.getInstance()
            let dataToSend = userInputTextField.text ?? "no Value"
            
            let storyboard = UIStoryboard(name: "SecondVC", bundle: Bundle.main)
            guard let secondVC = storyboard.instantiateViewController(identifier: "SecondVC", creator: { coder in
                return SecondVC(coder: coder, someValue: dataToSend)
            }) as? SecondVC else { return }
            
            secondVC.dismissedWithData = { receivedData in
                print(#fileID, #function, #line, "- receivedData: \(receivedData)")
            }
            
            vcToNavigation = secondVC
            
        case .thirdVC:
//            vcToNavigation = ThirdVC.getInstance()
            
            let dataToSend = userInputTextField.text ?? "no Value"
            
            let thirdStoryboard = UIStoryboard(name: "ThirdVC", bundle: Bundle.main)
            guard let thirdVC = thirdStoryboard.instantiateInitialViewController(creator: { coder in
                return ThirdVC(coder: coder, someText: dataToSend)
            }) as? ThirdVC else { return }
            
            thirdVC.delegate = self
            
            vcToNavigation = thirdVC
            
        case .detailVC:
            let detailVC = DetailVC.getInstance()
            
            // 클로져 이벤트가 들어왔을때에 대한 정의
            detailVC?.dismissedWithData = { receivedValue in
                print(#fileID, #function, #line, "- receivedValue: \(receivedValue)")
                
            }
            
            vcToNavigation = detailVC
        case .fourthVC:
            let fourthVC = FourthVC(stepNumber: 1)
            
            vcToNavigation = fourthVC
        case .fifthVC:
            vcToNavigation = FifthVC()
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
        
        self.navigationController?.popToViewController(destinationVCType: FirstVC.self,
                                                       when: { $0.stepNumber == self.stepNumberToPop },
                                                       completion: {
            print(#fileID, #function, #line, "- ")
            
            let notiDataToSend = ["senderType": FirstVC.self,
                                  "dataToSend": "\(self.stepNumber)에서 보낸다"]
            
            // Notification으로 event 보내기
            NotificationCenter.default.post(name: .NavigationPopEvent,
                                            object: nil,
                                            userInfo: notiDataToSend
            )
        })
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
