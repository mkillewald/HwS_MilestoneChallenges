//
//  Country.swift
//  Milestone6
//
//  Created by Mike Killewald on 7/31/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class Country: NSObject {
    var name: String
    var capital: String
    var language: String
    var currency: String
    var gdp: Int
    var population: Int
    var area: Int
    var waterPercent: Float
    var timezone: String
    var drivesOn: String
    var wikiLink: String
    
    var formattedGDP: String
    var formattedPopulation: String
    var formattedArea: String
    var formattedDensity: String
    var numberOfRows: Int
    
    init(name: String, capital: String, language: String, currency: String, gdp: Int, population: Int, area: Int, waterPercent: Float, timezone: String, drivesOn: String, wikiLink: String){
        self.name = name
        self.capital = capital
        self.language = language
        self.currency = currency
        self.gdp = gdp
        self.population = population
        self.area = area
        self.waterPercent = waterPercent
        self.timezone = timezone
        self.drivesOn = drivesOn
        self.wikiLink = wikiLink
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        self.formattedGDP = "$" + numberFormatter.string(from: NSNumber(value: self.gdp))! + " USD"
        self.formattedPopulation = numberFormatter.string(from: NSNumber(value: self.population))!
        self.formattedArea = numberFormatter.string(from: NSNumber(value: self.area))! + " km\u{00B2}"
        self.formattedDensity = numberFormatter.string(from: NSNumber(value: Double(self.population) / Double(self.area)))! + " /km\u{00B2}"
        
        self.numberOfRows = 11
    }

}
