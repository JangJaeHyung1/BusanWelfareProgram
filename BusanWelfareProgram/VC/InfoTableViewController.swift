//
//  InfoTableViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit

class InfoTableViewController: UIViewController{
    
    @IBOutlet weak var infoTableView: UITableView!
    private var biggestTopSafeAreaInset: CGFloat = 0
    private var arr: [Item] = []
    
    private var gugunArr: [Item] = []
    var gugun: String? {
        didSet{
            self.navigationItem.title = gugun
            self.gugunArr = []
            
            if arr.count == 0{
//                print("first")
                fetchAPI.shared.getData(numOfRows: 1035, PageNo: 1) { [weak self] jsonArr in
                    self?.arr = jsonArr
                    for i in 0 ... (self?.arr.count)! - 1 {
                        if (self?.arr[i].gugun.contains((self?.gugun)!))!{
                            self?.gugunArr.append((self?.arr[i])!)
                        }
                    }
                    self?.infoTableView.reloadData()
                    self?.infoTableView.scrollToRow(at: IndexPath(row: NSNotFound, section: 0), at: .top, animated: false)
                }
            }else {
//                print("second")
                for i in 0 ... self.arr.count - 1 {
                    if (self.arr[i].gugun.contains(self.gugun!)){
                        self.gugunArr.append(self.arr[i])
                    }
                }
                self.infoTableView.reloadData()
                self.infoTableView.scrollToRow(at: IndexPath(row: NSNotFound, section: 0), at: .top, animated: false)
            }

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUISetting()
    }

    func navigationUISetting(){
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
                vc?.item = gugunArr[index]
            }
        }
    }
    
    @objc func showDetailVC(sender: UIButton){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            vc.item = gugunArr[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    // MARK: - scrollToTop and show Large Title
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        self.biggestTopSafeAreaInset = max(infoTableView.safeAreaInsets.top, biggestTopSafeAreaInset)
    }
    
    func scrollToTop(animated: Bool) {
//        infoTableView.scro
        infoTableView.setContentOffset(CGPoint(x: 0, y: -biggestTopSafeAreaInset), animated: animated)
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
        return gugunArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detailSegue", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomInfoTableCell = tableView.dequeueReusableCell(withIdentifier: "customInfoTableCell", for: indexPath) as! CustomInfoTableCell
        
        cell.programName.text = gugunArr[indexPath.row].programNm
        cell.programContent.text = gugunArr[indexPath.row].programDetail
        
        cell.centerName.text = gugunArr[indexPath.row].centerNm
        cell.targetLbl.text = "대상 : \(gugunArr[indexPath.row].target)"
        cell.cost.text = "비용 : \(gugunArr[indexPath.row].cost)"
        
        cell.selectionStyle = .none
        cell.backgroundColor = .init(rgb: 0xFAFAFA)
        
        cell.showDetailBtn.tag = indexPath.row
        cell.showDetailBtn.addTarget(self,
                                     action: #selector(showDetailVC(sender:)),
                                     for: .touchUpInside)
        
        return cell
    }
}
