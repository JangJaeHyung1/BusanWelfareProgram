//
//  InfoTableViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit

class InfoTableViewController: UIViewController{
    @IBOutlet weak var infoTableView: UITableView!
    
    var arr: [Item] = []
    var gugun: String? {
        didSet{
            self.navigationItem.title = gugun
            self.arr = []
            fetchAPI.shared.getData(numOfRows: 300, PageNo: 1) { [weak self] jsonArr in
                for i in 0 ... jsonArr.count-1 {
                    if jsonArr[i].gugun.contains((self?.gugun)!){
                        self?.arr.append(jsonArr[i])
                    }
                }
//                self?.arr = jsonArr
                self?.infoTableView.reloadData()
                
                // MARK: - SwiftyJSON 방식
                //                for i in 1 ... jsonArr!.count-1{
                //                    guard let jsonArr = jsonArr else { return }
                //                    let temp = Item(
                //                        cost: jsonArr[i].dictionaryValue["cost"]!.stringValue,
                //                        target: jsonArr[i].dictionaryValue["target"]!.stringValue,
                //                        lat: jsonArr[i].dictionaryValue["lat"]!.stringValue,
                //                        lng: jsonArr[i].dictionaryValue["lng"]!.stringValue,
                //                        dataDay: jsonArr[i].dictionaryValue["dataDay"]!.stringValue,
                //                        gugun: jsonArr[i].dictionaryValue["gugun"]!.stringValue,
                //                        centerNm: jsonArr[i].dictionaryValue["centerNm"]!.stringValue,
                //                        addrRoad: jsonArr[i].dictionaryValue["addrRoad"]!.stringValue,
                //                        tel: jsonArr[i].dictionaryValue["tel"]!.stringValue,
                //                        programNm: jsonArr[i].dictionaryValue["programNm"]!.stringValue,
                //                        programDetail: jsonArr[i].dictionaryValue["programDetail"]!.stringValue,
                //                        startDate: jsonArr[i].dictionaryValue["startDate"]!.stringValue,
                //                        finishDate: jsonArr[i].dictionaryValue["finishDate"]!.stringValue)
                //                    self.arr.append(temp)
                //                }
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTableView.estimatedRowHeight = 120;
        infoTableView.rowHeight = UITableView.automaticDimension;
        
        //        self.navigationItem.title = "둘러보기"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = #selector(showSelectGugunVC)
    }
    
    override func viewDidLayoutSubviews() {
        infoTableView.estimatedRowHeight = 120;
        infoTableView.rowHeight = UITableView.automaticDimension;
    }
    
    // MARK: - Navigation
    
    @objc func showSelectGugunVC(){
        //        UserDefaults.standard.setValue(nil, forKey: "gugun")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectGugunViewController") as? SelectGugunViewController{
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int{
                vc?.item = arr[index]
            }
        }
    }
    
}

// MARK: - sendDataDelegate 구현
extension InfoTableViewController: SendDataDelegate {
    func sendData(data gugun: String) {
        self.gugun = gugun
    }
}

// MARK: - TableView delegate, datasouce

extension InfoTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: CustomInfoTableCell = tableView.dequeueReusableCell(withIdentifier: "customInfoTableCell", for: indexPath) as? CustomInfoTableCell{
            cell.programName.text = arr[indexPath.row].programNm
            cell.programContent.text = arr[indexPath.row].programDetail
            cell.centerName.text = arr[indexPath.row].centerNm
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}
