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
    @IBOutlet weak var fontController: UISlider!
    @IBOutlet weak var capitalizeController: UISwitch!
    
    @IBOutlet weak var fontSize: UILabel!
    
    @IBAction func changeFont(sender: UISlider) {
        //change the font label
        fontSize.text = String(format: "%.0f", fontController.value)
        
        let fontSizeValue = CGFloat(fontController.value)
        pictureLabel.font = UIFont.systemFontOfSize(fontSizeValue)
        //pictureLabel.font = fontController.value
    }
    
    @IBAction func capitalize(sender: UISwitch) {
        capitalize()
    }
    
    @IBAction func changePicture(sender: UISegmentedControl) {
        
        //change image
        changeImage()
        //appropriate capitalizations
        capitalize()

    }
    
    
    func changeImage()
    {
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
    
    func capitalize()
    {
        if capitalizeController.on
        {
            pictureLabel.text = pictureLabel.text?.uppercaseString
        }
        else
        {
            pictureLabel.text = pictureLabel.text?.lowercaseString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fontSize.text = String(format: "%.0f", fontController.value)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

