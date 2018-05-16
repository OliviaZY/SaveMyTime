//
//  DrawerExtension.swift
//  SaveMyTime
//
//  Created by Yuan Zhou on 5/9/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import KYDrawerController

enum ViewId: Int {
    case TimeLine = 0
    case Activity = 1
    case Profile = 2
    case Setting = 3
    case Information = 10
}

var navigateViewControllers = [Int: UIViewController]()

extension KYDrawerController {
    func navigateTo(_ viewId: ViewId) {
        self.navigateTo(viewId.rawValue)
    }
    
    func navigateTo(_ viewId: Int) {
        let viewController: UIViewController = self.getNavigateToViewController(viewId)
        self.mainViewController = UINavigationController(rootViewController: viewController)
    }
    
    func getNavigateToViewController(_ viewId: Int) -> UIViewController {
        if (navigateViewControllers[viewId] == nil) {
            switch (viewId) {
            case 0:
                return TimeLineViewController.storyboardInstance()!
            case 1:
                return ActivityViewController.storyboardInstance()!
            case 2:
                return ProfileViewController.storyboardInstance()!
            case 3:
                return ProfileViewController.storyboardInstance()!
            case 10:
                return ProfileViewController.storyboardInstance()!
            default:
                print("Cannot navigate to viewId of \(viewId)")
            }
        }
        return navigateViewControllers[viewId]!
    }
}
