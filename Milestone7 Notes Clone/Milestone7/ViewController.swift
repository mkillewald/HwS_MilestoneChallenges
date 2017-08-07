//
//  ViewController.swift
//  Milestone7
//
//  Created by Mike Killewald on 8/5/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes = [Note]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                      
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
        navigationItem.rightBarButtonItem = self.editButtonItem

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNewNote))
        
        toolbarItems = [spacer, composeButton]
        
        navigationController?.toolbar.isTranslucent = false
        navigationController?.toolbar.tintColor = hexStringToUIColor(hex: "#CC9900")
        navigationController?.isToolbarHidden = false
        
        readNotesFromFile()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func addNewNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let newNote = Note(body: "")
            notes.append(newNote)
            vc.notes = notes
            vc.selectedNote = notes.index(of: newNote)

            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func readNotesFromFile() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.allDomainsMask, true)
        let path = paths[0] as AnyObject
        let arrPath = path.appending("/notes.plist")

        if let tempArr: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: arrPath) as? [Note] {
            notes = tempArr
        }
    }
    
    func writeNotesToFile() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.allDomainsMask, true)
        let path = paths[0] as AnyObject
        let arrPath = path.appending("/notes.plist")
        NSKeyedArchiver.archiveRootObject(notes, toFile: arrPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        let note = notes[indexPath.row]
        
        let dateString: String
        let date = DateFormatter()
        let time = DateFormatter()
        date.dateFormat = "MM/dd/yy"
        time.dateFormat = "h:mm a"
        
        if date.string(from: note.creation) == date.string(from: Date()) {
            dateString = time.string(from: note.creation)
        } else {
            dateString = date.string(from: note.creation)
        }
    
        if let lineBreakIndex = note.body.characters.index(of: "\n") {
            cell.textLabel?.text = note.body.substring(to: lineBreakIndex)
            cell.detailTextLabel?.text = "\(dateString)  " + note.body.substring(from: lineBreakIndex).trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            cell.textLabel?.text = note.body
            cell.detailTextLabel?.text = "\(dateString)  No additional text"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.notes = notes
            vc.selectedNote = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        writeNotesToFile()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
