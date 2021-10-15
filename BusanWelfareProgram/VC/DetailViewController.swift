//
//  DetailViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit
import NMapsMap

class DetailViewController: UIViewController {
    
    var item: Item?
    
    @IBOutlet weak var programNmLabel: UILabel!
    @IBOutlet weak var programDetailLabel: UILabel!
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var programDateLabel: UILabel!
    @IBOutlet weak var programCostLabel: UILabel!
    
    @IBOutlet weak var centerNmLabel: UILabel!
    @IBOutlet weak var centerNumberLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func callBtn(_ sender: UIButton) {
        guard let item = item else { return }
        guard let number = Int(item.tel.replacingOccurrences(of: "-", with: "")) else { return }
        
        // URLScheme 문자열을 통해 URL 인스턴스를 만들어 줍니다.
        if let url = NSURL(string: "tel://0" + "\(number)"),
           
           //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
           UIApplication.shared.canOpenURL(url as URL) {
            
            //사용가능한 URLScheme이라면 open(_:options:completionHandler:) 메소드를 호출해서
            //만들어둔 URL 인스턴스를 열어줍니다.
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBOutlet weak var naverMapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "상세보기"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailVCLabelUpdate()
        naverMap()
    }
    
    // MARK: - UIfetch
    
    func detailVCLabelUpdate(){
        guard let item = item else { return }
        
        programNmLabel.text = item.programNm
        programDetailLabel.text = item.programDetail
        
        
        if item.target.count == 0 {
            targetLabel.text = " "
        }else{
            targetLabel.text = item.target
        }
        programDateLabel.text = "\(item.startDate) ~ \(item.finishDate)"
        programCostLabel.text = item.cost
        
        centerNmLabel.text = item.centerNm
        centerNumberLabel.text = item.tel
        locationLabel.text = item.addrRoad
    }
    
    // MARK: - map
    
    func naverMap(){
        guard let item = item else { return }
        let lat = (item.lat as NSString).doubleValue
        let lng = (item.lng as NSString).doubleValue
        if (lat < 370) && (lng < 370){
            let coord = NMGLatLng(lat: lat, lng: lng)
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: coord, zoomTo: 13)
            naverMapView.moveCamera(cameraUpdate)

            
            let marker = NMFMarker()
            
            marker.iconImage = NMF_MARKER_IMAGE_BLACK
            marker.iconTintColor = UIColor.systemYellow
            
            marker.position = NMGLatLng(lat: lat, lng: lng)
            marker.mapView = naverMapView
        }
    }
}
