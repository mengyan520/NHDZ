//
//  CommentTableViewController.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/3.
//  Copyright © 2017年 mm. All rights reserved.
//http://is.snssdk.com/2/comment/v1/detail/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&comment_id=1573900619381773
//http://is.snssdk.com/2/comment/v2/reply_list/?iid=12290087931&os_version=10.3.3&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1&id=1573900619381773&offset=0

import UIKit
import SVProgressHUD
class CommentTableViewController: UITableViewController {
    private lazy var viewModel = CommentListViewModel()
    var comment_id = 0
    init(comment_id:NSInteger) {
        super.init(style: .plain)
        self.comment_id = comment_id
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
         loadData()
    }
    func setUI()  {
        title = "评论详情"
        tableView.backgroundColor = WHITE_COLOR
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.register(CommentListTableViewCell.self, forCellReuseIdentifier: commentID)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.dataArrays.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.dataArrays[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentID, for: indexPath) as! CommentListTableViewCell

         cell.viewModel = viewModel.dataArrays[indexPath.section][indexPath.row]

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.dataArrays[indexPath.section][indexPath.row].rowHeight
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "全部评论\(viewModel.dataArrays[section].count)"
        }
        return nil
    }
    // MARK: - loadData
    func loadData()  {
        viewModel.loadData(comment_id: comment_id) {[weak self] (isSuccessed, message) in
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
