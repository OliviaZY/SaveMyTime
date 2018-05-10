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
        self.title = "Profile"
        self.setUpDrawer()
        
        GIDSignIn.sharedInstance().uiDelegate.self = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                                 target: self,
                                                                 action: #selector(self.logout))
        
        self.updateLabel()
    }
    
    func updateLabel() {
        if let user = Auth.auth().currentUser {
            self.label.text = "Signed in as \(String(describing: user.uid))"
        } else {
            self.label.text = "Please sign In first"
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
