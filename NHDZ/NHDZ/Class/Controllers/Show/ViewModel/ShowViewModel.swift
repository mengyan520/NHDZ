//
//  ShowViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/1.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import ObjectMapper
class ShowViewModel: NSObject {
    lazy var dataArrays = [GroupViewModel]()
    func loadData(content_type: String, finished: @escaping (_ isSuccessed: Bool, _ message: String?)->Void) {
        NetWorkTools.shardTools.show(content_type: content_type) { (response, error) in
            
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
            var dataList = [GroupViewModel]()
            for dict in (model?.data?.data)! {

                dataList.append(GroupViewModel.init(data: dict.group))
            }
            
            if (model?.data?.has_more)! {

                self.dataArrays = dataList + self.dataArrays
            }
            finished(true, model?.message)
        }
    }

}
