//
//  Extension+Protocol+Constraint.swift
//  Core Data
//
//  Created by Mac on 14/02/2023.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fruits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        
        let fruit = self.fruits![indexPath.row]
        cell.nameLabel.text = fruit.name
        cell.textLabel?.textColor = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = self.fruits![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Fruit", message: "Edit Name", preferredStyle: .alert)
        alert.addTextField()
        
        let textField = alert.textFields![0]
        
        textField.text = fruit.name
        
        //MARK: - configure button handler
        let saveBtn = UIAlertAction(title: "Save", style: .default) {
            (action) in
            
        //MARK: - get the textfield fot the alert
            let textField = alert.textFields![0]
            
        //MARK: - edit the name property of the fruit object
            fruit.name = textField.text
            
        //MARK: - save the data
            do {
                try self.context.save()
            }
            catch {
                
            }
            
        //MARK: - re-fetch the data
            self.fetchFruits()
        }
        alert.addAction(saveBtn)
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
        //MARK: - fruit to delete
            let removeFruit = self.fruits![indexPath.row]
            
        //MARK: - delete fruit
            self.context.delete(removeFruit)
            
        //MARK: - save fruit
            do {
                try self.context.save()
            }
            catch {
                
            }
            
        //MARK: - re-fetch fruit
            self.fetchFruits()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func setUpViews() {
        view.addSubview(addButton)
        view.addSubview(tableview)
        view.addSubview(playButton)
        view.addSubview(profile)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableview.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            profile.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            profile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
