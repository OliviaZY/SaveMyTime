//
//  TrackTimeViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/10/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import SKFontAwesomeIconPickerView
import Firebase

class TrackTimeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        activityCell.labelView.text = self.activities[indexPath.row].name
        return activityCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedActivity = self.activities[indexPath.row]
        let firebaseRecordRef = Firestore.firestore().collection("user").document(getloggedInUid()).collection("timeLine")
        firebaseRecordRef.order(by: "start", descending:true)
            .limit(to: 1)
            .getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    var category = ""
                    if !snapshot.documents.isEmpty {
                        let doc = snapshot.documents[0]
                        let record = Record(data: doc.data(), id: doc.documentID)
                        category = record.category
                        if category == selectedActivity.category {
                            record.numTracked = record.numTracked+1
                            record.end = Date()
                            firebaseRecordRef.document(record.id).updateData(record.data)
                        } else {
                            record.category = selectedActivity.category
                            record.start = record.end
                            record.end = Date()
                            record.numTracked = 1
                            firebaseRecordRef.addDocument(data: record.data)
                        }
                    } else {
                        firebaseRecordRef.addDocument(data:
                            ["start": Date().addingTimeInterval(-100),
                             "end": Date(),
                             "numTracked": 1,
                             "category": selectedActivity.category])
                    }
                    self.tabBarController?.selectedIndex = 0
                }
            })
    }
}

