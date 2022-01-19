import Foundation
import UIKit.UIViewController

public class Zilla : NSObject {
    public static let shared = Zilla()
    
    internal var transactionType: TransactionType = .new
    internal var transactionParams: TransactionParams? = nil
    internal var orderId: String = ""
    internal var publicKey: String = ""
    internal var successHandler: SuccessHandler = { _ in }
    internal var eventHandler: EventHandler = { eventName, data in }
    internal var onCloseHandler: OnCloseHandler = { }

    private override init(){
        super.init()
    }
    
    private weak var presentingViewController: UIViewController?
    private weak var presentedViewController: UIViewController?
    
    private var completionCallback: SuccessHandler?
    
    public func createNewOrder(withViewController vc: UIViewController,
                               withPublicKey publicKey: String,
                               withTransactionParams params: TransactionParams,
                               onSuccess successHandler: @escaping SuccessHandler,
                               onEvent eventHandler: @escaping EventHandler,
                               onClose onCloseHandler: @escaping OnCloseHandler = { }) {
        self.presentingViewController = vc
        self.transactionType = .new
        self.publicKey = publicKey
        self.transactionParams = params
        self.successHandler = successHandler
        self.eventHandler = eventHandler
        self.onCloseHandler = onCloseHandler
        
        let checkoutVc = CheckoutViewController(closeHandler: onCloseHandler,
                                        eventHandler: eventHandler,
                                        successHandler: successHandler)
        self.presentedViewController = checkoutVc
        presentingViewController?.present(checkoutVc, animated: true, completion: nil)
    }
    
    public func completeExistingOrder(withViewController vc: UIViewController,
                                      withPublicKey publicKey: String,
                                      withOrderId orderId: String,
                                      onSuccess successHandler: @escaping SuccessHandler,
                                      onEvent eventHandler: @escaping EventHandler,
                                      onClose onCloseHandler: @escaping OnCloseHandler = { }) {
        
        self.presentingViewController = vc
        self.transactionType = .existing
        self.publicKey = publicKey
        self.orderId = orderId
        self.successHandler = successHandler
        self.eventHandler = eventHandler
        self.onCloseHandler = onCloseHandler
        
        Logger.log("Order id \(orderId)")
        
        let checkoutVc = CheckoutViewController(closeHandler: onCloseHandler,
                                        eventHandler: eventHandler,
                                        successHandler: successHandler)
        self.presentedViewController = checkoutVc
        presentingViewController?.present(checkoutVc, animated: true, completion: nil)
    }

}
