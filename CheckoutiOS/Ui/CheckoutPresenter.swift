
import Foundation
import Alamofire

protocol CheckoutView : AnyObject {
    func showLoading()
    
    func dismissLoading()
    
    func showError(_ errorMessage: String)
    
    func loadWebview(withPaymentLink paymentLink: String)
}

protocol Presenter {
    init(view: CheckoutView, apiService: ApiService)
    func initTransaction()
    func verifyOrderId(orderId: String)
    func createWithPublicKey(params: TransactionParams)
}

class CheckoutPresenter: Presenter {
    
    weak var view: CheckoutView?
    let apiService: ApiService
    
    required init(view: CheckoutView, apiService: ApiService) {
        self.view = view
        self.apiService = apiService
    }
    
    func initTransaction() {
        if (Zilla.shared.transactionType == .new) {
            createWithPublicKey(params: Zilla.shared.transactionParams!)
        } else {
            verifyOrderId(orderId: Zilla.shared.orderId)
        }
    }
    
    
    func verifyOrderId(orderId: String) {
        
        let publicKeyEncoded = Zilla.shared.publicKey.toBase64()
        
        view?.showLoading()
        apiService.validateOrderId(publicKey: publicKeyEncoded, orderId: orderId) { [self] response in
            self.view?.dismissLoading()
            guard let paymentLink = response?.paymentLink else {
                self.view?.showError("Error occured, please try again")
                return
            }
            self.view?.loadWebview(withPaymentLink: paymentLink)
        } _: { error in
            self.view?.dismissLoading()
            self.view?.showError("Error occured, please try again")
        }
        
    }
    
    func createWithPublicKey(params: TransactionParams) {
        let publicKeyEncoded = Zilla.shared.publicKey.toBase64()
        
        view?.showLoading()
        apiService.createWithPublicKey(publicKey: publicKeyEncoded, request: params) { [self] response in
            self.view?.dismissLoading()
            guard let paymentLink = response?.paymentLink else {
                self.view?.showError("Error occured, please try again")
                return
            }
            self.view?.loadWebview(withPaymentLink: paymentLink)
        } _: { error in
            self.view?.dismissLoading()
            self.view?.showError("Error occured, please try again")
        }

    }
    
}
