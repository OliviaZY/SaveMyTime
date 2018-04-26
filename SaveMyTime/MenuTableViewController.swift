//
//  MenuTableViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 4/25/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import KYDrawerController

class MenuTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    var elDrawer : KYDrawerController? {
        return self.navigationController?.parent as? KYDrawerController
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: UIViewController = self.getNavigateToViewController(indexPath.row)
        self.elDrawer?.mainViewController = UINavigationController(rootViewController: viewController)
        self.elDrawer?.setDrawerState(KYDrawerController.DrawerState.closed, animated: true)
    }
    
    var navigateViewControllers = [Int: UIViewController]()
    
    func getNavigateToViewController(_ index: Int) -> UIViewController {
        if (self.navigateViewControllers[index] == nil) {
            switch (index) {
            case 0:
                self.navigateViewControllers[0] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TimeLineTableViewController")
                self.navigateViewControllers[0]?.view.backgroundColor = UIColor.red
            case 1:
                self.navigateViewControllers[1] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
                self.navigateViewControllers[1]?.view.backgroundColor = UIColor.blue
            case 2:
                self.navigateViewControllers[2] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
                self.navigateViewControllers[2]?.view.backgroundColor = UIColor.yellow
            default:
                break
            }
        }
        return self.navigateViewControllers[index]!
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
}
