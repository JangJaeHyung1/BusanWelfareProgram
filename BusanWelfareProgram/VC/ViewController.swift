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
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print(gugunUserDefaults)
        if gugunUserDefaults == nil {
            self.performSegue(withIdentifier: "showPickerVC", sender: nil)
//            print("showPickerVC")
        }else{
            self.performSegue(withIdentifier: "showTableVC", sender: gugunUserDefaults)
//            print("showTableVC")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gugunUserDefaults = UserDefaults.standard.string(forKey: "gugun")
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTableVC"{
            if let nav = segue.destination as? UINavigationController{
                if let vc = nav.topViewController as? InfoTableViewController{
                    vc.modalPresentationStyle = .fullScreen
                    vc.gugun = gugunUserDefaults
                }
            }
        }
        if segue.identifier == "showPickerVC"{
            if let nav = segue.destination as? UINavigationController{
                if let vc = nav.topViewController as? SelectGugunViewController{
                    vc.modalPresentationStyle = .fullScreen
                }
            }
        }
    }
    
    
}

