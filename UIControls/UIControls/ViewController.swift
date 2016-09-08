//
//  ViewController.swift
//  UIControls
//
//  Created by Rabin Ranabhat on 9/8/16.
//  Copyright © 2016 Rabin Ranabhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pictureDisplay: UIImageView!
    @IBOutlet weak var imageController: UISegmentedControl!
    @IBOutlet weak var pictureLabel: UILabel!
    
    
    
    @IBAction func changePicture(sender: UISegmentedControl) {
        
        if(imageController.selectedSegmentIndex == 0)
        {
            pictureDisplay.image = UIImage(named: "BB_Family")
            pictureLabel.text = "Family"
        }
        else
        {
            pictureDisplay.image = UIImage(named: "BB_Kids")
            pictureLabel.text = "Kids"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

