//
//  CommentListViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/3.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import ObjectMapper
class CommentListViewModel: NSObject {
    lazy var dataArrays = [[DataViewModel]]()
    func loadData(comment_id: NSInteger, finished: @escaping (_ isSuccessed: Bool, _ message: String?)->Void) {

        NetWorkTools.shardTools.commentDetail(comment_id: comment_id) { (response, error) in
           // print(response)
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
            self.dataArrays.append([DataViewModel.init(data: model?.data,subData:nil)])
            if (model?.data?.commentCount)! > 0 {

            self.load(comment_id: comment_id, finished: finished)

            }else {
            finished(true, model?.message)
            }
        }
    }
    func load(comment_id: NSInteger, finished: @escaping (_ isSuccessed: Bool, _ message: String?)->Void) {
        NetWorkTools.shardTools.commentReply(comment_id: comment_id) { (response, error) in
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
             var dataList = [DataViewModel]()
            for dict in (model?.data?.data)! {
                dataList.append(DataViewModel.init(data: nil,subData:dict))
            }
            self.dataArrays.append(dataList)
            finished(true, model?.message)
        }

    }
}
