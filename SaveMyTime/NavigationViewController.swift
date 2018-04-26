//
//  NavigationViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 4/26/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import KYDrawerController

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        title = "MainViewController"
        navigationItem.leftBarButtonItem = UIBarButtonItem (
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
