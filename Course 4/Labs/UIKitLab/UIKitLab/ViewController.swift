//
//  ViewController.swift
//  UIKitLab
//
//  Created by Miles Norris on 6/2/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button1Pressed(_ sender: Any) {
        label1.text = "This app rocks!"
    }
    
}

