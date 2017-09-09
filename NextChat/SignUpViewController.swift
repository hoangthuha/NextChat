import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func signupButton(_ sender: Any) {
        signUpUser()
    }
    
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func signUpUser() {
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirm = confirmPasswordTextField.text
            else { return }
       
        if password != confirm {
            createErrorAlert("Password Error", "Password do not match")}
        else if name == "" || email == "" || password == "" {
            createErrorAlert("Missing input field", "Input field must be filled")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let validError = error {
                self.createErrorAlert("Error", validError.localizedDescription)
            }
            if let validUser = user {
                let ref = Database.database().reference()
                let post : [String : Any] = ["email" : email, "name" : name]
                ref.child("students").child(validUser.uid).setValue(post)
                self.navigationController?.popViewController(animated: true)
            }

        }
    }
    func createErrorAlert(_ title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
