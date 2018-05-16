import UIKit
import KYDrawerController
import Firebase
import GoogleSignIn
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate {
    var drawerController:KYDrawerController?
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.drawerController = KYDrawerController(drawerDirection: KYDrawerController.DrawerDirection.left,
                                                   drawerWidth: CGFloat(300.0) )
        self.drawerController?.mainViewController = UINavigationController()
        self.drawerController?.drawerViewController = UINavigationController(
            rootViewController : MenuTableViewController.storyboardInstance()!
        )
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.drawerController?.navigateTo(ViewId.Profile)
            } else {
                self.drawerController?.navigateTo(ViewId.TimeLine)
            }
            print("User changed \(user)")
        }
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if granted {
                application.registerForRemoteNotifications()
            }
        }
        UNUserNotificationCenter.current().delegate = self
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("registering notification successful")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("registering notification failed")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        // Process notification content
        
        completionHandler([.alert, .sound]) // Display notification as regular alert and play sound
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier
        
        switch actionIdentifier {
        case UNNotificationDismissActionIdentifier: // Notification was dismissed by user
            // Do something
            completionHandler()
        case UNNotificationDefaultActionIdentifier: // App was opened from notification
            // Do something
            self.drawerController?.navigateTo(ViewId.TimeLine)
            completionHandler()
        default:
            completionHandler()
        }
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
    
    @objc func didTapOpenButton(_ sender: UIBarButtonItem) {
        if Auth.auth().currentUser != nil {
            self.drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    var drawerController: KYDrawerController {
        return (UIApplication.shared.delegate as! AppDelegate).drawerController!
    }
}
