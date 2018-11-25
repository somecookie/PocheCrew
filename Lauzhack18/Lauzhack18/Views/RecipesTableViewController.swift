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
    var ingredients = [Ingredient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.title.text = recipes[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ingredients" {
            let destination = segue.destination as! IngredientsTableViewController
            destination.ingredients = ingredients
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ingredients = recipes[indexPath.row].ingredients
        performSegue(withIdentifier: "ingredients", sender: self)
    }
    
    
    
}
