//
//  RecipeCell.swift
//  Lauzhack18
//
//  Created by Lionel Pellier on 25/11/2018.
//  Copyright © 2018 Lionel Pellier. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
