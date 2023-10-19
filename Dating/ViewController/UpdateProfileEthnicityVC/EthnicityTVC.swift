//
//  EthnicityTVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit
import IBAnimatable

class EthnicityTVC: UITableViewCell {

    //MARK: ---Outlets---
    @IBOutlet weak var viewMAin: AnimatableView!
    @IBOutlet weak var imgSelect: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
