//
//  DetailViewController.swift
//  Milestone6
//
//  Created by Mike Killewald on 7/26/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var selectedCountry: Country!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCountry.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryInfo", for: indexPath)
        
        switch(indexPath.row){
        case 0:
            cell.textLabel?.text = "Capital:"
            cell.detailTextLabel?.text = selectedCountry.capital
        case 1:
            cell.textLabel?.text = "Official Language:"
            cell.detailTextLabel?.text = selectedCountry.language
        case 2:
            cell.textLabel?.text = "Currency:"
            cell.detailTextLabel?.text = selectedCountry.currency
        case 3:
            cell.textLabel?.text = "GDP per capita:"
            cell.detailTextLabel?.text = selectedCountry.formattedGDP
        case 4:
            cell.textLabel?.text = "Population:"
            cell.detailTextLabel?.text = selectedCountry.formattedPopulation
        case 5:
            cell.textLabel?.text = "Area:"
            cell.detailTextLabel?.text = selectedCountry.formattedArea
        case 6:
            cell.textLabel?.text = "Water %:"
            cell.detailTextLabel?.text = String(selectedCountry.waterPercent)
        case 7:
            cell.textLabel?.text = "Population Density:"
            cell.detailTextLabel?.text = selectedCountry.formattedDensity
        case 8:
            cell.textLabel?.text = "Timezone:"
            cell.detailTextLabel?.text = selectedCountry.timezone
        case 9:
            cell.textLabel?.text = "Drives on the:"
            cell.detailTextLabel?.text = selectedCountry.drivesOn
        case 10:
            cell.textLabel?.text = selectedCountry.wikiLink
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
            cell.isUserInteractionEnabled = true
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Browser") as? BrowserViewController {
            vc.title = title
            vc.selectedURL = selectedCountry.wikiLink
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func shareTapped() {
        var countryName = title!
        
        if countryName.characters.count < 3 {
            countryName = "the " + countryName
        }
        
        let initialText = "Some info about \(countryName):\n"
        let url = URL(string: selectedCountry.wikiLink)
        
        let vc = UIActivityViewController(activityItems: [initialText, url!, selectedCountry.wikiLink], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
