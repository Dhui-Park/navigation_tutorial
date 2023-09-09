//
//  NavigationButton.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/09/07.
//

import Foundation
import UIKit

class NavigationButton: UIButton {
    
    enum Route: String {
        case detailVC = "DetailVC"
        case firstVC = "FirstVC"
        case secondVC = "SecondVC"
        case thirdVC = "ThirdVC"
        case fourthVC = "FourthVC"
        case fifthVC = "FifthVC"
        
        var vcType: UIViewController.Type {
            switch self {
            case .detailVC: return DetailVC.self
            case .firstVC: return FirstVC.self
            case .secondVC: return SecondVC.self
            case .thirdVC: return ThirdVC.self
            case .fourthVC: return FourthVC.self
            case .fifthVC: return FifthVC.self
            }
        }
    }
    
    var route: Route = Route.detailVC
    
    @IBInspectable
    var routeName: String? = "" {
        willSet {
            if let changedRoute = Route(rawValue: newValue ?? "") {
                route = changedRoute
            }
        }
    }
    
    // 화면 스택 관리
    enum NavStackAction: String {
        case popLast
        case deleteAll
        case reset
    }
    
    var navStackAction: NavStackAction = NavStackAction.popLast
    
    @IBInspectable
    var navStackName: String? {
        willSet {
            if let changedAction = NavStackAction(rawValue: newValue ?? "") {
                navStackAction = changedAction
            }
        }
    }
    
}
