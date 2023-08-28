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
    
    
    var stepNumber: Int = 1 {
        // 프로퍼티 옵저버(stepNumber가 결정되면 어떤 로직을 굴리겠다.)
        didSet {
            self.title = "StepNumber: \(stepNumber)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        navToSecondVCBtn.addTarget(self, action: #selector(navToSecondVC(_:)), for: .touchUpInside)
        navToDetailVCBtn.addTarget(self, action: #selector(navToDetailVC(_:)), for: .touchUpInside)
        navToThirdVCBtn.addTarget(self, action: #selector(navToThirdVC(_:)), for: .touchUpInside)
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
    }
}

