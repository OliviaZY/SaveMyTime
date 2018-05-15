//
//  ActivityViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/1/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import SKFontAwesomeIconPickerView
import Firebase

class ActivityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var firebaseActivityRef: CollectionReference!
    var listener: ListenerRegistration!
    
    var activities: [Activity]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static func storyboardInstance() -> ActivityViewController? {
        let storyboard = UIStoryboard(name:String(describing: self), bundle: nil);
        return storyboard.instantiateInitialViewController() as? ActivityViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Activities"
        self.setUpDrawer()
        
        self.activities = []
        self.firebaseActivityRef = Firestore.firestore().collection("user").document(getloggedInUid()).collection("activity")
        self.setUpListener()
    }
    
    func setUpListener() {
        self.activities?.removeAll()
        self.listener?.remove()
        self.listener = self.firebaseActivityRef.addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching quotes.  error: \(error!.localizedDescription)")
                return
            }
            snapshot.documentChanges.forEach({ (docChange) in
                if (docChange.type == .added) {
                    print("add \(docChange.document)")
                    let activity = Activity(data: docChange.document.data(), id: docChange.document.documentID)
                    self.activities.insert(activity, at: 0)
                    self.collectionView.insertItems(at: [IndexPath(row:0, section:0)])
                } else if (docChange.type == .modified) {
                    print("modified \(docChange.document)")
                    let modifiedActivity = Activity(data: docChange.document.data(), id: docChange.document.documentID)
                    for i in 0..<self.activities.count {
                        if (self.activities[i].id == modifiedActivity.id) {
                            self.activities[i] = modifiedActivity
                            self.collectionView.reloadItems(at: [IndexPath(row:i, section:0)])
                            break
                        }
                    }
                } else if (docChange.type == .removed) {
                    for i in 0..<self.activities.count {
                        if self.activities[i].id == docChange.document.documentID {
                            self.activities.remove(at: i)
                            self.collectionView.deleteItems(at: [IndexPath(row:i, section:0)])
                            break
                        }
                    }
                }
            })
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activities!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as! ActivityCollectionViewCell
        activityCell.display(self.activities[indexPath.row])
        return activityCell
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "activityDetail" {
            if let indexPath = self.collectionView.indexPathsForSelectedItems?[0] {
                if let detailVC = segue.destination as? ActivityDetailViewController {
                    detailVC.activityDocumentRef = self.firebaseActivityRef.document(self.activities[indexPath.row].id!)
                }
            }
        }
        if segue.identifier == "activityCreate" {
            if let detailVC = segue.destination as? ActivityDetailViewController {
                detailVC.activityDocumentRef = self.firebaseActivityRef.document()
            }
        }
    }
}
