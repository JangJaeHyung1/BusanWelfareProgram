//
//  InfoTableCell.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/17.
//

import UIKit

class CustomInfoTableCell: UITableViewCell {
    
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
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    override func layoutSubviews() {
        cellCustomUI()
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
}
