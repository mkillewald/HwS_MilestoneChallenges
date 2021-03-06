//
//  DetailViewController.swift
//  Milestone2
//
//  Created by Mike Killewald on 7/26/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var countryName: String!
    var selectedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = countryName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        imageView.image = selectedImage
    }

    func shareTapped() {
        if countryName.characters.count < 3 {
            countryName = "the " + countryName
        }

        let initialText = "Some info about \(countryName!) \n\n"
        let url = URL(string: "https://www.google.com/search?q=\(title!.lowercased())")
        
        let vc = UIActivityViewController(activityItems: [imageView.image!, initialText, url!], applicationActivities: [])
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
