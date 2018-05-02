//
//  StatisticsViewController.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/2/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import PieCharts

class StatisticsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var timeSpanPicker: UIPickerView!
    
    @IBOutlet weak var pieChart: PieChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pieChart.models = [
            PieSliceModel(value: 2.1, color: UIColor.yellow),
            PieSliceModel(value: 3, color: UIColor.blue),
            PieSliceModel(value: 1, color: UIColor.green)
        ]
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
        print("Selected \(row)")
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
