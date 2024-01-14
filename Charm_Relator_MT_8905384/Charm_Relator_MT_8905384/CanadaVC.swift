//
//  CanadaVC.swift
//  Midterm
//
//  Created by Charm Johannes Relator on 2023-10-23.
//

/*
 Put a resignFirstResponder here for the keyboard.
 */

import UIKit

class CanadaVC: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityName.delegate = self;
    }
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var searchStatus: UILabel!
    
    var cityList : [String] = ["Halifax","Montreal","Toronto","Vancouver","Winnipeg"]
    
    @IBAction func searchCity(_ sender: UIButton) {
        // want the user to enter the city name irregardless of casing so I formatted the input instead.
        // also trimmed for whitespaces
        let trimmedCity = self.cityName.text!.trimmingCharacters(in: .whitespaces)
        let text = trimmedCity.capitalized;
        
        // guard against blank field and invalid input
        guard verifyCity(name: text) else {
            searchStatus.textColor = UIColor.red;
            if (text.isEmpty) {
                searchStatus.text = "Search Field is blank";
            } else {
                searchStatus.text = "We apologize, \(text) was not found.";
            }
            return
        }
        
        // display city name and image
        displayCity(name: text);
        searchStatus.textColor = UIColor.systemGreen;
        searchStatus.text = "\(text) was found!";

    }
    
    // dismisses the keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return true
    }

    // checks the array if the city exists
    func verifyCity (name : String) -> Bool {
        for city in cityList {
            if name == city {
                return true;
            }
        }
        return false;
    }
    
    func displayCity (name : String) {
        var imgFilename = "";
        for city in cityList {
            if name == city {
                imgFilename = city;
            }
        }
        cityImage.image = UIImage(named: imgFilename);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
