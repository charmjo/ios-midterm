//
//  ViewController.swift
//  Lab3_2
//
//  Created by Charm Johannes Relator on 2023-09-23.
/*
     2023-09-24 Charm Johannes Relator - changed userData from array to dictionary
     2023-09-25 Charm Johannes Relator - changed keyboard behavior. Users can go to next field by clicking "Next"
                                       - did not implement numpad currently because I'm still trying to understand how to make it disappear actually works.
                                       - added appIcon and landing screen image
                                       - fixed error message display
 */


import UIKit

class Lab3VC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var userDataDisplay: UITextView!
    @IBOutlet weak var messageSubmit: UITextView!
    
    @IBOutlet weak var fnameErrorLabel: UILabel!
    @IBOutlet weak var lnameErrorLabel: UILabel!
    @IBOutlet weak var countryErrorLabel: UILabel!
    @IBOutlet weak var ageErrorLabel: UILabel!
    
    var userData = ["firstName":"",
                    "lastName":"",
                    "country":"",
                    "age":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstNameField.delegate = self
        lastNameField.delegate = self
        countryField.delegate = self
        ageField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            countryField.becomeFirstResponder()
        } else if textField == countryField {
            ageField.becomeFirstResponder()
        } else if textField == ageField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func addUserData(_ sender: UIButton) {
        if sender.currentTitle! == "Add" {
            clearErrorMessages()
        }
        
        getUserData()
        
        if validateUserData(arg: 1) {
            displayUserData()
        }
 
    }	
    
    @IBAction func submitUserData(_ sender: UIButton) {
        if !validateUserData() {
            messageSubmit.text = "Please fill in the blank fields"
            messageSubmit.textColor = UIColor.red
        } else if !validateUserData(arg: 1) {
            clearErrorMessages()
            ageErrorLabel.text = "Please enter age in numbers."
            messageSubmit.text = "Filled in data is not valid."
            messageSubmit.textColor = UIColor.red
        } else {
            clearErrorMessages()
            messageSubmit.text = "Thank you for filling up all of the fields correctly."
            messageSubmit.textColor = UIColor.green
        }
    }
    
    @IBAction func clearUserData(_ sender: UIButton) {
        userData["firstName"] = ""
        userData["lastName"] = ""
        userData["country"] = ""
        userData["age"] = ""
        
        firstNameField.text = ""
        lastNameField.text = ""
        countryField.text = ""
        ageField.text = ""
        
        clearErrorMessages()
        displayUserData()
    }
    
    func displayUserData () {
        let lineFullName = "Full Name: \(userData["firstName"]!) \(userData["lastName"]!) \n"
        let lineCountry = "Country: \(userData["country"]!) \n"
        let lineAge = "Age: \(userData["age"]!) \n"
        
        userDataDisplay.text = lineFullName+lineCountry+lineAge
    }
    
    func getUserData () {
        userData["firstName"] = firstNameField.text!
        userData["lastName"] = lastNameField.text!
        userData["country"] = countryField.text!
        userData["age"] = ageField.text!
    }
    	
    func validateUserData (arg mode:Int = 0) -> Bool {
        if mode == 0 { // check for empty fields
            var emptyFieldsList:[String] = []
            for (key, value) in userData {
                if value.isEmpty {
                    emptyFieldsList.append(key)
                }
            }
            
            if emptyFieldsList.count > 0 {
                //display error messages here.
                for index in 0...emptyFieldsList.count-1{
                    displayErrorMessage(arg: emptyFieldsList[index])
                }
                return false
            }
        } else if mode == 1 { // check if the age field is a number.
            var nanCount = 0;
            for character in userData["age"]! {
                if !character.isNumber {
                        nanCount+=1
                }
            }

            if nanCount > 0 {
                ageErrorLabel.text = "Please enter a valid age."
                return false
            }
        }
        return true
    }
    
    func displayErrorMessage (arg field:String) {
        if field=="firstName" {
            fnameErrorLabel.text = "First Name is blank."
        } else if field=="lastName" {
            lnameErrorLabel.text = "Last Name is blank."
        } else if field=="country" {
            countryErrorLabel.text = "Country is blank."
        } else if field=="age" {
            ageErrorLabel.text = "Age is blank."
        }
    }
    
    func clearErrorMessages () {
        fnameErrorLabel.text = ""
        lnameErrorLabel.text = ""
        countryErrorLabel.text = ""
        ageErrorLabel.text = ""
        
        messageSubmit.text = ""
    }
}

