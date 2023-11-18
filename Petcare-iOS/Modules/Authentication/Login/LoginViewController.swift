import UIKit
import Combine

protocol LoginViewProtocol: AnyObject {
    func loginUserControl()
}

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    var cancellables = Set<AnyCancellable>()

    ///MARK: Outlet's
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var passwordTextfield: CustomTextField!
    @IBOutlet weak var emailTextfield: CustomTextField!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var googleWithLogin: UIButton!
    
    var isExpand: Bool = false
    
    
    // MARK: - Common cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
        setupPublishers()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDissAppear), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        emailTextfield.placeholderName = "email"
        passwordTextfield.placeholderName = "password"
        passwordTextfield.isSecureTextEntry = true
    }
 
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        presenter?.navigateForgotPassword()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        presenter?.navigateMain()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        presenter?.navigateSignUp()
    }
    
    @IBAction func signInWithGoogleTapped(_ sender: Any) {
        
    }
}

extension LoginViewController {
    
    @objc func keyboardAppear() {
        if !self.isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 200)
            //self.view.frame.origin.y = self.view.frame.origin.y - 200
            self.isExpand = true
        }
    }
    
    @objc func keyboardDissAppear() {
        if isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 200)
            //self.view.frame.origin.y = 0
            self.isExpand = false
        }
    }
    
    func setupPublishers() {
        // Setup Combine publishers if needed
    }
    
}

extension LoginViewController: LoginViewProtocol {
    func loginUserControl() {
        // Handle login user control
    }
}
