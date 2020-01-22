//
//  ViewController.swift
//  FoodTracker
//
//  Created by Joshua Lee on 1/11/20.
//  Copyright © 2020 Joshua Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
    }


    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
    //Since this method returns true, the system processes the touch of the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    //Method called after textFieldShouldReturn and allows access to the text of the textfield
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        mealNameLabel.text = textField.text
    }
}

