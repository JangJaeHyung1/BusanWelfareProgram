//
//  InfoTableViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit
import RxSwift
import RxCocoa

class InfoTableViewController: UIViewController{
    
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var ifSearchEmpty: UILabel!
    
    
    private var biggestTopSafeAreaInset: CGFloat = 0
    private var arr: [Item] = []
    private var gugunArr: [Item] = []
    
    var gugun: String? {
        didSet{
            navigationItem.title = gugun
            self.indicatorView?.startAnimating()
            fetchData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gugun = UserDefaults.standard.string(forKey: "gugun")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        ifSearchEmpty.isHidden = true
        indicatorSet()
        navigationUISetting()
    }
    
    
    func fetchData(){
        gugunArr = []
        
        if arr.count == 0{
            fetchAPI.shared.getData(numOfRows: 2000, PageNo: 1) {
                [weak self] jsonArr in
                self?.arr = jsonArr
                self?.filteringGugunData()
                self?.reloadAndScrollToTop(self?.gugunArr.count == 0)
                self?.indicatorView?.stopAnimating()
            }
        }else {
            filteringGugunData()
            reloadAndScrollToTop(gugunArr.count == 0)
            navigationController?.navigationBar.sizeToFit()
            indicatorView?.stopAnimating()
        }
    }
    
    func filteringGugunData() {
        for i in 0 ... arr.count - 1 {
            if arr[i].gugun.contains(gugun!){
                gugunArr.append(arr[i])
            }
        }
    }
    
    func reloadAndScrollToTop(_ isEmpty:Bool){
        if isEmpty{
            ifSearchEmpty.isHidden = false
        } else{
            ifSearchEmpty.isHidden = true
        }
        infoTableView.reloadData()
        infoTableView.scrollToRow(at: IndexPath(row: NSNotFound, section: 0), at: .top, animated: false)
    }
    
    func indicatorSet(){
        self.view.bringSubviewToFront(self.indicatorView)
        indicatorView.hidesWhenStopped = true
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
    
    func showDetailVC(item: Item){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            vc.item = item
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
        return gugunArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomInfoTableCell = tableView.dequeueReusableCell(withIdentifier: "customInfoTableCell", for: indexPath) as! CustomInfoTableCell
        let item = gugunArr[indexPath.row]
        cell.configure(item: item)
        cell.showDetailBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.showDetailVC(item: item)
            })
            .disposed(by: cell.disposeBag)
        
        
        return cell
    }
}
