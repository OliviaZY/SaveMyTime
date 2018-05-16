//
//  TimeLineTableViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/10/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import Firebase

let calendar = Calendar.current

extension Date {
    func get(_ component: Calendar.Component) -> Int {
        return calendar.component(component, from: self)
    }
}

class TimeLineTableViewController: UITableViewController {
    var firebaseRecordRef: CollectionReference!
    var listener: ListenerRegistration!
    
    var activities = [String: Activity]()
    var records: [[Record]] = [[Record]]()
    var now = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firebaseActivityRef = Firestore.firestore().collection("user").document(getloggedInUid()).collection("activity")
        firebaseActivityRef.getDocuments {(querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching quotes.  error: \(error!.localizedDescription)")
                return
            }
            self.activities = [String: Activity]()
            for doc in snapshot.documents {
                let activity = Activity(data: doc.data(), id:doc.documentID)
                self.activities[activity.id!] = activity
            }
        }
        
        self.firebaseRecordRef = Firestore.firestore().collection("user").document(getloggedInUid()).collection("timeLine")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.listener?.remove()
    }
    
    func setUpListener() {
        self.listener?.remove()
        self.listener = self.firebaseRecordRef
            .order(by: "start", descending:true)
            .limit(to: 50)
            .addSnapshotListener({ (snapshot, error) in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    self.records = [[Record]]()
                    self.now = Date()
                    var day = -1
                    for doc in snapshot.documents {
                        let record = Record(data: doc.data(), id:doc.documentID)
                        if record.end!.get(.day) != day {
                            self.records.append([record])
                            day = record.end!.get(.day)
                        } else {
                            self.records[self.records.count-1].append(record)
                        }
                    }
                    self.tableView.reloadData()
                }
            })
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.records.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell
        let row = self.records[indexPath.section]
        let record = row[indexPath.row]
        if let id = record.categoryId {
            if let activity = self.activities[id] {
                cell.backgroundColor = activity.color
                cell.iconLabel.text = activity.icon
                cell.CategoryNameLabel.text = activity.name
            }
        }
        cell.numActionLabel.text = "\(record.numTracked!) tracking actions"
        cell.TimeSpanLabel.text = "\(record.start!) to \(record.end!)"
        cell.timeLengthLabel.text = "\(record.activityLength)"
        return cell
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
