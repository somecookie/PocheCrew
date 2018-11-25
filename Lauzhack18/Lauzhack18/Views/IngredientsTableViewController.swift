//
//  IngredientsTableViewController.swift
//  Lauzhack18
//
//  Created by Lionel Pellier on 25/11/2018.
//  Copyright © 2018 Lionel Pellier. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UITableViewController {

    var ingredients = [Ingredient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient_cell", for: indexPath) as! IngredientCell
        cell.name_ingredient.text = ingredients[indexPath.row].ingredient
        return cell
    }

}
