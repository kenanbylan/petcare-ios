import UIKit
import Combine

protocol LoginViewProtocol: AnyObject {
    func loginUserControl()
}

class LoginViewController: UIViewController {
    //MARK: UI Property
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var passwordTextfield: CustomTextField!
    @IBOutlet weak var emailTextfield: CustomTextField!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var googleWithLogin: UIButton!
    
    //MARK: Variable's
    var isExpand: Bool = false
    var presenter: LoginPresenterProtocol?
    var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Common cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
        setupPublishers()
        prepareInitViews()
        prepareTextfields()
        prepareKeyboard()
    }
    
    private func prepareTextfields() {
        emailTextfield.placeholder = "LOGIN_EMAIL_PLACEHOLDER".localized()
        emailTextfield.keyboardType = .emailAddress
        passwordTextfield.placeholder = "LOGIN_PASSWORD_PLACEHOLDER".localized()
        passwordTextfield.isSecureTextEntry = true
    }
    
    private func prepareKeyboard() {
        //MARK: NotificationCenter Setup
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDissAppear), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}

//MARK: Prepare Inits Views & Keyboard appear
extension LoginViewController {
    private func prepareInitViews() {
        //MARK: Screen tap
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        //MARK: Bgcolor
        view.backgroundColor = AppColors.bgColor
    }
    
    @objc func keyboardAppear() {
        if !self.isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 200)
            self.isExpand = true
        }
    }
    
    @objc func keyboardDissAppear() {
        if isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 200)
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

//MARK: Button Actions
extension LoginViewController {
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
