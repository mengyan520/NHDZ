//
//  CategoryViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import ObjectMapper
class CategoryViewModel: NSObject {
    lazy var dataArrays = [GroupViewModel]()
    var category_info: Category_info?
    func loadData(category_id: NSInteger, finished: @escaping (_ isSuccessed: Bool, _ message: String?)->Void) {

        NetWorkTools.shardTools.discoverWithCategory(category_id: category_id) { (response, error) in
            print(response)
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
            self.category_info = model?.data?.category_info
            //self.dataArrays = //
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
