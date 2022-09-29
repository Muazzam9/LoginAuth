import Firebase
import UIKit

class AccountViewController: UIViewController {
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        
    }
    
    func setupAppearance() {
        view.backgroundColor = .systemBackground
        view.addSubview(closeButton)
        closeButton.setTitle("Log Out", for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 220, height: 50)
        closeButton.center = view.center
    }
    
    
    @objc func logOutButtonTapped(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        let phoneViewController = PhoneViewController()
        phoneViewController.modalPresentationStyle = .fullScreen
        self.present(phoneViewController, animated: true)
    }
}
