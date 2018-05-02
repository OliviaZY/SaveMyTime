import UIKit
import KYDrawerController

class ProfileViewController: UIViewController {
    
    static func storyboardInstance() -> ProfileViewController? {
        let storyboard = UIStoryboard(name:String(describing: self), bundle: nil);
        return storyboard.instantiateInitialViewController() as? ProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.setUpDrawer()
    }
}
