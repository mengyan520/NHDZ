//
//  DataViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/4.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class DataViewModel: NSObject {
    var data: ModelData?
    var subData: SubData?
    // 缓存的行高
    lazy var rowHeight: CGFloat = {
        let cell = CommentListTableViewCell.init(style: .default, reuseIdentifier: commentID)
        return cell.rowHeight(data: self)
    }()

    //头像
    var avatar_url: URL {
        return URL.init(string: (data != nil ? data?.user?.avatar_url:subData?.user?.avatar_url) ?? "f")!
    }
    //昵称
    var name: String? {

        return (data != nil ? data?.user?.screenName:subData?.user?.screenName)
    }
    //时间
    var time: String? {
        return Date().timeStringWithInterval(time: TimeInterval(((data != nil ? data?.createTime:subData?.createTime))!))
    }
    //正文
    var text: String? {
        return (data != nil ? data?.text:subData?.text)
    }
    //回复
    var replyUserName:String {
    return (subData?.replyToComment?.user_name)!
    }
    var isOwner:Bool {
        return (data != nil ? false:(subData?.isOwner)!)
    }
    // MARK: - init
    init(data: ModelData?,subData: SubData?) {
        self.data = data
        self.subData = subData
    }
}
