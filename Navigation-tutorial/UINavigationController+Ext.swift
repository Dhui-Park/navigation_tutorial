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
    
    func popToViewController<T: UIViewController>(destinationVCType: T.Type,
                                                  animated: Bool = true,
                                                  when: ((T) -> Bool)? = nil
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
    }
    
    
}
