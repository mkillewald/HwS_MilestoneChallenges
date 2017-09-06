//
//  ViewController.swift
//  Milestone3
//
//  Created by Mike Killewald on 7/27/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let savedItems = defaults.object(forKey: "items") as? Data {
            items = NSKeyedUnarchiver.unarchiveObject(with: savedItems) as! [String]
        }
        
        title = "Groccery List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrocceryItem", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Edit or Delete?", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields![0].text! = items[indexPath.row]
        
        ac.addAction(UIAlertAction(title: "Save", style: .default) { [unowned self] (action: UIAlertAction) in
            self.items[indexPath.row] = ac.textFields![0].text!
            self.tableView.reloadData()
            self.saveItems()
        })
        
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (action: UIAlertAction) in
            self.items.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.saveItems()
        })
        
        present(ac, animated: true)
    }
    
    func promptForItem() {
        let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [unowned self] (action: UIAlertAction) in
            self.items.append(ac.textFields![0].text!)
            self.tableView.reloadData()
            self.saveItems()
        })
        
        present(ac, animated: true)
    }
    
    func shareTapped() {
        let list = items.joined(separator: "\n")
        let initialText = "My shopping list: \n"
        
        let vc = UIActivityViewController(activityItems: [initialText, list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        
        present(vc, animated: true)
    }
    
    func saveItems() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: items)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "items")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

