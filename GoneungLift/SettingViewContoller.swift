//
//  SettingViewContoller.swift
//  GoneungLift
//
//  Created by 김민아 on 01/08/2019.
//  Copyright © 2019 김민아. All rights reserved.
//
import UIKit
import Foundation

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lbNickname: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func didTouchLogoutButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "sgMoveToLoginVC", sender: self)
        
    }
    
}
