//
//  RecieveViewController.swift
//  GoneungLift
//
//  Created by 김민아 on 18/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit

class InboxCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var alcHeightOfTitle: NSLayoutConstraint!

    func cellTitle(title: String) {
        lbTitle.text = title
        alcHeightOfTitle.constant = title.height(withConstrainedWidth: DEVICE_WIDTH() - 40, font: UIFont.systemFont(ofSize: 15.0))
    }
}

class RecieveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var inboxList: [Inbox] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetManager().requestInboxList { (results) in
            self.inboxList = results
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: - UITableViewDelegate/DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InboxCell = tableView.dequeueReusableCell(withIdentifier: "InboxCell", for: indexPath) as! InboxCell
        
        cell.cellTitle(title: inboxList[indexPath.row].subject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let titleHeight = inboxList[indexPath.row].subject.height(withConstrainedWidth: DEVICE_WIDTH()-40, font: UIFont.systemFont(ofSize: 15.0))
        
        return titleHeight + 30
    }
    
    var selectedIndex: Int! = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        self.performSegue(withIdentifier: "sgMoveToInboxDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgMoveToInboxDetailVC" {
            let vc: RecieveDetailViewController = segue.destination as! RecieveDetailViewController
            vc.inboxId = inboxList[selectedIndex].id

        }
    }

}
