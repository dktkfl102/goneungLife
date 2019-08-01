//
//  PlaceListView.swift
//  GoneungLift
//
//  Created by 김민아 on 15/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit

class PlaceListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeCellDelegate {


    @IBOutlet weak var collectionView: UICollectionView!
    var dataList: [MainContents]! = []

    class func initPlaceListViewWithTargetFrame(frame: CGRect, placeCode: String) -> PlaceListView {
        let view: PlaceListView = Bundle.main.loadNibNamed("PlaceListView", owner: self, options: nil)?.last as! PlaceListView
        view.frame = frame
        view.initLayout()
        
        view.requestPlaceContentList(placeCode: placeCode)
        
        return view
    }
    
    func initLayout() {
        collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
    }
    
    func requestPlaceContentList(placeCode: String) {
        
        NetManager().requestPlacePostList(placeId: placeCode) { (results) in
            self.dataList = results
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - HomeCellDelegate
    func didTouchLikeButton(isLike: Bool, index: NSInteger) {
        
    }
    
    func didTouchCommentButton(index: NSInteger) {
        
    }
    
    func didTouchPlaceButton(inex: NSInteger) {
        
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
        
        cell.setContents(title: "", contents: data.content)
        cell.setUserProfile(profile: "", nick: data.user, time: data.date, email: data.email)
        cell.setImageView(image1: data.image, image2: data.image2, image3: data.image3)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //temp
        return CGSize(width: DEVICE_WIDTH(), height: heightOfCell(contents: dataList![indexPath.item]))
    }
    
    func heightOfCell(contents: MainContents) -> CGFloat {
        
        var height: CGFloat = 0.0
        // 50 + 40 + 20
        let defaltHeight: CGFloat = 110.0
        
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
