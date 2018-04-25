
import UIKit
import KYDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainViewController   = MainViewController()
        let drawerViewController = DrawerViewController()
        let drawerController     = KYDrawerController(drawerDirection: KYDrawerController.DrawerDirection.left,
                                                      drawerWidth: CGFloat(10.0) )
        drawerController.mainViewController = UINavigationController(
            rootViewController: mainViewController
        )
        drawerController.drawerViewController = drawerViewController
        
        /* Customize
         drawerController.drawerDirection = .Right
         drawerController.drawerWidth     = 200
         */
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
        
        return true
    }
}
