//
//  FunctionViewController.swift
//  Midterm
//
//  Created by Charm Johannes Relator on 2023-10-24.
//

import UIKit

struct errorMessage {
    var field : String?;
    var type : String?;
}

class QuadraticViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        displayMessage.text = "";
        titleDisplay.text = "";
        
        aField.delegate = self;
        bField.delegate = self;
        cField.delegate = self;

        // Do any additional setup after loading the view.
        
        //dismiss the number keyboard
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBOutlet weak var aField: UITextField!
    @IBOutlet weak var bField: UITextField!
    @IBOutlet weak var cField: UITextField!
    @IBOutlet weak var displayMessage: UITextView!
    @IBOutlet weak var titleDisplay: UILabel!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true);
    }
    
    // triggered by the clear button
    @IBAction func clearForm(_ sender: UIButton) {
        aField.text = "";
        bField.text = "";
        cField.text = "";
        
        displayMessage.text = "";
        displayMessage.textColor = UIColor.systemBlue;
        titleDisplay.text = "Kindly enter values for A, B, and C to find X. ";
        titleDisplay.textColor = UIColor.systemBlue;
    }
    
    
    // triggered by the calculate button
    @IBAction func calcX(_ sender: Any) {
        
        let a = aField.text!;
        let b = bField!.text!;
        let c = cField!.text!;
        
        var textDisplay : String = "";
        
        // add validation for blanks later
        // add error message display as well
        let forValidation = ["A":a,"B":b,"C":c];
        let fieldsWithError = validateInput(input: forValidation);
        
        if fieldsWithError.count == 0 { // one real root
            let convertedInput = convertInputDouble(input: forValidation);
            let D = calcDiscriminant(a: convertedInput["A"]!, b: convertedInput["B"]!, c: convertedInput["C"]!);
            if D == 0 { // sqrt is zero so there is only one real root
                let x = calcNormalX(D: D, a: convertedInput["A"]!, b: convertedInput["B"]!, c: convertedInput["C"]!, ope: 1);
                
                textDisplay += "x: \(x) \n";
                displayMessage.textColor = UIColor.systemBlue;
                
                // setting message title
                setOutputTitle(message: "You have one real results!", color : UIColor.systemBlue);
                
            } else if D > 0 { // two real roots
                let xAdd = calcNormalX(D: D, a: convertedInput["A"]!, b: convertedInput["B"]!, c: convertedInput["C"]!, ope: 1);
                let xSub = calcNormalX(D: D, a: convertedInput["A"]!, b: convertedInput["B"]!, c: convertedInput["C"]!, ope: -1);
                textDisplay = displayRegResult(x1: xAdd, x2: xSub);
                displayMessage.textColor = UIColor.systemBlue;
                
                // setting messsage title
                setOutputTitle(message: "You have two real results!", color: UIColor.systemBlue);
                
            } else if D < 0 { // a complex number (ex. a + bi)
                // used to have some lines of code for calculating the roots here
                displayMessage.text = "";
                setOutputTitle(message: " There are no real results because the Discriminant is less than 0.", color: UIColor.systemRed);
                
            }
            
        } else {
            textDisplay = displayErrorMessages(fields: fieldsWithError);
            displayMessage.textColor = UIColor.systemRed;
            setOutputTitle(message: "Sorry, the calculation did not proceed because of the following errors:", color: UIColor.systemRed);
            
        }
        displayMessage.text = textDisplay;
    }
    
    func validateInput (input:[String:String]) -> [errorMessage] {
        var fieldsWithError:[errorMessage] = [];
        // checks for blank fields
        for (key, value) in input {
            if value.isEmpty {
                fieldsWithError.append(errorMessage(field: key, type: "Blank"));
            }
            
            // detect zeroes in input A
            if key == "A" && (Double(value) == 0) {
                // if the key already exists in the fieldswitherror array
                if let i = fieldsWithError.firstIndex(where: { $0.field == "A" }) {
                    fieldsWithError[i].type="zero";
                } else {
                    fieldsWithError.append(errorMessage(field: key, type: "Zero"));
                }
                    
            }
        }
        
        
        return fieldsWithError;
    }
    
    // convert key-float input to double
    func convertInputDouble(input:[String:String]) -> [String:Double] {
        var output = ["A":0.0,"B":0.0,"C":0.0];
        for (key, value) in input {
            let converted = Double(value);
            output[key] = converted;
        }
        return output;

    }

    func calcDiscriminant (a : Double, b : Double, c: Double) -> Double
    {
        let bSquared = pow(b, 2);
        let discriminant = bSquared - (4 * a * c);
        
        return discriminant;
    }

    // general formula for x if D is not less than 0.
    func calcNormalX (D : Double, a : Double, b : Double, c: Double, ope : Double) -> Double {
        var result : Double;
        result = ((-1 * b) + (ope * sqrt(D)) ) / (2 * a);
        
        return result;
    }

    
    
    // for non-complex numbers
    func displayRegResult(x1 : Double, x2 : Double) -> String {
        var textDisplay : String = "";
        
        textDisplay += "x1 = \(formatDouble(number: x1, floatPlaces: 6)) \n";
        textDisplay += "x2 = \(formatDouble(number: x2, floatPlaces: 6)) \n";
        
        return textDisplay;
    }
    
    // displays error messages resulting from validation
    func displayErrorMessages(fields :[errorMessage]) -> String {
        
        var textDisplay : String = "";
        
        for index in 0...fields.count-1 {
            textDisplay += "\(index+1). Input on Field \(fields[index].field!) is invalid because it is \(fields[index].type!)\n";
        }
        
        return textDisplay;
    }
    
    // format float display to 6 decimal places
    func formatDouble (number: Double, floatPlaces places: Int) -> String {
        let formatString = String (format: "%%.%df", places)
        let truncatedString = String (format: formatString, number)
        
        return truncatedString;
    }
    
    // set the colors of the title of the output, will set the contents of the title
    func setOutputTitle (message : String, color : UIColor) {
        titleDisplay.text = message;
        titleDisplay.textColor = color;
    }
    
    /* ====== Functions I am not currently using but I decided to keep them because I spent so much time formulating them. ======*/
    
    // this isn't used but I decided to keep it here for the future
    func calcRealPart (b: Double, a: Double) -> Double {
        let result = (-1 * b) / (2 * a);
        return result;
    }

    // this isn't used but I decided to keep it here for the future
    func calcImaginaryPart (D: Double, a: Double) -> Double {
        /*
            1. get the absolute value of the D
            2. separate real and imaginary computation
            3. format the complex number
         */
        let absD = abs(D)
        let result = sqrt(absD) / (2 * a);
        return result;
    }

    // this isn't used but I decided to keep it here for the future
    func displayComplexNumber (real : Double, imaginary : Double) -> String {
        var textDisplay : String;
        
        let realFormatted = formatDouble(number: real, floatPlaces: 6);
        let imaginaryFormatted = formatDouble(number: imaginary, floatPlaces: 6)
        
        textDisplay = "x1 = \(realFormatted) + \(imaginaryFormatted)i \n";
        textDisplay += "x2 = \(realFormatted) - \(imaginaryFormatted)i \n";
        
        return textDisplay;
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
