//
//  ActivityViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/1/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit

class ActivityViewController: UITableViewController {
    
    static func storyboardInstance() -> ActivityViewController? {
        let storyboard = UIStoryboard(name:String(describing: self), bundle: nil);
        return storyboard.instantiateInitialViewController() as? ActivityViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Activities"
        self.setUpDrawer()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
