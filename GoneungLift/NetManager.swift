//
//  NetManager.swift
//  GoneungLift
//
//  Created by 김민아 on 16/07/2019.
//  Copyright © 2019 김민아. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetManager: NSObject {
    
    func requestMainList(userEmail: String, result: @escaping(_ data: [MainContents]) -> Void) {
        
        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get/get_contents.php?email=wj@maeultalk.com"
//        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get_contents.php?email=\(userEmail)"
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            if results.result.isSuccess {
                let data = JSON(results.result.value as Any)
                
                var resultList: [MainContents] = []
                if let temp = data["contents"].to(type: MainContents.self) {
                    resultList = temp as! [MainContents]
                }
                
                result(resultList)
                
                print(data)
            }
        }
    }
    
    func requestReplyList(postId: String, result: @escaping(_ data: [Comments]) -> Void) {
        
        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get/get_comments.php?content=\(postId)"
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            if results.result.isSuccess {
                let data = JSON(results.result.value as Any)
                
                var resultList: [Comments] = []
                if let temp = data["comments"].to(type: Comments.self) {
                    resultList = temp as! [Comments]
                }
                
                result(resultList)
                
                print(data)
            }
        }
    }
    
    func requestWriteNewComment(postId: String, userEmail: String, comments: String, result: @escaping(_ data: Bool) -> Void) {
        
        var urlString = "http://maeultalk.vps.phps.kr/app/apis/get/add_comment.php?content=\(postId)&user=\(userEmail)&comment=\(comments)"
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)

            if results.result.isSuccess {
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    
    func requestModifyComment(commentId: String, comment: String, result: @escaping(_ data: Bool) -> Void) {
        
        var urlString = "http://maeultalk.vps.phps.kr/app/apis/get/edit_comment.php?id=\(commentId)&comment=\(comment)"
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)
            
            if results.result.isSuccess {
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    func requestDeleteComment(commentId: String, contentId: String, result:  @escaping(_ data: Bool) -> Void) {
        
        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get/delete_comment.php?content=\(contentId)&id=\(commentId)"
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)
            
            if results.result.isSuccess {
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    func requestPlacePostList(placeId: String, result: @escaping(_ data: [MainContents]) -> Void) {
        
        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get/get_place_contents.php?place_code=\(placeId)&email=\(User.info.userEmail!)"
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            
            if results.result.isSuccess {
                let data = JSON(results.result.value as Any)
                
                var resultList: [MainContents] = []
                if let temp = data["contents"].to(type: MainContents.self) {
                    resultList = temp as! [MainContents]
                }
                
                result(resultList)
                
                print(data)
            }
        }
    }
    
    func requestNewPlace(placeName: String, result: @escaping(_ data: Bool) -> Void) {
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        let randomInt = Int.random(in: 1000...9999)
        let placecode = "place_\(formatter.string(from: Date()))_\(randomInt)"
        
        print(placecode)

        var urlString = "http://maeultalk.vps.phps.kr/app/apis/get/add_place.php?code=\(placecode)&name=\(placeName)&nmap=&latitude=&longitude="
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)
            
            if results.result.isSuccess {
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    func requestPlaceList(placeName: String, result: @escaping(_ data: [PlaceContents]) -> Void) {
        
        var urlString = "http://maeultalk.vps.phps.kr/app/apis/get/search_places.php?name=\(placeName)"
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)
            
            if results.result.isSuccess {
                let data = JSON(results.result.value as Any)
                
                var resultList: [PlaceContents] = []
                if let temp = data["places"].to(type: PlaceContents.self) {
                    resultList = temp as! [PlaceContents]
                }
                
                result(resultList)
                
                print(data)
            } else {
            }
        }
    }
    
    func requestPlaceContentsList(placeName: String, result: @escaping(_ data: [MainContents]) -> Void) {
        
        var urlString = "http://maeultalk.vps.phps.kr/app/apis/get/search_contents.php?name=\(placeName)"
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)
            
            if results.result.isSuccess {
                let data = JSON(results.result.value as Any)
                
                var resultList: [MainContents] = []
                if let temp = data["contents"].to(type: MainContents.self) {
                    resultList = temp as! [MainContents]
                }
                
                result(resultList)
                
                print(data)
            } else {
            }
        }
    }
    
    func requestInboxList(result: @escaping(_ data: [Inbox]) -> Void) {
//        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get/get_inbox.php?email=\(User.info.userEmail!)"
        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get/get_inbox.php?email=kihwanjo88@gmail.com"

        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)
            
            if results.result.isSuccess {
                let data = JSON(results.result.value as Any)
                
                var resultList: [Inbox] = []
                if let temp = data["inbox"].to(type: Inbox.self) {
                    resultList = temp as! [Inbox]
                }
                
                result(resultList)
                
                print(data)
            } else {
            }
        }
    }
    
    func requestInboxDetail(inboxId: String, result: @escaping(_ data: [InboxContents]) -> Void) {
        
        let urlString = "http://maeultalk.vps.phps.kr/app/apis/get/get_inbox2.php?id=\(inboxId)"
        
        Alamofire.request(URL.init(string: urlString)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (results) in
            print(results)
            
            if results.result.isSuccess {
                let data = JSON(results.result.value as Any)
                
                var resultList: [InboxContents] = []
                if let temp = data["inbox2"].to(type: InboxContents.self) {
                    resultList = temp as! [InboxContents]
                }
                
                result(resultList)
                
                print(data)
            } else {
                
            }
        }

        
    }


}
