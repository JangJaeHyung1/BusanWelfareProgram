//
//  DetailViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    
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
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "상세보기"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailVCLabelUpdate()
        appleMap()
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

    
    func appleMap() {
        guard let item = item else { return }
        let lat = (item.lat as NSString).doubleValue
        let lng = (item.lng as NSString).doubleValue
        // Set initial location (Apple's headquarters)
        let initialLocation = CLLocation(latitude: lat, longitude: lng)
        
        // Create a region around the location
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        
        // Set the map view's region to the defined region
        mapView.setRegion(coordinateRegion, animated: true)
        
        // Add an annotation (pin) at the location
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = initialLocation.coordinate
        annotation.title = item.centerNm
        annotation.subtitle = item.programNm
        mapView.addAnnotation(annotation)
    }
}
