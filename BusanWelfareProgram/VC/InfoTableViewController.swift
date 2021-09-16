//
//  InfoTableViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit

class InfoTableViewController: UIViewController{
    
    var gugun: String? {
        didSet{
            print("didset\(gugun)")
        }
    }
    //변할때마다 출력하기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "둘러보기"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = #selector(showSelectGugunVC)
    }
    @objc func showSelectGugunVC(){
//        UserDefaults.standard.setValue(nil, forKey: "gugun")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectGugunViewController") as? SelectGugunViewController{
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
}

extension InfoTableViewController: SendDataDelegate {
    func sendData(data gugun: String) {
        self.gugun = gugun
    }
}
