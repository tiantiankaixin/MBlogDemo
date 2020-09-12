//
//  ViewController.swift
//  MPushAnimationDemo
//
//  Created by mal on 2020/7/6.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var percentDrivenTransition: UIPercentDrivenInteractiveTransition? = nil
    var ges: UIPanGestureRecognizer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dic = ["test1": "123", "test2": "456"]
        print("\(dic)")
    }
    
    @IBAction func goToNextBtnClick(_ sender: UIButton) {
        navigationController?.pushViewController(ToViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(edgePanGesture(recognizer:)))
        ges = panGes
        //panGes.edges = .right
        view.addGestureRecognizer(panGes)
    }
}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            if fromVC.isMember(of: ViewController.self) {
                return PushAnimation()
            }
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController.isMember(of: PushAnimation.self) {
            return percentDrivenTransition
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController != self {
            navigationController.delegate = nil
        }
    }
}

extension ViewController {
    @objc func edgePanGesture(recognizer: UIPanGestureRecognizer) {
        let translationx = -(recognizer.translation(in: view).x)
        var progress = translationx / ScreenWidth
        progress = min(1.0, max(0.0, progress))
        let state = recognizer.state
        print("progress: \(progress)")
        if state == .began {
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.pushViewController(ToViewController(), animated: true)
        } else if state == .changed {
            percentDrivenTransition?.update(progress)
        } else if state == .cancelled || state == .ended {
            if progress > 0.5 {
                percentDrivenTransition?.finish()
            } else {
                percentDrivenTransition?.cancel()
            }
            percentDrivenTransition = nil
            if let g = ges {
                view.removeGestureRecognizer(g)
            }
        }
    }
}

