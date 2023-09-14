//
//  MyNavigationController.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/09/13.
//

import Foundation
import UIKit

class MyNavigationController: UINavigationController {
    
    enum Route {
        case detail(_ dataToSend: String, _ dismissedWithData: ((String) -> Void)? = nil)
        case first(_ stepNumber: Int)
        case second(_ dataToSend: String, _ dismissedWithData: ((String) -> Void)? = nil)
        case third(_ dataToSend: String, _ delegate: NavigationPoppedDelegate? = nil)
        case fourth(_ stepNumber: Int)
        case fifth(_ stepNumber: Int)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#fileID, #function, #line, "- ")
    }
    
    /// 네비게이션 푸시 처리
    /// + 넘어갈 화면 만들기
    /// - Parameter route: 넘어갈 화면 라우트
    func pushToVC(route: Route) {
        var vcToNavigation: UIViewController? = nil
        
        switch route {
            
//        case .detail(let dataToSend, let dismissedWithData):
        case let .detail(dataToSend, dismissedWithData):
            let detailVC = DetailVC.getInstance()
            
            // 클로져 이벤트가 들어왔을때에 대한 정의
            detailVC?.dismissedWithData = dismissedWithData
            
            detailVC?.someValue = dataToSend
            
            vcToNavigation = detailVC
            
        case .first(let stepNumber):
            
            let firstVC = FirstVC.getInstance("Main")
            firstVC?.stepNumber = stepNumber
            
            vcToNavigation = firstVC
            
        case let .second(dataToSend, dismissedWithData):
            
            let storyboard = UIStoryboard(name: "SecondVC", bundle: Bundle.main)
            guard let secondVC = storyboard.instantiateViewController(identifier: "SecondVC", creator: { coder in
                return SecondVC(coder: coder, someValue: dataToSend)
            }) as? SecondVC else { return }
            
            secondVC.dismissedWithData = dismissedWithData
            
            vcToNavigation = secondVC
            
        case let .third(dataToSend, delegate):
            
            let thirdStoryboard = UIStoryboard(name: "ThirdVC", bundle: Bundle.main)
            guard let thirdVC = thirdStoryboard.instantiateInitialViewController(creator: { coder in
                return ThirdVC(coder: coder, someText: dataToSend)
            }) as? ThirdVC else { return }
            
            thirdVC.delegate = delegate
            
            vcToNavigation = thirdVC
       
        case let .fourth(stepNumber):
            let fourthVC = FourthVC(stepNumber: stepNumber)
            
            vcToNavigation = fourthVC
        case .fifth:
            vcToNavigation = FifthVC()
        default:
            break
        }
        
        if let vc = vcToNavigation {
            self.pushViewController(vc, animated: true)
        }
        
    }
    
    // 1. 어디서 팝을 시키는가
    // 2. 도착지가 어디인가
    // 2-1. 도착지 조건
    // 3. 보내는 데이터는 무엇이냐
    func popToVC<S: UIViewController, D: UIViewController>(senderVCType: S.Type,
                                                           destinationVCType: D.Type,
                                                           when: ((D) -> Bool)? = nil,
                                                           dataToSend: Any,
                                                           animated: Bool = true
    ) {
        self.popToViewController(destinationVCType: destinationVCType,
                                 animated: animated,
                                 when: when,
                                 completion: { destinationVC in
            print(#fileID, #function, #line, "- ")
            
            if let firstVC = destinationVC as? FirstVC {
                firstVC.poppedEventRelay.accept((senderVCType, dataToSend))
            }
            
            
//            let notiDataToSend = ["senderType": senderVCType,
//                                  "dataToSend": dataToSend]
//
//            // Notification으로 event 보내기
//            NotificationCenter.default.post(name: .NavigationPopEvent,
//                                            object: nil,
//                                            userInfo: notiDataToSend
//            )
        })
    }
    
}
