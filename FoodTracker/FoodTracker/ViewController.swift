//
//  ViewController.swift
//  FoodTracker
//
//  Created by Joshua Lee on 1/11/20.
//  Copyright © 2020 Joshua Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
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
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer)
    {
        //Dismiss Keyboard when user clicks image
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //.photoLibrary - Photos can only be picked from phone library and not taken by the camera
        //.photoLibrary is an enum constant inside an enum declaration called UIImagePickerControllerSourceType
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        //Displays the image picker controller for the user to select a photo.
        //completion argument is a completion handler which is a pice of code that executes after this method completes
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //Method is called when user taps the Cancel Button inside image picker controller
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        //info is a dictionary which is a hash table with a key and value
        //UIImagePickerController.InfoKey is an enumeration and has 10 constants defined. We want original image. Theres also editedImage or cropRect or etc.
        //as? is called downcasting. The value returned from the dictionary is casted as a UIImage. I saved a bookmark called TypeCasting
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.image = pickedImage
        }
        
    }
}
