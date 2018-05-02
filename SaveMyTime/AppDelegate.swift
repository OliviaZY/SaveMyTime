import UIKit
import KYDrawerController
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FirebaseApp.configure()
        
// Override point for customization after application launch.
        
//        let drawerController     = KYDrawerController(drawerDirection: KYDrawerController.DrawerDirection.left,
//                                                      drawerWidth: CGFloat(10.0) )
//        drawerController.mainViewController = UINavigationController(
//            rootViewController: ProfileViewController()
//        )
//        drawerController.drawerViewController = DrawerViewController()
//        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = drawerController
//        window?.makeKeyAndVisible()
//        
        return true
    }
}
