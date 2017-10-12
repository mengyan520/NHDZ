//
//  DiscoverViewModel.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/26.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import ObjectMapper
class DiscoverViewModel: NSObject {
    lazy var banners = [Banners]()
    lazy var category_list = [Category_list]()
    func loadData(finished: @escaping (_ isSuccessed: Bool, _ message: String?)->Void) {
        NetWorkTools.shardTools.discover { (response, error) in
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
            self.banners = (model?.data?.rotate_banner?.banners)!

            self.category_list = (model?.data?.categories?.category_list)!
            self.category_list.sort(by: {$0.id < $1.id})
            self.category_list.remove(at: 0)
            self.category_list.remove(at: 1)
            finished(true, model?.message)

        }
    }
}
