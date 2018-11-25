//
//  IngredientCell.swift
//  Lauzhack18
//
//  Created by Lionel Pellier on 25/11/2018.
//  Copyright © 2018 Lionel Pellier. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var name_ingredient: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
