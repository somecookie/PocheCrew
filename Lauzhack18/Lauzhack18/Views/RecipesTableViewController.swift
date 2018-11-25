//
//  RecipesTableViewController.swift
//  Lauzhack18
//
//  Created by Lionel Pellier on 24/11/2018.
//  Copyright © 2018 Lionel Pellier. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var recipes = [Recipe]()
    let recipeCell = "recipe_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 144.0
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recipeCell, for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        cell.title.text = recipe.title
        cell.ingredients = recipe.ingredients
        cell.tableView.dataSource = self
        cell.tableView.delegate = self
        
        return cell
    }
}
