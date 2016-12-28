//
//  ViewController.swift
//  MemeMe
//
//  Created by Cole Hoffman on 12/26/16.
//  Copyright © 2016 Cody Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickImageType(_ sender: Any) {
        // alert prompting user to choose camera/photolibrary/cancel
        let alert = UIAlertController(title: "Camera, Photo Library, or Cancel?", message: "Please select an option from above", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions for alert button selection
        let photoLibAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { action in self.pickAnImageFromAlbum(Any.self)})
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler:
            { action in self.pickAnImageFromCamera(Any.self)})
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(photoLibAction)
        // in case there is no camera on device
        if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
            alert.addAction(cameraAction)
        }
        alert.addAction(cancelAction)
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    func pickAnImageFromAlbum(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }

    func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

