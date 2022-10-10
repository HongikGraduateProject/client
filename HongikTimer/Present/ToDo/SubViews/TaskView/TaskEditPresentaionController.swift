//
//  TaskEditPresentaionController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import UIKit


final class TaskEditPresentaionController: UIPresentationController {
    let blurEffectView: UIVisualEffectView!
    let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(
            presentedViewController: presentedViewController,
            presenting: presentingViewController
        )
        tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissController)
        )
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(
            origin: CGPoint(
                x: 0,
                y: containerView!.frame.height * 0.4
            ),
            size: CGSize(
                width: containerView!.frame.width,
                height: containerView!.frame.height * 0.6
            )
        )
    }
    
    override func presentationTransitionWillBegin() {
        blurEffectView.alpha = 0
        containerView?.addSubview(blurEffectView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTarnsitionCoordinatorContext) in
            <#code#>
        })
    }
}
