//
//  DAtaTableViewCell.swift
//  new_redy4s
//
//  Created by Bartek Lanczyk on 31.12.2016.
//  Copyright © 2016 miltenkot. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var urlDataLabel: UILabel!
    
    @IBOutlet weak var shortUrlDataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
