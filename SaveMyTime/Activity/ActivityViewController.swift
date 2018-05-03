//
//  ActivityViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/1/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var activities: [Activity]?
    
    static func storyboardInstance() -> ActivityViewController? {
        let storyboard = UIStoryboard(name:String(describing: self), bundle: nil);
        return storyboard.instantiateInitialViewController() as? ActivityViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Activities"
        self.setUpDrawer()
        
        self.activities = []
        self.activities?.append(Activity(data: ["name": "Work", "category": "Work"], id: nil))
        self.activities?.append(Activity(data: ["name": "Work", "category": "Work"], id: nil))
        self.activities?.append(Activity(data: ["name": "Work", "category": "Work"], id: nil))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activities!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as! ActivityCollectionViewCell
        activityCell.labelView.text = "Test "
        return activityCell
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
