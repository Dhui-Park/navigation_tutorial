//
//  ViewController.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/08/28.
//

import UIKit

class ViewController: UIViewController {
    
    var stepNumber: Int = 1 {
        // 프로퍼티 옵저버(stepNumber가 결정되면 어떤 로직을 굴리겠다.)
        didSet {
            self.title = "StepNumber: \(stepNumber)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onPushBtnClicked(_ sender: UIButton) {
        
        // storyboard 가져오기
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        vc.stepNumber = stepNumber + 1
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

