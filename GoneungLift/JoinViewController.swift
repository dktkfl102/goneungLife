//
//  JoinViewController.swift
//  GoneungLift
//
//  Created by 김민아 on 15/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfNick: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    @IBOutlet weak var tfPwCheck: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTouchJoinButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didTouchLoginButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
