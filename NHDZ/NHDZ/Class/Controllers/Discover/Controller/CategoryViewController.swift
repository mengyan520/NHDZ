//
//  CategoryViewController.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,HomeCellDel {
    private lazy var  viewModel = CategoryViewModel()
    var headerView: CategoryHeaderView?
    var tableView: UITableView?
    var category_id = 0
    init(category_id: NSInteger) {
        super.init(nibName: nil, bundle: nil)
        self.category_id = category_id
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
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = WHITE_COLOR
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        tableView?.contentInset = UIEdgeInsets.init(top: 140, left: 0, bottom: 0, right: 0)
        tableView?.register(HomeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        //tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "ad")
        tableView?.register(HomeImageTableViewCell.self, forCellReuseIdentifier: "image")
        tableView?.register(HomeVideoTableViewCell.self, forCellReuseIdentifier: "video")
        tableView?.separatorStyle = .none
        tableView?.estimatedRowHeight = 200
        tableView?.dataSource = self
        tableView?.delegate = self
        headerView = CategoryHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 140), scrollView: tableView!)
        view.addSubview(tableView!)
        view.addSubview(headerView!)
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))

        tableView?.mj_header = header

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArrays.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.dataArrays[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.cellId, for: indexPath) as! HomeTableViewCell
        cell.viewModel = data
        cell.del = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = viewModel.dataArrays[indexPath.row]
        return data.rowHeight
    }
    func PlayBtnViewClick(sender: UIButton, tableView: UITableView, pictureView: UIImageView,url:URL) {

        MMPlayerView.shardTools.placeholderImage =  pictureView.image
        MMPlayerView.shardTools.setVideoURLwithTableViewAtIndexPathwithImageViewTag(videoURL: url, tableView:tableView,superView: pictureView, tag: 101)
        MMPlayerView.shardTools.autoPlayTheVideo()
    }
    // MARK: - loadData
    func loadData() {
        viewModel.loadData(category_id: category_id) {[weak self] (isSuccessed, message) in
            self?.tableView?.mj_header.endRefreshing()
            if !isSuccessed {
                SVProgressHUD.showError(withStatus: "网络不好!")
                return
            }
            if message != "success" {
                SVProgressHUD.showError(withStatus: message)
                return
            }
            //self?.setUI()
            self?.headerView?.data = self?.viewModel.category_info
            self?.tableView?.reloadData()
        }
    }
    deinit {
        print("dealloc")
    }
}
