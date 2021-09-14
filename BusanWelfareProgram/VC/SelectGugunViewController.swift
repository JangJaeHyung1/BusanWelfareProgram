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
        
    }

    
    override func viewDidLayoutSubviews() {
        selectedPickerViewUICustom()
    }
    
    func selectedPickerViewUICustom() {
        gugunPickerView.subviews[1].backgroundColor = .clear
        
        let upLine = UIView(frame: CGRect(x: 15, y: 0, width: 150, height: 0.8))
        let underLine = UIView(frame: CGRect(x: 15, y: 60, width: 150, height: 0.8))
        
        upLine.backgroundColor = UIColor(rgb: 0x0061B4)
        underLine.backgroundColor = UIColor(rgb: 0x0061B4)
        
        gugunPickerView.subviews[1].addSubview(upLine)
        gugunPickerView.subviews[1].addSubview(underLine)
    }
}

extension SelectGugunViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))

        let gugunLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        gugunLabel.text = gugunList[row]
        gugunLabel.textAlignment = .center
        gugunLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)

        view.addSubview(gugunLabel)
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gugunList.count
    }
 
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select=\(row)")
    }
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
