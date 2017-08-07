
//  DetailViewController.swift
//  Milestone7
//
//  Created by Mike Killewald on 8/5/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var noteBody: UITextView!
    
    var notes: [Note]!
    var selectedNote: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteBody.text = notes[selectedNote].body
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNewNote))
        
        toolbarItems = [deleteButton, spacer, composeButton]
        navigationController?.isToolbarHidden = false
        navigationController?.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        noteBody.keyboardDismissMode = .interactive
        self.edgesForExtendedLayout = []  // fix for UITextView displaying under navigation bar of the navigationController
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        // we're passing the entire notes array back to the original ViewController becuase arrays in swift are value types (not reference types)
        if let vc = viewController as? ViewController {
            vc.notes = notes
            vc.tableView.reloadData()
        }
    }
    
    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect     // This is the frame of the keyboard after it has finished animating.
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)  // This converts the keyboard's frame coords to our view's coords to handle portrait vs landscape modes.
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            noteBody.contentInset = UIEdgeInsets.zero
        } else {
            noteBody.contentInset.bottom = keyboardViewEndFrame.size.height
        }
        
        noteBody.scrollIndicatorInsets = noteBody.contentInset
        
        let selectedRange = noteBody.selectedRange
        noteBody.scrollRangeToVisible(selectedRange)
    }
    
    func shareTapped() {
        let initialText = "Hey, check this out!\n\n\(noteBody.text!)"
//        saveNote()
        
        let vc = UIActivityViewController(activityItems: [initialText], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
    func saveNote() {
        // selectedNote index is set -1 when a note instance is deleted by deleteNote(), so we check for that condition here.
        if selectedNote >= 0 {
            // check if noteBody.text is blank, and if so remove note instance.
            if noteBody.text == "" {
                notes.remove(at: selectedNote)
            } else {
                notes[selectedNote].body = noteBody.text
            }
        }
        
        writeNotesToFile()
    }
    
    func writeNotesToFile() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.allDomainsMask, true)
        let path = paths[0] as AnyObject
        let arrPath = path.appending("/notes.plist")
        NSKeyedArchiver.archiveRootObject(notes, toFile: arrPath)
    }
    
    func deleteNote() {
        notes.remove(at: selectedNote)
        selectedNote = -1  // so viewWillDisappear does not try to save deleted note instance
        navigationController?.popViewController(animated: true)
    }
    
    func addNewNote() {
        //save any changes to current note
        saveNote()
        
        //create new note
        let newNote = Note(body: "")
        notes.append(newNote)
        
        // update selectedNote index
        selectedNote = notes.index(of: newNote)
        
        //update UITextView
        noteBody.text = notes[selectedNote].body  // ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
