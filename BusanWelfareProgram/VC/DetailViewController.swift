//
//  DetailViewController.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/13.
//

import UIKit
import MapKit

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
    }
    @IBOutlet weak var mapkit: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailVCLabelUpdate()
        mapkitUIUpdate()
    }
    
    func detailVCLabelUpdate(){
        guard let item = item else { return }
        
        programNmLabel.text = item.programNm
        programDetailLabel.text = item.programDetail
        
        targetLabel.text = item.target
        programDateLabel.text = "\(item.startDate) - \(item.finishDate)"
        programCostLabel.text = item.cost
        
        centerNmLabel.text = item.centerNm
        centerNumberLabel.text = item.centerNm
        locationLabel.text = item.addrRoad
    }
    
    func mapkitUIUpdate(){
        guard let item = item else { return }
        
        // NSString은 문자열에서 다른 자료형으로 변환하기 쉽기 때문에 String대신에 사용
        let lat = (item.lat as NSString).doubleValue
        let lng = (item.lng as NSString).doubleValue
        if (lat < 370) && (lng < 370){
            // 위도와 경도를 가지고 2D(한 점) 정보 객체를 획득
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            // 한 점에서 부터 거리(m)를 반영하여 맵의 크기를 가진 객체 획득
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 400, longitudinalMeters: 300)
            // 400m, 300m로 설정
            
            // @IBOutlet myMap: MKMapView! 에 전달
            self.mapkit.setRegion(coordinateRegion, animated: true)
            
            // 위치를 표시해줄 객체를 생성하고 앞에서 작성해준 위치값 객체 할당
            let point = MKPointAnnotation()
            point.coordinate = location
            self.mapkit.addAnnotation(point)
        }
    }
}
