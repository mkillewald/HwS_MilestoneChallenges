//
//  ViewController.swift
//  Milestone6
//
//  Created by Mike Killewald on 7/26/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Country Facts"
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            if let jsonString = try? String(contentsOfFile: path) {
                if let data = jsonString.data(using: String.Encoding.utf8) {
                    let json = JSON(data: data)
                    if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                        // we're OK to parse!
                        parse(json: json)
                        return
                    }
                }
            }
        }
        
        showError()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let country = countries[indexPath.row]
        
        cell.imageView?.image = UIImage(named: country.name.lowercased())
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.textLabel?.text = country.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.title = countries[indexPath.row].name
            vc.selectedCountry = countries[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let name = result["name"].stringValue
            let capital = result["capital"].stringValue
            let language = result["officialLanguage"].stringValue
            let currency = result["currency"].stringValue
            let gdp = result["gdp"].intValue
            let population = result["population"].intValue
            let area = result["area"].intValue
            let waterPercent = result["waterPercent"].floatValue
            let timezone = result["timezone"].stringValue
            let drivesOn = result["drivesOn"].stringValue
            let link = result["wikiLink"].stringValue
            
            let obj = Country(name: name, capital: capital, language: language, currency: currency, gdp: gdp, population: population, area: area, waterPercent: waterPercent, timezone: timezone, drivesOn: drivesOn, wikiLink: link)
            countries.append(obj)
        }
        
        tableView.reloadData()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the file; please check the file and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

