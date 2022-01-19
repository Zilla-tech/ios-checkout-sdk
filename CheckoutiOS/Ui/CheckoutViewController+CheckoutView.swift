import Foundation

extension CheckoutViewController : CheckoutView {
    
    func showLoading() {
        loadingView.startAnimating()
    }
    
    func dismissLoading() {
        loadingView.stopAnimating()
    }
    
    func showError(_ errorMessage: String) {
        createAlertDialog(message: errorMessage)
    }
    
    func loadWebview(withPaymentLink paymentLink: String) {
        
        guard let url = URL(string: paymentLink) else {
            showError("Some error message")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    func createAlertDialog(title: String = "Oops!",
                                   message: String = StringLiterals.GenericNetworkError,
                                   ltrActions: [UIAlertAction]! = []) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        
        if(ltrActions.count == 0){
            let defaultAction = UIAlertAction(title: StringLiterals.Ok,
                                              style: .default,
                                              handler: nil)
            alertController.addAction(defaultAction )
        }else{
            for x in ltrActions {
                alertController.addAction(x as UIAlertAction);
            }
        }
        
        self.present(alertController, animated: true, completion: nil);
    }
}
