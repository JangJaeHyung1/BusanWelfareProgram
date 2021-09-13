//
//  ViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/12.
//

import UIKit

class ViewController: UIViewController {
    
    var myUserDefaults: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 코어데이터 유무 파악
//        UserDefaults.standard.set(TestSwitch, forKey: "gugun")

//        iflet vc 넘겨주기
//        else 넘겨주기
    }
    override func viewWillAppear(_ animated: Bool) {
        myUserDefaults = UserDefaults.standard.string(forKey: "gugun")
    }


}

