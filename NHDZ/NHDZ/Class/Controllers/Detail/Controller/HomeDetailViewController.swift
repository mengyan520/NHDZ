//
//  HomeDetailViewController.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/1.
//  Copyright © 2017年 mm. All rights reserved.
//http://is.snssdk.com/neihan/comments/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&count=20&device_id=13772144837&group_id=64822690576&offset=0&sort=hot&tag=joke 评论
//http://is.snssdk.com/neihan/action/digg_users/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&id=64822690576 点赞的人
//http://is.snssdk.com/neihan/stream/group_stats_data/v1/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1 post  获取最新分享/点赞等人数
import UIKit
import SVProgressHUD
class HomeDetailViewController: UIViewController {

    var group_id = 0
    fileprivate lazy var viewModel = HomeDetailViewModel()
    var datas:[GroupViewModel]?
    init(group_id:NSInteger) {
        super.init(nibName: nil, bundle: nil)
        self.group_id = group_id

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
        title = "详情"
        view.backgroundColor = WHITE_COLOR
        view.addSubview(tableView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Lazy
    private lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49), style: .plain)
        tableView.backgroundColor = WHITE_COLOR
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(HomeImageTableViewCell.self, forCellReuseIdentifier: "image")
        tableView.register(HomeVideoTableViewCell.self, forCellReuseIdentifier: "video")
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "comment")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    // MARK: - loadData
    func loadData()  {
        viewModel.loadData(group_id: group_id) {[weak self] (isSuccessed, message) in

            if !isSuccessed {
                SVProgressHUD.showError(withStatus: "网络不好!")
                return
            }
            if message != "success" {
                SVProgressHUD.showError(withStatus: message)
                return
            }

            self?.tableView.reloadData()
        }

    }

}
// MARK: - UITableViewDataSource/UITableViewDelegate
extension HomeDetailViewController:UITableViewDataSource,UITableViewDelegate,HomeCellDel
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataArrays.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.dataArrays[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! CommentTableViewCell
        cell.viewModel =  viewModel.dataArrays[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if indexPath.section == 1 {
            let vc = CommentTableViewController.init(comment_id: viewModel.dataArrays[indexPath.section][indexPath.row].comment_id)
            navigationController?.pushViewController(vc, animated: true)
        //}

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return viewModel.dataArrays[indexPath.section][indexPath.row].rowHeight
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.isTop {
            if section == 0 {
                return "热门评论（\(viewModel.dataArrays[section].count)）"
            } else if section == 1{
                return "新鲜评论（\(viewModel.dataArrays[section].count)）"
            }
        }else {
            if section == 0 {
                return "新鲜评论（\(viewModel.dataArrays[section].count)）"
            } else if section == 1{
                return "新鲜评论（\(viewModel.dataArrays[section].count)）"
            }
        }
        return ""
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

    }
    func PlayBtnViewClick(sender: UIButton, tableView: UITableView, pictureView: UIImageView,url:URL) {

        //            MMPlayerView.shardTools.placeholderImage =  pictureView.image
        //            MMPlayerView.shardTools.setVideoURLwithTableViewAtIndexPathwithImageViewTag(videoURL: url, tableView:tableView,superView: pictureView, tag: 101)
        //            MMPlayerView.shardTools.isSmall = true
        //            MMPlayerView.shardTools.smallSize = CGSize.init(width: viewModel![0].width/4, height: viewModel![0].r_height/4)
        //            MMPlayerView.shardTools.smallHeight = 200//viewModel![0].rowHeight
        //            MMPlayerView.shardTools.autoPlayTheVideo()
    }
}
