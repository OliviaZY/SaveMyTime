//
//  ActivityDetailViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/4/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import Firebase
import SwiftHSVColorPicker

class ActivityDetailViewController: UIViewController {
    var activity: Activity?
    var activityDocumentRef: DocumentReference?
    var listener: ListenerRegistration!
    
    @IBOutlet weak var activityNameTextField: UITextField!
    
    @IBOutlet var colorPicker: SwiftHSVColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                 target: self,
                                                                 action: #selector(self.saveActivity))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.listener = self.activityDocumentRef?.addSnapshotListener({ (documentSnap, error) in
            if let error = error {
                print("Error getting the document: \(error.localizedDescription)")
                return
            }
            if let snapshot = documentSnap {
                if let data = snapshot.data() {
                    self.activity = Activity(data: data, id: snapshot.documentID)
                } else {
                    self.activity = Activity(data: [
                        "name": "name",
                        "category": "category",
                        "created": Date()], id: snapshot.documentID)
                    self.activity?.color = UIColor.blue
                }
                self.updateView()
            }
        })
    }
    
    func updateView() {
        self.activityNameTextField.text = self.activity?.name
        if let color = self.activity?.color {
            self.colorPicker.setViewColor(color)
        }
    }
    
    @objc func saveActivity() {
        if let text = self.activityNameTextField.text {
            self.activity?.name = text
        }
        if let color = self.colorPicker.color {
            self.activity?.color = color
        }
        print(self.activity!.data)
        self.activityDocumentRef?.setData(self.activity!.data)
    }
}
