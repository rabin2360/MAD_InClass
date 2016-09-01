//
//  ViewController.swift
//  buttonClicks
//
//  Created by Rabin Ranabhat on 9/1/16.
//  Copyright © 2016 Rabin Ranabhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pictureDisplay: UIImageView!
    
    @IBAction func paintingsPressed(sender: UIButton) {
        pictureDisplay.image = UIImage(named: "monalisa.png")
    }
    
    @IBAction func drawingPressed(sender: UIButton) {
        pictureDisplay.image = UIImage(named: "anatomy.png")
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

