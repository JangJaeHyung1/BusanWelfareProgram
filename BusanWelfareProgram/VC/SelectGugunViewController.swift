//
//  SelectGugunViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit

class SelectGugunViewController: UIViewController {
    
//    var myPicker: UIPickerView!
    @IBOutlet weak var gugunPickerView: UIPickerView!
    
    var gugunList: [String] = ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        myPicker = UIPickerView()
//        myPicker.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
//        view.addSubview(myPicker)
//
//        myPicker.delegate = self
//        myPicker.dataSource = self
//
//
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SelectGugunViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gugunList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gugunList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select=\(row)")
    }
}
