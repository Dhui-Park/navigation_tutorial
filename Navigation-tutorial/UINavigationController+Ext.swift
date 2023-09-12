//
//  UINavigationController+Ext.swift
//  Navigation-tutorial
//
//  Created by dhui on 2023/09/08.
//

import Foundation
import UIKit

extension UINavigationController {
    
    
//    if let vc = vcItem as? FirstVC {
//        return vc.stepNumber == stepNumberToPop
//    }
//
//    return false
    
    
    // 뷰컨이 팝되는 시점 알려주는 함수 만들기
    
    
    // 로직 -> 함수 -> 클로져 -> 변수
    
    /// 특정 viewController pop 시키기
    /// - Parameters:
    ///   - destinationVCType: 팝 시킬 viewController의 타입
    ///   - animated: 애니메이션 여부
    ///   - when: 조건
    ///   - completion: 팝 완료 이벤트
    func popToViewController<T: UIViewController>(destinationVCType: T.Type,
                                                  animated: Bool = true,
                                                  when: ((T) -> Bool)? = nil,
                                                  completion: (() -> Void)? = nil
    )
    {
        guard let destinationVC = self.viewControllers.first(where: { vcItem in
            print(#fileID, #function, #line, "- vcItem: \(vcItem)")
            
            
            // 일단 자료형이 아니라면 리턴
            if !vcItem.isKind(of: destinationVCType) { return false }
            
            // 밖에서 로직 정의함
            if let popVC = vcItem as? T {
                return when?(popVC) ?? true
            }
            
            return false
            
        }) else { return }
        
        self.popToViewController(destinationVC, animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    /// 팝 시키고 완료 시점 받기
    /// - Parameters:
    ///   - animated: 애니메이션 여부
    ///   - completion: 팝 완료 이벤트
    func popViewController(animated: Bool = true,
                           completion: (() -> Void)? = nil
    )
    {
        
        self.popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
}
