
import UIKit
import CheckoutiOS

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var payWithZillaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pay(_ sender: Any) {
        startNewOrder()
    }
    
    private func startNewOrder() {
        
        let amount = Int(amountTextfield.text!) ?? 0
        let title = titleTextfield.text!
        
        let randomStr = UUID().uuidString
        let ref = randomStr.substring(to: randomStr.index(randomStr.startIndex, offsetBy: 20))
        
        let params = TransactionParamsBuilder()
            .title(title)
            .amount(amount)
            .clientOrderReference(ref)
            .redirectUrl("<redirect_url>")
            .productCategory("Fashion")
            .build()
        
        Zilla.shared.createNewOrder(withViewController: self,
                                    withPublicKey: Credentials.PublicKey,
                                    withTransactionParams: params,
                                    onSuccess: { result in
            self.statusLabel.text = "Transaction status: \(result.status)"
            print(" onSuccess: \(result)")
        },
                                    onEvent: { eventName, data in
            print(" onEvent: \(eventName) data \(data)")
        })
    }
    
    private func completeExistingOrder() {
        
        Zilla.shared.completeExistingOrder(withViewController: self,
                                           withPublicKey: Credentials.PublicKey,
                                           withOrderId: "<order_code>",
                                           onSuccess: { result in
            self.statusLabel.text = "Transaction status: \(result.status)"
            print(" onSuccess: \(result)")
        }, onEvent: { eventName,data in })
        
    }
}

