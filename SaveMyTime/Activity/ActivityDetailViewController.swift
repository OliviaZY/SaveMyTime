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
import SKFontAwesomeIconPickerView

class ActivityDetailViewController: UIViewController {
    var activity: Activity?
    var activityDocumentRef: DocumentReference?
    var listener: ListenerRegistration!
    
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var iconPicker: SKFontAwesomePickerView!
    @IBOutlet weak var iconLabel: UILabel!
    
    @IBOutlet var colorPicker: SwiftHSVColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .trash,
                                                                   target: self,
                                                                   action: #selector(self.deleteActivity)),
                                                   UIBarButtonItem(barButtonSystemItem: .save,
                                                                   target: self,
                                                                   action: #selector(self.saveActivity))]
        
        self.iconPicker.didSelectClosure = { icon in
            DispatchQueue.main.async {
                self.activity?.icon = icon
                self.updateView()
            }
        }
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
                        "icon": "",
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
        if let icon = self.activity?.icon {
            self.iconLabel.text = icon
        }
    }
    
    @objc func saveActivity() {
        if let text = self.activityNameTextField.text {
            self.activity?.name = text
        }
        if let color = self.colorPicker.color {
            self.activity?.color = color
        }
        self.activityDocumentRef?.setData(self.activity!.data)
    }
    
    @objc func deleteActivity() {
        self.activityDocumentRef?.delete()
        self.navigationController?.popViewController(animated: true)
    }
}
