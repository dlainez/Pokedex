//
//  EditPokemonViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 19/2/16.
//  Copyright © 2016 Nintendo. All rights reserved.
//

import UIKit

protocol EditPokemonDelegate {
    func didChangeName(newName : String)
}

class EditPokemonViewController: UIViewController, UITextFieldDelegate {
    
    var delegate : EditPokemonDelegate!
    var defaultText : String?
    
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        newNameTextField.delegate = self
        newNameTextField.text = defaultText ?? ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    @IBAction func saveAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.delegate.didChangeName(self.newNameTextField.text!)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveAction(self)
        
        return true
    }
    
    
}
