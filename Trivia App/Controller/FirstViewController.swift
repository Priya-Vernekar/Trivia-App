//
//  FirstViewController.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        nameTextField.text = ""
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        if (GameInfo.sharedGameInfo.name).isEmpty {
            showAlert(title: "Message", message: "Please Enter name to proceed!")
            return
        }
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        setNavBackTitle(title: "Q1")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        GameInfo.sharedGameInfo.name = textField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
}

