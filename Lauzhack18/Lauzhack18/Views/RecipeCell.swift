//
//  RecipeCell.swift
//  Lauzhack18
//
//  Created by Lionel Pellier on 25/11/2018.
//  Copyright © 2018 Lionel Pellier. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var ingredients = [Ingredient]()
    
    let ingredientCell = "ingredient_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ingredientCell, for: indexPath) as! IngredientCell
        cell.nameIngredient.text! = ingredients[indexPath.row].ingredient
        debugPrint("cell")
        return cell
    }
}
