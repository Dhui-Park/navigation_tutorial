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
        case firstVC = "FirstVC"
        case secondVC = "SecondVC"
        case thirdVC = "ThirdVC"
        case detailVC = "DetailVC"
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
