//
//  PlayercontentView.swift
//  MMPlayer
//
//  Created by Youcai on 16/11/2.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
//协议
//协议
protocol MMPlayerControlViewDel:NSObjectProtocol {
    func ControlViewWithBtnClick(sender:UIButton)
    func ControlViewWithProgressSliderValueChanged(sender:UISlider)
    func ControlViewWithProgressSliderTouchEnded(sender:UISlider)
    func ControlViewWithprogressSliderTap(tapValue:CGFloat)
}
class MMPlayerControlView: UIView,UIGestureRecognizerDelegate {
    // MARK: - 初始化
    init() {
        super.init(frame: CGRect.init())
        setUI()
        playerResetControlView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI() {
        addSubview(topImageView)
        addSubview(bottomImageView)
        addSubview(lockBtn)
        addSubview(activity)
        addSubview(repeatBtn)
        addSubview(horizontalLabel)
        addSubview(playeBtn)
        addSubview(closeBtn)
        bottomImageView.addSubview(startBtn)
        bottomImageView.addSubview(currentTimeLabel)
        bottomImageView.addSubview(progressView)
        bottomImageView.addSubview(videoSlider)
        bottomImageView.addSubview(fullScreenBtn)
        bottomImageView.addSubview(totalTimeLabel)
        topImageView.addSubview(downLoadBtn)
        topImageView.addSubview(backBtn)
        topImageView.addSubview(resolutionBtn)
        topImageView.addSubview(titleLabel)
        closeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(7)
            make.top.equalTo(self.snp.top).offset(-7)
            make.width.height.equalTo(20)
        }
        topImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(80)
        }
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(topImageView.snp.left).offset(7)
            make.top.equalTo(topImageView.snp.top).offset(5)
            make.width.height.equalTo(50)
        }
        downLoadBtn.snp.makeConstraints { (make) in
            make.right.equalTo(topImageView.snp.right).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(49)
            make.centerY.equalTo(backBtn.snp.centerY)
        }
        resolutionBtn.snp.makeConstraints { (make) in
            make.right.equalTo(downLoadBtn.snp.left).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.centerY.equalTo(backBtn.snp.centerY)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(backBtn.snp.right).offset(10)
            make.right.equalTo(resolutionBtn.snp.left).offset(-10)
            
            make.centerY.equalTo(backBtn.snp.centerY)
        }
        bottomImageView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.bottom.equalTo(self)
        }
        startBtn.snp.makeConstraints { (make) in
            make.left.equalTo(bottomImageView.snp.left).offset(5)
            make.bottom.equalTo(bottomImageView.snp.bottom).offset(-5)
            make.width.height.equalTo(30)
            
        }
        currentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(startBtn.snp.right).offset(-3)
            make.bottom.equalTo(bottomImageView.snp.bottom).offset(5)
            make.width.equalTo(43)
            make.centerY.equalTo(startBtn.snp.centerY)
        }
        fullScreenBtn.snp.makeConstraints { (make) in
            make.right.equalTo(bottomImageView.snp.right).offset(-5)
            
            make.width.height.equalTo(30)
            make.centerY.equalTo(startBtn.snp.centerY)
        }
        totalTimeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(fullScreenBtn.snp.left).offset(3)
            
            make.width.equalTo(43)
            make.centerY.equalTo(startBtn.snp.centerY)
        }
        progressView.snp.makeConstraints { (make) in
            make.left.equalTo(currentTimeLabel.snp.right).offset(4)
            
            make.right.equalTo(totalTimeLabel.snp.left).offset(-4)
            make.centerY.equalTo(startBtn.snp.centerY)
        }
        videoSlider.snp.makeConstraints { (make) in
            make.left.equalTo(currentTimeLabel.snp.right).offset(4)
            make.right.equalTo(totalTimeLabel.snp.left).offset(-4)
            make.centerY.equalTo(currentTimeLabel.snp.centerY).offset(-1)
            make.height.equalTo(30)
        }
        lockBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(40)
        }
        horizontalLabel.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(33)
            make.center.equalTo(self)
        }
        activity.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        repeatBtn.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        playeBtn.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            
        }
    }
    
    
    // MARK: - 点击事件
    /**
     startBtn.tag =  0
     fullScreenBtn.tag =  1
     lockBtn.tag =  2
     backBtn.tag =  3
     closeBtn.tag =  4
     repeatBtn.tag =  5
     downLoadBtn.tag =  6
     resolutionBtn.tag =  7
     playeBtn.tag =  8
     
     */
    @objc private func BtnClick(sender:UIButton) {
        switch sender.tag {
        case 0:
            
            sender.isSelected = !sender.isSelected
            del?.ControlViewWithBtnClick(sender: sender)
            break
        case 1:
            sender.isSelected = !sender.isSelected
          
            del?.ControlViewWithBtnClick(sender: sender)
            break
        case 2:
            sender.isSelected = !sender.isSelected
            
            
            break
        case 3:
            del?.ControlViewWithBtnClick(sender: sender)
            break
        case 4:
            
            
            break
        case 5:
            playerResetControlView()
            playerShowControlView()
             del?.ControlViewWithBtnClick(sender: sender)
            break
        case 6:
            del?.ControlViewWithBtnClick(sender: sender)
            break
        case 7:
            
            resolutionView.isHidden = !resolutionView.isHidden
            break
        case 8:
            
            break
        default: break
            
        }
    }
    /**
     * 分辨率视图
     */
    @objc private func changeResolution(sender:UIButton) {
        // 隐藏分辨率View
        resolutionView.isHidden = true
        
        resolutionBtn.setTitle(sender.titleLabel?.text, for: .normal)
        
    }
    // MARK: - 控件状态
    /**
     *  StartBtn
     */
    func playerStartBtnState(state:Bool) {
        
        startBtn.isSelected = state
    }
    /** 下载按钮状态 */
    func playerDownloadBtnState(state:Bool)  {
        downLoadBtn.isEnabled = state
    }
    /** 视频加载失败 */
    func playeritemStatusFailed(error:Error)  {
        horizontalLabel.isHidden = false
        horizontalLabel.text = "视频加载失败"
    }
    /** progress显示缓冲进度 */
    func playerSetProgress(progress:Float)   {
        
        
        progressView.setProgress(progress, animated: false)
    }
    // MARK: - 公有事件
    
    /** 重置ControlView */
    func playerResetControlView()  {
        horizontalLabel.isHidden = true
        repeatBtn.isHidden   = true
        resolutionView.isHidden  = true
        playeBtn.isHidden        = true
        downLoadBtn.isEnabled    = true
        backgroundColor        = CLEAR_COLOR
        shrink = false
        showing = false
        videoSlider.value      = 0
        progressView.progress  = 0
        currentTimeLabel.text  = "00:00"
        totalTimeLabel.text    = "00:00"
    }
    /** 在cell播放 */
    func playerCellPlay() {
        cellVideo = true
        shrink  = true
        backBtn.isHidden = true
        titleLabel.isHidden = true
        playerShowControlView()
    }
    func playerPlayDidEnd()  {
        backgroundColor = RGB(r: 0, g: 0, b: 0, a: 0.6)
        repeatBtn.isHidden = false
        // 初始化显示controlView为YES
        showing = false
        // 延迟隐藏controlView
        playerShowControlView()
    }
    // MARK: - 进度条
    func playerCurrentTimeAndtotalTimeAndsliderValue(currentTime:Int,totalTime:Int,value:Float)  {
        // 当前时长进度progress
        let proMin           = currentTime / 60//当前秒
        let proSec           = currentTime % 60//当前分钟
        // duration 总时长
        let durMin           = totalTime / 60//总秒
        let durSec           = totalTime % 60//总分钟
        // 更新slider
        videoSlider.value     = value
        // 更新当前播放时间
        
        currentTimeLabel.text = (proMin >= 10 ?"\(proMin)":"0\(proMin)" ) + ":" + (proSec >= 10 ?"\(proSec)":"0\(proSec)" )
        // 更新总时间
        totalTimeLabel.text   = (durMin >= 10 ?"\(durMin)":"0\(durMin)" ) + ":" + (durSec >= 10 ?"\(durSec)":"0\(durSec)" )
    }
    //拖拽进度条
    func playerDraggedTimeAndTotalTimeAndIsForwardAndHasPreview(draggedTime:Int,totalTime:Int,forawrd:Bool,preview:Bool) {
        // 当前时长进度progress
        let proMin           = draggedTime / 60//当前秒
        let proSec           = draggedTime % 60//当前分钟
        // duration 总时长
        let durMin           = totalTime / 60//总秒
        let durSec           = totalTime % 60//总分钟
        // 显示、隐藏预览窗
        // 更新slider的值
        let currentTimeStr = NSString.init(format: "%02zd:%02zd", proMin, proSec) as String
        let totalTimeStr = (NSString.init(format: "%02zd:%02zd", durMin, durSec) as String)
        
        videoSlider.value = Float(draggedTime) / Float(totalTime)
        currentTimeLabel.text  = currentTimeStr
        var style = ">>"
        if  !forawrd {
            style = "<<"
        }
        
        horizontalLabel.isHidden = preview
        horizontalLabel.text  = style + " " + currentTimeStr + "/" + totalTimeStr
       
    }
    // MARK: - UISlider
    
    @objc private func progressSliderTouchBegan(sender:UISlider) {
         currentTap?.isEnabled = false
        playerCancelAutoFadeOutControlView()
        if !repeatBtn.isHidden {
            repeatBtn.isHidden = true
            backgroundColor =   CLEAR_COLOR
        }
       
    }
    @objc private func progressSliderValueChanged(sender:UISlider) {
        
         playerCancelAutoFadeOutControlView()
         del?.ControlViewWithProgressSliderValueChanged(sender: sender)
    }
    @objc private func progressSliderTouchEnded(sender:UISlider) {
       currentTap?.isEnabled = true
        playerDraggedEnd()
        del?.ControlViewWithProgressSliderTouchEnded(sender: sender)
        
    }
    @objc private func tapSliderAction(tap:UITapGestureRecognizer) {
        
        if (tap.view?.isKind(of: UISlider.self))! {
            let view = tap.view as! UISlider
            let point = tap.location(in: view)
            let length = view.frame.size.width
            // 视频跳转的value
            let tapValue = point.x / length
            view.setValue(Float(tapValue), animated: true)
            
            del?.ControlViewWithprogressSliderTap(tapValue: tapValue)
            if !repeatBtn.isHidden {
                repeatBtn.isHidden = true
                backgroundColor =   CLEAR_COLOR
            }
        }
    }
    @objc private func panRecognizer(pan:UIPanGestureRecognizer) {
        // 不做处理，只是为了滑动slider其他地方不响应其他手势
    }
    private func playerDraggedEnd() {
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            self.horizontalLabel.isHidden = true
        }
        
        // 滑动结束延时隐藏controlView
        autoFadeOutControlView()
    }
    // slider滑块的bounds
    func thumbRect() -> CGRect {
        return  videoSlider.thumbRect(forBounds: videoSlider.bounds, trackRect: videoSlider.trackRect(forBounds: videoSlider.bounds), value: videoSlider.value)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let rect = thumbRect()
        let point = touch.location(in: videoSlider)
        if (touch.view?.isKind(of: UISlider.self))! {
           // 如果在滑块上点击就不响应pan手势
            if point.x <= rect.origin.x + rect.size.width && point.x >= rect.origin.x {
                return false
            }
        }
        return true
    }
    
    // MARK: - MMPlayerControlView 的显示与隐藏
    /**
     *  显示控制层 延迟几秒再次隐藏控制层
     */
    func playerShowControlView()  {
        if showing {
            playerHideControlView()
            return
        }
        playerCancelAutoFadeOutControlView()
        UIView.animate(withDuration: 0.35, animations: {
            self.showControlView()
        }) { (bool) in
            self.showing = true
            self.autoFadeOutControlView()
        }
    }
    /**
     *  隐藏控制层
     */
    func playerHideControlView()  {
        
        if !showing {
            return
        }
        playerCancelAutoFadeOutControlView()
        UIView.animate(withDuration: 0.35, animations: {
            self.hideControlView()
        }) { (bool) in
            self.showing = false
        }
        
    }
    /**
     *  延迟调用隐藏控制层方法
     */
    func autoFadeOutControlView()   {
        self.perform(#selector(MMPlayerControlView.playerHideControlView), with: nil, afterDelay: 7.0)
        
    }
    /**
     *  取消延时隐藏controlView的方法 //进入后台一定取消延迟,否则在延迟时间内进入前台，会在延迟时间内隐藏,体验不好
     */
    func playerCancelAutoFadeOutControlView()  {
        showing = false
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(MMPlayerControlView.playerHideControlView), object: nil)
        
    }
    func showControlView()  {
        topImageView.isHidden = false
        bottomImageView.isHidden = false
        
    }
    func hideControlView()  {
        topImageView.isHidden = true
        bottomImageView.isHidden = true
        
        
        
    }
    // MARK: - 公有属性
    var resolutionArray:[String]? {
        didSet {
            resolutionBtn.setTitle(resolutionArray?.first, for: .normal)
            // 添加分辨率按钮和分辨率下拉列表
            
            resolutionBtn.isHidden = false
            resolutionView.backgroundColor  = RGB(r: 0, g: 0, b: 0, a: 0.7)
            addSubview(resolutionView)
            resolutionView.snp.makeConstraints { (make) in
                make.width.equalTo(40)
                make.height.equalTo(30 * (resolutionArray?.count)!)
                make.left.equalTo(resolutionBtn.snp.left).offset(0)
                make.top.equalTo(resolutionBtn.snp.bottom).offset(0)
            }
            // 分辨率View上边的Btn
            let count = resolutionArray!.count
            for i in 0..<count {
                let btn = UIButton.init(type: .custom)
                btn.tag = 200+i
                resolutionView.addSubview(btn)
                btn.titleLabel?.font = Font(fontSize: 14)
                btn.frame = CGRect.init(x: 0, y: 30*i, width: 40, height: 30)
                btn.setTitle(resolutionArray?[i], for: .normal)
                btn.addTarget(self, action: #selector(MMPlayerControlView.changeResolution(sender:)), for: .touchUpInside)
            }
        }
    }
    
    // MARK: - 私有属性
    //代理
  weak  var del:MMPlayerControlViewDel?
    /** 显示控制层 */
    var showing:Bool = false
    /** 小屏播放 */
    var shrink:Bool = false
    /** 在cell上播放 */
    var cellVideo:Bool = false
    // MARK: - 懒加载
    /** 标题 */
    lazy var titleLabel:UILabel = {
        let view = UILabel.init()
        view.textColor  = WHITE_COLOR
        view.text = "标题"
        view.font = Font(fontSize: 15)
        
        return view
    }()
    /** 开始播放按钮 */
    lazy var startBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.setImage(MMPlayerImage(file: "Player_play"), for: .normal)
        view.setImage(MMPlayerImage(file: "Player_pause"), for: .selected)
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 0
        return view
    }()
    /** 当前播放时长label */
    private lazy var currentTimeLabel:UILabel = {
        let view = UILabel.init()
        view.textColor  = WHITE_COLOR
        view.font = Font(fontSize: 12)
        view.textAlignment = .center
        view.text = "00:00"
        return view
    }()
    /** 视频总时长label */
    private lazy var totalTimeLabel:UILabel = {
        let view = UILabel.init()
        view.textColor  = WHITE_COLOR
        view.font = Font(fontSize: 12)
        view.textAlignment = .center
        view.text = "06:66"
        return view
    }()
    /** 缓冲进度条 */
    private lazy var progressView:UIProgressView = {
        let view = UIProgressView.init(progressViewStyle: .default)
        view.progressTintColor = WHITE_COLOR//RGB(r: 1, g: 1, b: 1, a: 0.5)
        view.trackTintColor =  CLEAR_COLOR
        return view
    }()
    /** 滑杆 */
    var currentTap:UITapGestureRecognizer?
    private lazy var videoSlider:UISlider = {
        let view = UISlider.init(frame: CGRect.init())
        view.setThumbImage(MMPlayerImage(file: "Player_slider"), for: .normal)
        view.maximumValue = 1
        view.minimumTrackTintColor = WHITE_COLOR
        view.maximumTrackTintColor = RGB(r: 0.5, g: 0.5, b: 0.5, a: 0.5)
        // slider开始滑动事件
        view.addTarget(self, action: #selector(MMPlayerControlView.progressSliderTouchBegan(sender:)), for: .touchDown)
        //
        // slider滑动中事件
        view.addTarget(self, action: #selector(MMPlayerControlView.progressSliderValueChanged(sender:)), for: .valueChanged)
        // slider结束滑动事件
        view.addTarget(self, action: #selector(MMPlayerControlView.progressSliderTouchEnded(sender:)), for: [.touchUpInside,.touchCancel, .touchUpOutside])
        
        //手势点击
        let sliderTap = UITapGestureRecognizer.init(target: self, action: #selector(MMPlayerControlView.tapSliderAction(tap:)))
        view.addGestureRecognizer(sliderTap)
        self.currentTap = sliderTap
        let panRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(MMPlayerControlView.panRecognizer(pan:)))
        panRecognizer.maximumNumberOfTouches =  1
        panRecognizer.delaysTouchesBegan = true
        panRecognizer.delaysTouchesEnded = true
        panRecognizer.cancelsTouchesInView = true
        panRecognizer.delegate = self
        view.addGestureRecognizer(panRecognizer)

        return view
    }()
    
    /** 全屏按钮 */
     lazy var fullScreenBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.setImage(MMPlayerImage(file: "Player_fullscreen"), for: .normal)
        view.setImage(MMPlayerImage(file: "Player_shrinkscreen"), for: .selected)
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 1
      
        return view
    }()
    /** 锁定屏幕方向按钮 */
    lazy var lockBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.setImage(MMPlayerImage(file: "Player_unlock-nor"), for: .normal)
        view.setImage(MMPlayerImage(file: "Player_lock-nor"), for: .selected)
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 2
        view.isHidden = true
        return view
    }()
    /** 快进快退label */
    private lazy var horizontalLabel:UILabel = {
        let view = UILabel.init()
        view.textColor  = WHITE_COLOR
        view.font = Font(fontSize: 15)
        view.textAlignment = .center
        
        view.backgroundColor = UIColor.init(patternImage: MMPlayerImage(file: "Player_management_mask"))
        view.isHidden = true
        return view
    }()
    /** 系统菊花 */
    lazy var activity:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        
        return view
    }()
    /** 返回按钮*/
     lazy var backBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.setImage(MMPlayerImage(file: "Player_back_full"), for: .normal)
        
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 3
        
        return view
    }()
    /** 关闭按钮*/
    private lazy var closeBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.setImage(MMPlayerImage(file: "Player_close"), for: .normal)
        view.isHidden = true
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 4
        
        return view
    }()
    /** 重播按钮 */
    private lazy var repeatBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.setImage(MMPlayerImage(file: "Player_repeat_video"), for: .normal)
        
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 5
        view.isHidden = true
        return view
    }()
    /** bottomView*/
    lazy var bottomImageView:UIImageView = {
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
        view.image = MMPlayerImage(file: "Player_bottom_shadow")
        return view
    }()
    /** topView */
     lazy var topImageView:UIImageView = {
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
        view.image = MMPlayerImage(file: "Player_top_shadow")
        return view
    }()
    /** 缓存按钮 */
    lazy var downLoadBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.setImage(MMPlayerImage(file: "Player_download"), for: .normal)
        view.setImage(MMPlayerImage(file: "Player_not_download"), for: .disabled)
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 6
        view.isHidden = true
        return view
    }()
    /** 切换分辨率按钮 */
    private lazy var resolutionBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        view.titleLabel?.font = Font(fontSize: 14)
        view.backgroundColor = UIColor.init(white:0, alpha: 0.7)
        
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 7
        view.isHidden = true
        return view
    }()
    /** 分辨率的View */
    private lazy var resolutionView:UIView = {
        let view = UIView.init()
        view.isHidden = true
        return view
    }()
    /** 播放按钮 */
    lazy var playeBtn:UIButton = {
        let view = UIButton.init(type: UIButtonType.custom)
        
        view.setImage(MMPlayerImage(file: "Player_play_btn"), for: .normal)
        
        view.addTarget(self, action: #selector(MMPlayerControlView.BtnClick(sender:)), for: .touchUpInside)
        view.tag = 8
        view.isHidden        = true
        return view
    }()
    
}
