import UIKit
import KYDrawerController
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var drawerController:KYDrawerController?
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.drawerController = KYDrawerController(drawerDirection: KYDrawerController.DrawerDirection.left,
                                                       drawerWidth: CGFloat(300.0) )
        self.drawerController?.mainViewController = UINavigationController(
            rootViewController : ProfileViewController.storyboardInstance()!
        )
        self.drawerController?.drawerViewController = UINavigationController(
            rootViewController : MenuTableViewController.storyboardInstance()!
        )
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
        
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
//        self.showLoginViewController()
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user == nil {
//                self.showLoginViewController()
//            } else {
//                self.showWeatherPicController()
//            }
//            print("User changed \(user)")
//        }
        return true
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error with Google Sign In \(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential)
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
}


func getloggedInUid() -> String {
    return Auth.auth().currentUser!.uid
}

extension UIViewController {
    
    func setUpDrawer() {
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(didTapOpenButton)
        )
    }
    
    var appDelegate : AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var drawerController: KYDrawerController {
        return self.appDelegate.drawerController!
    }
    
    @objc func didTapOpenButton(_ sender: UIBarButtonItem) {
        self.drawerController.setDrawerState(.opened, animated: true)
    }
}
