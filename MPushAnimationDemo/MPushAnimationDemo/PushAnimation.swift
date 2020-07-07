//
//  PushAnimation.swift
//  MPushAnimationDemo
//
//  Created by mal on 2020/7/6.
//  Copyright © 2020 mal. All rights reserved.
//

import Foundation
import UIKit

class PushAnimation:NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        if let fvc = fromVC, let tvc = toVC {
            tvc.view.ai_left = ScreenWidth
            containerView.addSubview(tvc.view)
            UIView.animate(withDuration: duration, animations: {
                
                fvc.view.ai_left = -ScreenWidth / 2
                tvc.view.ai_left = 0
                
            }) { (finished) in
                if finished {
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        }
    }
}
