import UIKit

class ToastViewController: UIViewController {
    private let panelTransition = PanelTransition()
    override func viewDidLoad() {
        modalPresentationStyle = .custom
        transitioningDelegate = panelTransition
    }
}


// passed to the transitioning delegate
class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    // decides how to display controller: frame heirarchy
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        DimmingPresentationController(presentedViewController: presented, presenting: presenting ?? source)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissalAnimation()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentationAnimation()
    }
}

class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView?.bounds ?? CGRect(origin: .zero,
                                                     size: .zero)
        let halfHeight = bounds.height / 1.45
        return CGRect(x: 0, y: halfHeight,
                      width: bounds.width,
                      height: bounds.height - halfHeight)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        if let presentedView = presentedView {
            containerView?.addSubview(presentedView)
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.layer.cornerRadius = 50
        presentedView?.backgroundColor = .darkGray
    }
}

class DimmingPresentationController: PresentationController {
    private lazy var dimmingView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        // when presentationTransitionWillBegin function is called, we adding to the heirarchy dimming view
        containerView?.insertSubview(dimmingView, at: 0)
        animate { [unowned self] in
            self.dimmingView.alpha = 1
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        dimmingView.frame = containerView?.frame ?? CGRect(origin: .zero,
                                                           size: .zero)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if !completed { dimmingView.removeFromSuperview() }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        animate { [unowned self] in
            self.dimmingView.alpha = 0
        }
    }
    
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed { self.dimmingView.removeFromSuperview() }
    }
    
    func animate(_ callback: @escaping () -> Void) {
        // allows us to perform animations during the transition
        guard let transitionCoordinator = presentedViewController.transitionCoordinator else {
            callback()
            return
        }
        
        transitionCoordinator.animate { _ in callback() }
    }
}

class PresentationAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.3
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        createAnimator(for: transitionContext)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = createAnimator(for: transitionContext)
        animator.startAnimation()
    }
    
    private func createAnimator(for transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let destination = transitionContext.view(forKey: .to)!
        let destinationViewController = transitionContext.viewController(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: destinationViewController)
        
        destination.frame = finalFrame.offsetBy(dx: .zero, dy: finalFrame.height)
        
        let animator = UIViewPropertyAnimator(duration: duration,
                                              curve: .easeOut) {
            destination.frame = finalFrame
        }
        
        animator.addCompletion { position in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
}

class DismissalAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.3
    
    private func createAnimator(for transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let startingPoint = transitionContext.view(forKey: .from)!
        let startingViewController = transitionContext.viewController(forKey: .from)!
        let initialFrame = transitionContext.initialFrame(for: startingViewController)
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            startingPoint.frame = initialFrame.offsetBy(dx: 0, dy: initialFrame.height)
        }
        
        animator.addCompletion { position in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
    

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = createAnimator(for: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        createAnimator(for: transitionContext)
    }
}
