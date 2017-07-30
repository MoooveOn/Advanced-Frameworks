//
//  ViewController.swift
//  ShakingTextField
//
//  Created by Pavel Selivanov on 19.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        entryTextField.delegate = self
    }
    
    @IBOutlet weak var entryTextField: EntryTextField!

    @IBAction func submit(_ sender: UIButton) {
        entryTextField.shake()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        entryTextField.resignFirstResponder()
        return true
    }
    
    
}

