//
//  TimeLineViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/2/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit

class TimeLineViewController: UITabBarController {

    static func storyboardInstance() -> TimeLineViewController? {
        let storyboard = UIStoryboard(name:String(describing: self), bundle: nil);
        return storyboard.instantiateInitialViewController() as? TimeLineViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TimeLine"
        self.setUpDrawer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
