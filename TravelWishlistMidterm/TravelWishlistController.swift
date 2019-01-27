//
//  TravelWishlistController.swift
//  TravelWishlistMidterm
//
//  Created by student1 on 1/26/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class TravelWishlishViewController: UITableViewController {
    
    var placeList: PlaceList!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let place = placeList.allPlaces[indexPath.row]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.visited ? "Visited" : "Not Visited"
        if place.visited {
            cell.backgroundColor = Colors.tableVisitedColor
        } else {
            cell.backgroundColor = Colors.tableNotVisitedColor
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.allPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = placeList.allPlaces[indexPath.row]
            
            let title = "Delete \(place.name)?"
            let message = "Are you sure?"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) -> Void in
                self.placeList.removePlace(place)
                self.tableView.deleteRows(at: [indexPath], with: .automatic )
            })
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
}
