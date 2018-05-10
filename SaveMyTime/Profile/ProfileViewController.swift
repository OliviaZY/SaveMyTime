import UIKit
import KYDrawerController
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    
    static func storyboardInstance() -> ProfileViewController? {
        let storyboard = UIStoryboard(name:String(describing: self), bundle: nil);
        return storyboard.instantiateInitialViewController() as? ProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.setUpDrawer()
        
//        self.googleLoginButton.style = .wide
        GIDSignIn.sharedInstance().uiDelegate.self = self
    }
}
