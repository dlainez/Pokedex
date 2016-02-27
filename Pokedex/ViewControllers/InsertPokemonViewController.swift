//
//  InsertPokemonViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 27/2/16.
//  Copyright © 2016 DLAINEZM. All rights reserved.
//

import UIKit

protocol InsertPokemonDelegate {
    func AddPokemonTableView(NamePokemon : String)
}

class InsertPokemonViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var insertDelegate : InsertPokemonDelegate!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self

        // Do any additional setup after loading the view.
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
    
    //MARK: - Action
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    @IBAction func doneAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.insertDelegate.AddPokemonTableView(self.nameTextField.text!)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        doneAction(self)
        
        return true
    }
    

}
