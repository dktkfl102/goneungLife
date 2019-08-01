//
//  HomeCell.swift
//  GoneungLift
//
//  Created by 김민아 on 15/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeCellDelegate: class {
    
    func didTouchLikeButton(isLike: Bool, index: NSInteger)
    func didTouchCommentButton(index: NSInteger)
    func didTouchPlaceButton(inex: NSInteger)
}

class HomeCell: UICollectionViewCell {
    
    var index: NSInteger! = 0
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lbNick: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbContents: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var lbPlace: UILabel!
    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    @IBOutlet weak var alcHeightOfPlaceView: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfImageView2: NSLayoutConstraint!
    @IBOutlet weak var alcWidthOfImageView3: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfImageBaseView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfContents: NSLayoutConstraint!
    
    weak var delegate: HomeCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnProfile.layer.cornerRadius = 20.0
    }
    
    func setUserProfile(profile: String, nick: String, time: String, email: String) {
        ivProfile.sd_setImage(with: URL.init(string: profile), completed: nil)
        lbNick.text = nick
        lbTime.text = time
        
        btnMore.isHidden = email == User.info.userEmail ? false : true
    }
    
    func setContents(title: String, contents: String) {
        
        if title == "" {
            alcHeightOfPlaceView.constant = 0.0
        } else {
            alcHeightOfPlaceView.constant = 40.0
        }
        lbPlace.text = title
        lbContents.text = contents
        
        alcHeightOfContents.constant = contents.height(withConstrainedWidth: DEVICE_WIDTH() - 30, font: UIFont.systemFont(ofSize: 15.0))
    }
    
    func setImageView(image1: String, image2: String, image3: String) {
        
        // 이미지 갯수에 따라서 레이아웃 변경
        if image1 == "" {
            alcHeightOfImageBaseView.constant = 0.0
            imageBaseView.isHidden = true
            return
            
        } else {
            imageBaseView.isHidden = false
            alcHeightOfImageBaseView.constant = 120.0
//            imageView1.sd_setImage(with: URL.init(string: image1), completed: nil)
        }
        
        if image2 == "" {
            return
        } else {
            alcHeightOfImageBaseView.constant = 245.0
//            imageView2.sd_setImage(with: URL.init(string: image2), completed: nil)
        }
        
        if image3 == "" {
            alcTrailingOfImageView2.constant = 0.0
            alcWidthOfImageView3.constant = 0.0
            return
        } else {
            alcTrailingOfImageView2.constant = 5.0
            alcWidthOfImageView3.constant = (DEVICE_WIDTH()-5)/2
//            imageView3.sd_setImage(with: URL.init(string: image3), completed: nil)
        }
    }
    
    @IBAction func didTouchPlaceButton(_ sender: UIButton) {
        self.delegate.didTouchPlaceButton(inex: self.index)
    }
    
    @IBAction func didTouchLikeButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didTouchCommentButton(_ sender: UIButton) {
        self.delegate.didTouchCommentButton(index: self.index)
    }
    
    @IBAction func didTouchShareButton(_ sender: UIButton) {
        
    }
}
