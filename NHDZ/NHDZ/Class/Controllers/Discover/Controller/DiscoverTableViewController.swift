//
//  DiscoverTableViewController.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/26.
//  Copyright © 2017年 mm. All rights reserved.
//http://iu.snssdk.com/2/essay/discovery/v3/?iid=12290087931&os_version=10.3.2&os_api=18&live_sdk_version=220&channel=App%20Store&idfa=83571B68-FF51-400B-A260-99FEA3E800AD&device_platform=iphone&app_name=joke_essay&vid=63430A4D-C20C-4405-8D0A-28A7D136EC4A&openudid=145eabc6e08f0e83aa7844d36676a2037511476c&device_type=iPhone%206S&device_id=13772144837&ac=WIFI&screen_width=750&aid=7&version_code=6.4.1

import UIKit
import SVProgressHUD
import ObjectMapper
class DiscoverTableViewController: UITableViewController, CarouselDataSource, CarouselDelegate {
    private lazy var viewModel = DiscoverViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }
    func setUI() {
        title = "发现"

        view.backgroundColor = UIColor.white

        tableView.tableHeaderView = carouselView
        tableView.register(DiscoverCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.separatorInset = .zero

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.category_list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DiscoverCell
        cell.layoutMargins = .zero

        cell.data = viewModel.category_list[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CategoryViewController.init(category_id: viewModel.category_list[indexPath.row].id)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }

    // MARK: - CarouselDataSource
    func numberOfPages(carouselView: CarouselView) -> NSInteger {
        return viewModel.banners.count
    }
    func carouselView(carouselView: CarouselView, index: NSInteger) -> UIView {
        let imageView = UIImageView(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:160*SCREEN_WIDTH/320))

        let url = URL(string: (viewModel.banners[index].banner_url?.url_list?.first?.url)!)
        imageView.kf.setImage(with: url)
        return imageView
    }
    func titleForPageAtIndex(carouselView: CarouselView, index: NSInteger) -> String {
        return (viewModel.banners[index].banner_url?.title)!
    }
    func didSelectedcarouselView(carouselView: CarouselView, index: NSInteger) {

    }

    // MARK: - loadData
    func loadData() {
        viewModel.loadData {[weak self] (isSuccessed, message) in
            if !isSuccessed {
                SVProgressHUD.showError(withStatus: "网络不好!")
                return
            }
            if message != "success" {
                SVProgressHUD.showError(withStatus: message)
                return
            }
            self?.carouselView.reloadDate()
            self?.carouselView.startAutoRun()
            self?.tableView.reloadData()
        }
    }
    // MARK: - Lazy
    private lazy var carouselView: CarouselView = {
        let view = CarouselView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 160*SCREEN_WIDTH/320))
        view.timeInterval = 4
        view.backgroundColor = WHITE_COLOR
        view.dataSource = self
        view.delegate = self
        return view
    }()
}
