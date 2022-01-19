
import Foundation
import UIKit
import WebKit

class CheckoutViewController : UIViewController, WKUIDelegate {
    
    private var presenter: CheckoutPresenter?
    
    var progressView: UIProgressView
    let closeHandler: OnCloseHandler
    let eventHandler: EventHandler
    let successHandler: SuccessHandler
    
    init(closeHandler: @escaping OnCloseHandler,
         eventHandler: @escaping EventHandler,
         successHandler: @escaping SuccessHandler) {
        self.closeHandler = closeHandler
        self.eventHandler = eventHandler
        self.successHandler = successHandler

        self.progressView = UIProgressView(progressViewStyle: .bar)
        self.progressView.sizeToFit()
        super.init(nibName: nil, bundle: nil)
        
        self.progressView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 2, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
       webView.removeObserver(self, forKeyPath: "estimatedProgress")
       progressView.removeFromSuperview()
    }

    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        return webView
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        var loading: UIActivityIndicatorView?
        if #available(iOS 13.0, *) {
            loading =  UIActivityIndicatorView(style: .medium)
        } else {
            // Fallback on earlier versions
            loading =  UIActivityIndicatorView(style: .gray)
        }
        loading?.center = view.center
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading?.hidesWhenStopped = true
        return loading!
    }()
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == "estimatedProgress" {
            let progressFloat = Float(webView.estimatedProgress)
            self.progressView.setProgress(progressFloat, animated: true)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        prepareWebView()
        presenter = CheckoutPresenter(view: self, apiService: ApiService.shared)
        presenter?.initTransaction()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        self.view.addSubview(progressView)
        self.view.addSubview(loadingView)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                webView.topAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                webView.leftAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                webView.bottomAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                webView.rightAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
            ])
            
            NSLayoutConstraint.activate([
                loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        } else {
            // Fallback on earlier versions
        }
    }

    func prepareWebView() {
        self.webView.configuration.userContentController.add(self, name: "zilla")
    }
    
    
    private func addCancelButton() {
        
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(userPressedCancel))
        
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func userPressedCancel() {
        navigationController?.popViewController(animated: true)
    }
}
