//
//  RecieveDetailViewController.swift
//  GoneungLift
//
//  Created by 김민아 on 18/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit

var maxLabelWidth: CGFloat = DEVICE_WIDTH() - 30.0 - 40.0 - 15.0
var maxWidth: CGFloat = DEVICE_WIDTH() - 30.0 - 40.0 - 5.0

class SendCell: UITableViewCell {
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var alcWidthOfContentView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfContentView: NSLayoutConstraint!

    func setContent(content: String) {
        lbContent.text = content
        
        if content.width(withConstrainedHeight: UIFont.systemFont(ofSize: 15.0)) > maxLabelWidth {
            alcWidthOfContentView.constant = maxWidth
            alcHeightOfContentView.constant = content.height(withConstrainedWidth: maxLabelWidth, font: UIFont.systemFont(ofSize: 15.0)) + 24.0
        } else {
            alcWidthOfContentView.constant = content.width(withConstrainedHeight: UIFont.systemFont(ofSize: 15.0)) + 10.0
            alcHeightOfContentView.constant = 40.0
        }
    }
}

class RecieveCell: UITableViewCell {
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbPlaceName: UILabel!
    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var alcHeightOfContentView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfPlaceName: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfMapView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcWidthOfImage2: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfImage2: NSLayoutConstraint!
    
    func setContent(content: String, placeName: String, mapCode: String) {
        lbContent.text = content
        
        alcHeightOfContentView.constant = content.height(withConstrainedWidth: maxLabelWidth, font: UIFont.systemFont(ofSize: 15.0)) + 84.0
        
        if placeName == "" {
            alcHeightOfPlaceName.constant = 0.0
        } else {
            lbPlaceName.text = placeName
            alcHeightOfPlaceName.constant = 40.0
            alcHeightOfContentView.constant += alcHeightOfPlaceName.constant
        }
        
        if mapCode == "" {
            alcHeightOfMapView.constant = 0.0
        } else {
            alcHeightOfMapView.constant = 30.0
            alcHeightOfContentView.constant += alcHeightOfMapView.constant
        }
    }

    func setImage(image: String, image2: String, image3: String) {

        if image == "" {
            alcHeightOfImageView.constant = 0.0
            imageBaseView.isHidden = true
            return
        }
        
        imageBaseView.isHidden = false

        if image2 == "" {
            alcHeightOfImageView.constant = 120.0
        } else {
            alcHeightOfImageView.constant = 245.0
        }
        
        if image3 == "" {
            alcWidthOfImage2.constant = baseView.bounds.size.width
            
            alcTrailingOfImage2.constant = 0.0
        } else {
            alcWidthOfImage2.constant = (baseView.bounds.size.width-5)/2
            alcTrailingOfImage2.constant = 5.0
        }
        
        alcHeightOfContentView.constant += alcHeightOfImageView.constant
    }
}

class RecieveDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var inboxId: String!
    var dataList: [InboxContents] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetManager().requestInboxDetail(inboxId: inboxId) { (result) in
            self.dataList = result
            self.tableView.reloadData()
        }
    }
    
    @IBAction func didTouchBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let data = dataList[indexPath.item]
        let tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15.0)
        tempLabel.text = data.contents
        
        if data.send == "send" {
            
            if tempLabel.intrinsicContentSize.width > maxWidth {
                return data.contents.height(withConstrainedWidth: maxLabelWidth, font: UIFont.systemFont(ofSize: 15.0)) + 44.0
            } else {
                return 60.0
            }
        } else if data.send == "receive" {
            
            var height = data.contents.height(withConstrainedWidth: maxLabelWidth, font: UIFont.systemFont(ofSize: 15.0)) + 104.0
            
            if data.place_name != "" {
                height += 40.0
            }
            
            if data.nmap != "" {
                height += 30.0
            }
            
            if data.image != "" {
                height += 120.0
            }
            
            if data.image2 != "" {
                height += 125.0
            }
            
            return height
        }
        
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let data = dataList[indexPath.item]
        
        if data.send == "send" {
            let sendCell: SendCell = tableView.dequeueReusableCell(withIdentifier: "SendCell", for: indexPath) as! SendCell
            sendCell.setContent(content: data.contents)
            
            return sendCell
            
        } else if data.send == "receive" {
            let recieveCell: RecieveCell = tableView.dequeueReusableCell(withIdentifier: "RecieveCell", for: indexPath) as! RecieveCell
            recieveCell.setContent(content: data.contents, placeName: data.place_name, mapCode: data.nmap)
            recieveCell.setImage(image: data.image, image2: data.image2, image3: data.image3)
            return recieveCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
}
