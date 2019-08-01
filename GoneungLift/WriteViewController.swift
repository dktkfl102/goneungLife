//
//  WriteViewController.swift
//  GoneungLift
//
//  Created by 김민아 on 15/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {

    @IBOutlet weak var lbPlaceName: UILabel!
    
    var placeName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbPlaceName.text = placeName
    }
    
    @IBAction func didTouchBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
