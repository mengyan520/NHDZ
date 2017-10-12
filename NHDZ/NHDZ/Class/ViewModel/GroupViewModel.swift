//
//  GroupViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/28.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class GroupViewModel: NSObject {
    var data: Group?
    //可重用表示符号
    var cellId: String {
        var ID = "reuseIdentifier"
        if data?.type == 3 || data?.type == 5 {
            ID = "image"
        }
        if ((data?.video_id) != nil) {
            ID = "video"
        }
        return ID

    }
    /// 缓存的行高
    lazy var rowHeight: CGFloat = {
        var cell: HomeTableViewCell
        if self.data?.type == 3 || self.data?.type == 5  {
            cell = HomeImageTableViewCell(style: .default, reuseIdentifier: "image")
        } else if ((self.data?.video_id) != nil) {
            cell = HomeVideoTableViewCell.init(style: .default, reuseIdentifier: "video")
        } else {
            cell = HomeTableViewCell.init(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        return cell.rowHeight(data: self)
    }()
    //图片数组
    var imgUrls: [URL]?
    //图片宽高
    var width:CGFloat = SCREEN_WIDTH
    var height:CGFloat = 0
    var r_width:CGFloat = 0
    var r_height:CGFloat = 0
    //用户ID
    var group_id: NSInteger{
        return (data?.id)!
    }
    //头像
    var avatar_url: URL {
        return URL.init(string: data?.user?.avatar_url ?? "f")!
    }
    //昵称
    var name: String? {
        return data?.user?.name
    }
    //正文
    var text: String? {
        return data?.text 
    }
    //分类名称
    var category_name: String? {
        return data?.category_name
    }
    //视频
    var Video_url: URL {
        return URL.init(string: (data?.p_video720?.url_list?.first?.url)!)!
    }
    // MARK: - init
    init(data: Group?) {
        self.data = data

        if let urls = data?.thumb_image_list {

            imgUrls = [URL]()
            for dict in urls {
                imgUrls?.append(URL.init(string: dict.url!)!)
            }

            height = (data?.thumb_image_list?.first?.height)! * width / (data?.thumb_image_list?.first?.width)!
            return
        }
        if let urls = data?.middle_image?.url_list {
            imgUrls = [URL]()
            imgUrls?.append(URL.init(string: (urls.first?.url)!)!)

            
            height = (data?.middle_image?.height)! * width / (data?.middle_image?.width)!
           return 
        }
        
        if let urls = data?.medium_cover?.url_list {
            imgUrls = [URL]()
            imgUrls?.append(URL.init(string: (urls.first?.url)!)!)

            r_height = (data?.video_height)!
            height = (data?.video_height)! * SCREEN_WIDTH / (data?.video_width)!
            
        }

    }
}
