//
//  HomeViewController.swift
//  GoneungLift
//
//  Created by 김민아 on 15/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataList: [MainContents]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        
        loadMainList()
    }

    //MARK: - UserAction
    @IBAction func didTouchReloadButton(_ sender: UIButton) {
        loadMainList()
    }
    
    //MARK: - HomeCellDelegate
    func didTouchLikeButton(isLike: Bool, index: NSInteger) {
        
    }
    
    func didTouchCommentButton(index: NSInteger) {
        let replyVC: ReplyViewController = self.storyboard?.instantiateViewController(withIdentifier: "stid-replyVC") as! ReplyViewController
        replyVC.hidesBottomBarWhenPushed = true
        replyVC.postId = dataList[index].id

        self.navigationController?.pushViewController(replyVC, animated: true)
    }
    
    func didTouchPlaceButton(inex: NSInteger) {
        
        let detailVC: PlaceDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "stid-placeDetailVC") as! PlaceDetailViewController
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.placeCode = dataList![inex].place_code
        detailVC.placeTitle = dataList![inex].place_name
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: - UICollectionViewDelegate/DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.delegate = self
        cell.index = indexPath.item
        
        let data = dataList![indexPath.item] as MainContents
        
        cell.setContents(title: data.place_name, contents: data.content)
        cell.setUserProfile(profile: "", nick: data.user, time: data.date, email: data.email)
        cell.setImageView(image1: data.image, image2: data.image2, image3: data.image3)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //temp
        return CGSize(width: DEVICE_WIDTH(), height: heightOfCell(contents: dataList[indexPath.item]))
    }
    
    //MARK: - PrivateMethod
    func loadMainList() {
        NetManager().requestMainList(userEmail: User.info.userEmail) { (result) in
            self.dataList = result
            self.collectionView.reloadData()
        }
    }
    
    func heightOfCell(contents: MainContents) -> CGFloat {
        
        var height: CGFloat = 0.0
        // 40 + 50 + 40 + 20
        let defaltHeight: CGFloat = 150.0
        
        height += defaltHeight
        
        height += contents.content.height(withConstrainedWidth: DEVICE_WIDTH() - 30, font: UIFont.systemFont(ofSize: 15.0))
        
        if contents.image == "" {
            return height
        } else {
            height += 120.0
        }
        
        if contents.image2 == "" {
            return height
        } else {
            height += 125.0
        }
        
        return height
    }
    
    
}
