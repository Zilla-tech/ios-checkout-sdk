import UIKit
import WebKit

extension CheckoutViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("window.ZillaWebInterface = window.webkit.messageHandlers.zilla;")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.progressView.isHidden = true;
        })
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
    
    public func webView(_ webView: WKWebView,didFail navigation: WKNavigation!, withError error: Error){
        self.dismiss(animated: true, completion: nil)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CheckoutViewController: WKScriptMessageHandler {
    private func parseJSON(str: String?) -> [String: AnyObject]? {
        if let data = str?.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                return json
            } catch let error as NSError {
                Logger.log("Failed to load: \(error.localizedDescription)")
                return nil
            }
        }
        
        return nil
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Logger.log("userContentController \(message)")
        if message.name == "zilla", let messageBody = parseJSON(str: (message.body as! String)){
            let data = messageBody["data"] as? [String: Any]  ?? [:]
            let type = messageBody["type"] as? String  ?? ""

            switch type {
            case Constants.EVENT_COMPLETED_PAYMENT:
                
                let result = TransactionResult(clientOrderReference: data["clientOrderReference"] as? String ?? "",
                                               status: data["status"] as? String ?? "",
                                               zillaOrderCode: data["zillaOrderCode"] as? String ?? "")
                self.successHandler(result)
                self.dismiss(animated: true, completion: nil)
                break
            case Constants.EVENT_CLOSED:
                self.closeHandler()
                self.dismiss(animated: true, completion: nil)
                break
            default:
                self.eventHandler(type, data)
                self.dismiss(animated: true, completion: nil)
                break
            }
        }
    }
}
