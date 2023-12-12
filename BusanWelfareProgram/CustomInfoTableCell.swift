//
//  InfoTableCell.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/17.
//

import UIKit
import RxSwift

class CustomInfoTableCell: UITableViewCell {
    var disposeBag = DisposeBag()
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var programContent: UILabel!
    
    @IBOutlet weak var centerName: UILabel!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var showDetailBtn: UIButton!
    
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        cellCustomUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func cellCustomUI(){
        cellView.layer.cornerRadius = 8
        cellView.clipsToBounds = true
        cellView.backgroundColor = .white
        
        //shadow
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.masksToBounds = false
        cellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.bounds, cornerRadius: cellView.layer.cornerRadius).cgPath
        
        cellView.layer.shadowRadius = 3 
        cellView.layer.shadowOpacity = 0.2
    }
    
    func configure(item: Item){
        programName.text = item.programNm
        programContent.text = item.programDetail
        centerName.text = item.centerNm
        targetLbl.text = "대상 : \(item.target)"
        cost.text = "비용 : \(item.cost)"
        
        selectionStyle = .none
        backgroundColor = .init(rgb: 0xFAFAFA)
    }
}
