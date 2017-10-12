//
//  ShowViewController.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/1.
//  Copyright © 2017年 mm. All rights reserved.
//https://lf.snssdk.com/neihan/stream/mix/v1/?tag=joke&iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&city=%E5%8C%97%E4%BA%AC%E5%B8%82&content_type=-301&count=30&double_col_mode=1&essence=1&latitude=39.87144715047883&longitude=116.4530185405089&message_cursor=0&min_time=1501579038&mpic=1&video_cdn_first=1

import UIKit
import MJRefresh
import SVProgressHUD
class ShowViewController: UIViewController {
    private lazy var viewModel = ShowViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }
    func setUI()  {
        view.backgroundColor = WHITE_COLOR
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        collectionView.mj_header = header
        view.addSubview(collectionView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - loadData
    func loadData()  {
        viewModel.loadData(content_type: "-301") { [weak self] (isSuccessed, message) in
            self?.collectionView.mj_header.endRefreshing()
            if !isSuccessed {
                SVProgressHUD.showError(withStatus: "网络不好!")
                return
            }
            if message != "success" {
                SVProgressHUD.showError(withStatus: message)
                return
            }
            
           self?.collectionView.dataArrays = self?.viewModel.dataArrays
        }
    }
    // MARK: - collectionView
    private lazy var collectionView:ShowCollectionView = {
        let collectionView = ShowCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49))
        return collectionView
    }()
}
