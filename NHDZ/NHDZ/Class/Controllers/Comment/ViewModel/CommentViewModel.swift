//
//  CommentViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/3.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
class CommentViewModel: NSObject {
    var data: Comment?

    // 缓存的行高
    lazy var rowHeight: CGFloat = {
        let cell = CommentTableViewCell.init(style: .default, reuseIdentifier: commentID)
        return cell.rowHeight(data: self)
    }()

    //头像
    var avatar_url: URL {
        return URL.init(string: data?.avatar_url ?? "f")!
    }
    //昵称
    var name: String? {
        return data?.user_name
    }
    //时间
    var time: String? {
        return Date().timeStringWithInterval(time: TimeInterval((data?.createTime)!))
    }
    //正文
    var text: String? {
        return data?.text
    }
    //回复

    var replyCount:NSInteger {
        return (data?.secondLevelCommentsCount)!
    }
    //评论ID

    var comment_id:NSInteger {
        return (data?.comment_id)!
    }
    // MARK: - init
    init(data: Comment?) {
        self.data = data
        
    }
}
