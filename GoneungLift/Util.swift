//
//  Util.swift
//  GoneungLift
//
//  Created by 김민아 on 15/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit

func DEVICE_WIDTH() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

typealias completion = () -> Void


func ShowAlert(vc: UIViewController, tite: String, okTitle: String, okCompletion: @escaping completion, cancelTitle: String, cancelCompletion: @escaping completion) {
    
    let alert = UIAlertController.init(title: tite, message: "", preferredStyle: .alert)
    
    let action = UIAlertAction.init(title: okTitle, style: .default){ (action) in
        okCompletion()
        alert.dismiss(animated: true, completion: nil)
    }
    
    alert.addAction(action)
    
    if cancelTitle != "" {
        
        let cancelAction = UIAlertAction.init(title: okTitle, style: .default){ (action) in
            cancelCompletion()
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
    }
    
    vc.present(alert, animated: true, completion: nil)

}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height

    }
    
    func width(withConstrainedHeight font: UIFont) -> CGFloat {
        let label =  UILabel()
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.width
    }
}

class Util: NSObject {

}
