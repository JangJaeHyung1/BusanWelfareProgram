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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
