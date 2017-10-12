//
//  HomeTableViewController.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//http://lf.snssdk.com/neihan/stream/mix/v1/?tag=joke&iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&city=%E5%8C%97%E4%BA%AC%E5%B8%82&content_type=-102&count=30&double_col_mode=0&essence=1&latitude=40.0649169262829&longitude=116.3454156748977&message_cursor=0&min_time=1501468589&mpic=1&video_cdn_first=1  段子
//http://lf.snssdk.com/neihan/stream/mix/v1/?tag=joke&iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&city=%E5%8C%97%E4%BA%AC%E5%B8%82&content_type=-103&count=30&double_col_mode=0&essence=1&latitude=40.0649169262829&longitude=116.3454156748977&message_cursor=0&min_time=1501466839&mpic=1&video_cdn_first=1 图片
//http://lf.snssdk.com/neihan/stream/mix/v1/?tag=joke&iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&city=%E5%8C%97%E4%BA%AC%E5%B8%82&content_type=-104&count=30&double_col_mode=0&essence=1&latitude=40.0649169262829&longitude=116.3454156748977&message_cursor=0&min_time=1501468630&mpic=1&video_cdn_first=1 视频

import UIKit
import SVProgressHUD
import MJRefresh
class HomeTableViewController: UITableViewController,HomeCellDel {
    lazy var viewModel = HomeViewModel()
    var content_type: String?
    init(content_type: String) {
        super.init(nibName: nil, bundle: nil)
        self.content_type = content_type
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        loadData()
    }
    func setUI() {
        tableView.backgroundColor = WHITE_COLOR
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView?.register(HomeImageTableViewCell.self, forCellReuseIdentifier: "image")
        tableView?.register(HomeVideoTableViewCell.self, forCellReuseIdentifier: "video")
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        tableView?.mj_header = header
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.dataArrays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.dataArrays[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.cellId, for: indexPath) as! HomeTableViewCell
        cell.viewModel = data
        cell.del = self

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = viewModel.dataArrays[indexPath.row]

        return data.rowHeight
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = HomeDetailViewController.init(group_id: viewModel.dataArrays[indexPath.row].group_id)
        //vc.viewModel = [data]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func PlayBtnViewClick(sender: UIButton, tableView: UITableView, pictureView: UIImageView,url:URL) {

        MMPlayerView.shardTools.placeholderImage =  pictureView.image
        MMPlayerView.shardTools.setVideoURLwithTableViewAtIndexPathwithImageViewTag(videoURL: url, tableView:tableView,superView: pictureView, tag: 101)
        MMPlayerView.shardTools.autoPlayTheVideo()
    }
    // MARK: - loadData
    func loadData() {
        viewModel.loadData(content_type: content_type!) {[weak self] (isSuccessed, message) in
            self?.tableView?.mj_header.endRefreshing()
            if !isSuccessed {
                SVProgressHUD.showError(withStatus: "网络不好!")
                return
            }
            if message != "success" {
                SVProgressHUD.showError(withStatus: message)
                return
            }
            self?.tableView?.reloadData()
        }
    }
    
}
