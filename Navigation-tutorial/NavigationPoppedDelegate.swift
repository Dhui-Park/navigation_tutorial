//
//  NavigationPoppedDelegate.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/09/11.
//

import Foundation
import UIKit



/// 네비게이션 팝 처리 델리겟
protocol NavigationPoppedDelegate {
    
    /// 팝이 되었다
    /// - Parameter sender: 팝이 된 viewController
    func popped(sender: UIViewController)
}
