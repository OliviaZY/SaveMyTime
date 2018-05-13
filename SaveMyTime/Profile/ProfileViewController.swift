import UIKit
import KYDrawerController
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var label: UILabel!
    
    static func storyboardInstance() -> ProfileViewController? {
        let storyboard = UIStoryboard(name:String(describing: self), bundle: nil);
        return storyboard.instantiateInitialViewController() as? ProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        
        GIDSignIn.sharedInstance().uiDelegate.self = self
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.,
//                                                                 target: self,
//                                                                 action: #selector(self.logout))
//        actionController.addAction(UIAlertAction(title: "Sign Out",
//                                                 style: .destructive,
//                                                 handler: { (action) in
//                                                    self.appDelegate.handleLogout()
//        }))
        
        
        self.updateLabel()
    }
    
    func updateLabel() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.updateView(user: user)
        }
        self.updateView(user: Auth.auth().currentUser)
    }
    
    func updateView(user: User?) {
        if user == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(self.logout))
            
            //                print("User changed \(String(describing: user))")
            self.title = ""
            self.label.text = "Please sign in first"
            self.label.font.withSize(36);
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out",
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(self.logout))
            
            
            self.title = "Profile"
            self.label.text = "Signed in as \(String(describing: user?.uid))"
            
        }
    }
    
    @objc func logout() {
        try! Auth.auth().signOut()
        self.updateLabel()
    }
    
    @IBAction func signInAnonymous(_ sender: Any) {
        Auth.auth().signInAnonymously { (user, error) in
            if (error != nil) {
                print("Error with anonymous auth: \(error!.localizedDescription)")
            }
            self.updateLabel()
        }
    }
}
