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
            fetchAPI.shared.getData(numOfRows: 2000, PageNo: 1) { [weak self] jsonArr in
                for i in 0 ... jsonArr.count-1 {
                    if jsonArr[i].gugun.contains((self?.gugun)!){
                        self?.arr.append(jsonArr[i])
                    }
                }
                self?.infoTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = #selector(showSelectGugunVC)
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
    
    @objc func showDetailVC(sender: UIButton){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            vc.item = arr[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detailSegue", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomInfoTableCell = tableView.dequeueReusableCell(withIdentifier: "customInfoTableCell", for: indexPath) as! CustomInfoTableCell
        
        cell.programName.text = arr[indexPath.row].programNm
        cell.programContent.text = arr[indexPath.row].programDetail
        
        cell.centerName.text = arr[indexPath.row].centerNm
        cell.targetLbl.text = "대상 : \(arr[indexPath.row].target)"
        cell.cost.text = "비용 : \(arr[indexPath.row].cost)"
        
        cell.selectionStyle = .none
        cell.backgroundColor = .init(rgb: 0xFAFAFA)
        
        cell.showDetailBtn.tag = indexPath.row
        cell.showDetailBtn.addTarget(self,
                                     action: #selector(showDetailVC(sender:)),
                                     for: .touchUpInside)
        
        return cell
    }
}
