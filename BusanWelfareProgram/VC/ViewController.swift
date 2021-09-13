//
//  ViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/12.
//

import UIKit

class ViewController: UIViewController {
    
    var gugunUserDefaults: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 코어데이터 유무 파악
        //        UserDefaults.standard.set(TestSwitch, forKey: "gugun")
        
        //        iflet vc 넘겨주기
        //        else 넘겨주기
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if gugunUserDefaults == nil {
            self.performSegue(withIdentifier: "showPickerVC", sender: nil)
            print("showPickerVC")
        }else{
            self.performSegue(withIdentifier: "showTableVC", sender: gugunUserDefaults)
            print("showTableVC")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gugunUserDefaults = UserDefaults.standard.string(forKey: "gugun")
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTableVC"{
            if let vc = segue.destination as? InfoTableViewController{
                vc.gugun = gugunUserDefaults
                vc.modalPresentationStyle = .fullScreen
            }
        }else if segue.identifier == "showPickerVC"{
            if let vc = segue.destination as? SelectGugunViewController{
                vc.modalPresentationStyle = .fullScreen
            }
        }
    }
    
    
}

