//
//  StatisticsViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/2/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import Firebase
import PieCharts

class StatisticsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var timeSpanPicker: UIPickerView!
    @IBOutlet weak var pieChart: PieChart!
    
    var firebaseActivityRef: CollectionReference!
    var firebaseRecordRef: CollectionReference!
    var listener: ListenerRegistration!
    var percentage = [String: Double]()
    var activities = [String: Activity]()
    var startDate: Date!
    var endDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firebaseActivityRef = Firestore.firestore().collection("user").document(getloggedInUid()).collection("activity")
        self.firebaseActivityRef.addSnapshotListener {(querySnapshot, error) in
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
        
        self.setUpDate(1)
        
        self.firebaseRecordRef = Firestore.firestore().collection("user").document(getloggedInUid()).collection("timeLine")
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
            .whereField("start", isGreaterThan: self.startDate)
            .whereField("start", isLessThan: self.endDate)
            .limit(to: 50)
            .addSnapshotListener({ (snapshot, error) in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    self.percentage = [String: Double]()
                    for doc in snapshot.documents {
                        let record = Record(data: doc.data(), id:doc.documentID)
                        self.percentage[record.categoryId!] = self.percentage[record.categoryId!] ?? 0 + record.activityLength
                    }
                    var models = [PieSliceModel]()
                    for (category, time) in self.percentage {
                        if let activity = self.activities[category] {
                            models.append(PieSliceModel(value: time, color: activity.color!, obj: self.activities[category]))
                        }
                    }
                    self.pieChart.models = models
                    
                    
                    let textLayerSettings = PiePlainTextLayerSettings()
                    textLayerSettings.viewRadius = 80
                    textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
                    let formatter = NumberFormatter()
                    formatter.maximumFractionDigits = 1
                    textLayerSettings.label.textGenerator = {slice in
                        let percentageStr = formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
                        let activity = slice.data.model.obj as! Activity
                        let text =  "\(activity.category) \(percentageStr)"
                        print(text)
                        return text
                    }
                    
                    let textLayer = PiePlainTextLayer()
                    textLayer.settings = textLayerSettings
                    self.pieChart.layers = [textLayer]
                }
            })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        var text = ""
        switch row {
        case 0:
            text = "Day"
        case 1:
            text = "Week"
        case 2:
            text = "Month"
        case 3:
            text = "Year"
        default:
            break
        }
        label.text = text
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setUpDate(row)
    }
    
    func setUpDate(_ row: Int) {
        let now = Date()
        var startComponent = DateComponents()
        switch row {
        case 0:
            startComponent.year = now.get(Calendar.Component.year)
            startComponent.month = now.get(Calendar.Component.month)
            startComponent.day = now.get(Calendar.Component.day)
        case 1:
            startComponent.year = now.get(Calendar.Component.year)
            startComponent.weekOfYear = now.get(Calendar.Component.weekOfYear)
        case 2:
            startComponent.year = now.get(Calendar.Component.year)
            startComponent.month = now.get(Calendar.Component.month)
        case 3:
            startComponent.year = now.get(Calendar.Component.year)
        default:
            break
        }
        self.startDate = calendar.date(from: startComponent)
        self.endDate = now
    }
}
