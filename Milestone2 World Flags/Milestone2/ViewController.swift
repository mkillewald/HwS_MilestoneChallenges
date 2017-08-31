//
//  ViewController.swift
//  Milestone2
//
//  Created by Mike Killewald on 7/26/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Word Flags"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") && !item.contains("@") {
                let country = item.replacingOccurrences(of: ".png", with: "")
                countries.append(country)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
 
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        if countries[indexPath.row].characters.count < 3 {
            cell.textLabel?.text = countries[indexPath.row].uppercased()
        } else {
            cell.textLabel?.text = countries[indexPath.row].capitalized
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImageTitle = countries[indexPath.row]
            
            let cell = tableView.cellForRow(at: indexPath)
            vc.selectedImage = cell?.imageView?.image
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

