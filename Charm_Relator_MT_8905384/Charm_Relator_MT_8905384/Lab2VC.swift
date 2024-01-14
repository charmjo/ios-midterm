//
//  ViewController.swift
//  Relator-Lab2-V2
//
//  Created by user235624 on 9/14/23.
/*
 NOTE: logo derived from this link: tlconestoga.ca
 
 - will remove the counter later
 */


import UIKit

class Lab2VC: UIViewController {
    
    @IBOutlet weak var counterDisplay: UILabel!
    @IBOutlet weak var stepValueDisplay: UILabel!
    
    var counter = 0
    var stepValue = 1
    var stepToggler = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func decrementCounter(_ sender: Any) {
        counter -= stepValue
        counterDisplay.text = String(counter)
    }
    
    @IBAction func incrementCounter(_ sender: Any) {
        counter += stepValue
        counterDisplay.text = String(counter)
    }
    
    @IBAction func toggleStepValue(_ sender: UIButton) {
        if (stepToggler == false){
            stepValue = 2
            stepValueDisplay.text = "1"
            stepToggler = true
        }
        else {
            stepValue = 1
            stepValueDisplay.text = "2"
            stepToggler = false
        }
    }
    
    @IBAction func resetCounter(_ sender: Any) {
        counter = 0
        counterDisplay.text = String(counter)
        
        stepValue = 1
        stepToggler = false
        stepValueDisplay.text = "2"
    }

}

