import UIKit

// MARK: - AuthViewController
final class AuthViewController : UIViewController {
    
    // MARK: - Private Properties
    private let showWebViewSegueIdentifier = "ShowWebView"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }
    
    // MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == showWebViewSegueIdentifier else { return }
        guard let destination = segue.destination as? WebViewViewController else { return }
        
        destination.delegate = self
    }
    
    // MARK: - Private Methods
    private func configureBackButton() {
        UINavigationBar.appearance().backIndicatorImage = UIImage(resource: .backward)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(resource: .backward)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(resource: .ypBlackIOS)
    }
}

// MARK: - WebViewViewControllerDelegate
extension AuthViewController: WebViewViewControllerDelegate {
    func webViewController(
        _ vc: WebViewViewController,
        didAuthenticateWithCode code: String
    ) {
        //  process
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}
