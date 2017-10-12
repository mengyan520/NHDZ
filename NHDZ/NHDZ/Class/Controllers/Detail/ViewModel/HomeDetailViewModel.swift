//
//  HomeDetailViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/3.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import ObjectMapper
class HomeDetailViewModel: NSObject {
    var isTop = false
    lazy var dataArrays = [[CommentViewModel]]()
    func loadData(group_id: NSInteger, finished: @escaping (_ isSuccessed: Bool, _ message: String?)->Void) {
        NetWorkTools.shardTools.comment(group_id: group_id) { (response, error) in
            //print(response)
            if error != nil {
                print("出错了")

                finished(false, nil)
                return
            }
            guard let object = response as? [String: AnyObject] else {
                print("格式错误")
                return
            }
            let model = Mapper<Model>().map(JSON: object)
            if let arrs = model?.data?.top_comments {
                if arrs.count > 0 {
                    self.isTop = true
                    var dataList = [CommentViewModel]()
                    for dict in arrs {
                        dataList.append(CommentViewModel.init(data: dict))
                    }
                    self.dataArrays.append(dataList)
                }
            }
            if let arrs = model?.data?.recent_comments {
                if arrs.count > 0 {
                    var dataList = [CommentViewModel]()
                    for dict in arrs {
                        dataList.append(CommentViewModel.init(data: dict))
                    }
                    self.dataArrays.append(dataList)
                }
            }
            if let arrs = model?.data?.stick_comments {
                if arrs.count > 0 {
                    var dataList = [CommentViewModel]()
                    for dict in arrs {
                        dataList.append(CommentViewModel.init(data: dict))
                    }
                    self.dataArrays.append(dataList)
                }
            }
            finished(true, model?.message)
        }
    }
}
