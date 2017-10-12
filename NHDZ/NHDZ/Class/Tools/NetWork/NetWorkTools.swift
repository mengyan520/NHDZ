//
//  NetworkTools.swift

//
//  Created by Youcai on 16/3/4.
//  Copyright © 2016年 mm. All rights reserved.

import Foundation
import Alamofire
enum MMRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETET = "DELETET"
}
enum NetWorkStatuses {
    case NetworkStatusNone  // 没有网络
    case NetworkStatus2G     // 2G
    case NetworkStatus3G     // 3G
    case NetworkStatus4G     // 4G
    case NetworkStatusWIFI   // WIFI
}
class NetWorkTools {
    //定义回调
    typealias MMRequestCallBack = (_ response:Any?, _ error: NSError?)->Void
    //单例

    static let shardTools: NetWorkTools = NetWorkTools()

}
// MARK: - 封装 Alamofire 网络方法
extension NetWorkTools {

    func request(method: HTTPMethod, URLString: String, parameters: [String: Any]?, finished: @escaping MMRequestCallBack) {

        // 显示网络指示菊花
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // headers = nil
        let request = Alamofire.request(URLString, method: method, parameters: parameters, encoding:  URLEncoding.default, headers: nil)
        request.responseJSON(completionHandler: { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            // 判断是否失败

            if response.result.isFailure {
                // 在开发网络应用的时候，错误不要提示给用户，但是错误一定要输出！
                finished(nil, response.result.error as NSError?)
            } else if response.result.isSuccess {
                // 完成回调
                finished(response.result.value, response.result.error as NSError?)
            }

        })
    }
}
// MARK: - 网络请求
extension NetWorkTools {
    // MARK: - Home
    func home(content_type: String, finished: @escaping MMRequestCallBack) {
        request(method: .get, URLString: "http://lf.snssdk.com/neihan/stream/mix/v1/?tag=joke&iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&city=%E5%8C%97%E4%BA%AC%E5%B8%82&content_type=\(content_type)&count=30&double_col_mode=0&essence=1&latitude=40.0649169262829&longitude=116.3454156748977&message_cursor=0&min_time=1501468589&mpic=1&video_cdn_first=1", parameters: nil, finished: finished)
    }
    // MARK: - discover
    //发现界面请求
    func discover(finished: @escaping MMRequestCallBack) {
        request(method: .get, URLString: "https://iu.snssdk.com/2/essay/discovery/v3/?iid=12290087931&os_version=10.3.2&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1", parameters: nil, finished: finished)
    }
    //发现分类详情
    func discoverWithCategory(category_id: NSInteger, finished: @escaping MMRequestCallBack) {
        request(method: .get, URLString: "https://iu.snssdk.com/neihan/stream/category/data/v2/?tag=joke&iid=12290087931&os_version=10.3.2&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&category_id=\(category_id)&count=30&level=6&message_cursor=0&mpic=1&video_cdn_first=1", parameters: nil, finished: finished)
    }
     // MARK: - 段友秀
    func show(content_type: String, finished: @escaping MMRequestCallBack) {
        request(method: .get, URLString: "https://lf.snssdk.com/neihan/stream/mix/v1/?tag=joke&iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&city=%E5%8C%97%E4%BA%AC%E5%B8%82&content_type=\(content_type)&count=30&double_col_mode=1&essence=1&latitude=39.87144715047883&longitude=116.4530185405089&message_cursor=0&min_time=1501579038&mpic=1&video_cdn_first=1", parameters: nil, finished: finished)
    }
    // MARK: - 评论
    func comment(group_id: NSInteger, finished: @escaping MMRequestCallBack) {
        request(method: .get, URLString: "http://is.snssdk.com/neihan/comments/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&count=20&device_id=13772144837&group_id=\(group_id)&offset=0&sort=hot&tag=joke", parameters: nil, finished: finished)
    }
    func commentDetail(comment_id: NSInteger, finished: @escaping MMRequestCallBack) {
        request(method: .get, URLString: "http://is.snssdk.com/2/comment/v1/detail/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&comment_id=\(comment_id)", parameters: nil, finished: finished)
    }
    func commentReply(comment_id: NSInteger, finished: @escaping MMRequestCallBack) {
        request(method: .get, URLString: "http://is.snssdk.com/2/comment/v2/reply_list/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&id=\(comment_id)&offset=0", parameters: nil, finished: finished)
    }
}
