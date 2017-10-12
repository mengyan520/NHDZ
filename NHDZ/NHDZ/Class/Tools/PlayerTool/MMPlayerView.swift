//
//  MMPlayerView.swift
//  糗百
//
//  Created by Youcai on 16/11/24.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer
// 枚举值，包含水平移动方向和垂直移动方向
enum PanDirection:Int {
    case PanDirectionHorizontalMoved  = 0// 横向移动
    case PanDirectionVerticalMoved = 1  // 纵向移动
}
// playerLayer的填充模式（默认：等比例填充，直到一个维度到达区域边界）
public enum MMPlayerLayerGravity {
    case MMPlayerLayerGravityResize      // 非均匀模式。两个维度完全填充至整个视图区域

    case MMPlayerLayerGravityResizeAspect     // 等比例填充，直到一个维度到达区域边界

    case MMPlayerLayerGravityResizeAspectFill      // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪

}
protocol MMPlayerViewDel:NSObjectProtocol {
    func MMPlayerViewWithBtnClick(sender:UIButton)

}

// 播放器的几种状态
public enum MMPlayerState {
    case notSetURL      // 未设置URL
    case readyToPlay    // 可以播放
    case buffering      // 缓冲中
    case bufferFinished // 缓冲完毕
    case playerStatePlaying    // 播放中
    case playedToTheEnd // 播放结束
    case playerStatePause // 暂停播放
    case playerStateStopped       // 停止播放
    case error          // 出现错误
}

class MMPlayerView: UIView,MMPlayerControlViewDel {

    // MARK: - 初始化 单例
    /**
     *  单例，用于列表cell上多个视频
     *
     *  @return MMPlayer
     */
    static let shardTools :MMPlayerView = {
        let tools = MMPlayerView.init()
        return tools
    }()
    // MARK: - 初始化
    init() {
        super.init(frame: CGRect.init())
        addSubview(controlView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 播放器
    fileprivate func setPlayer() {
        urlAsset = AVURLAsset.init(url: videoURL!)
        // 初始化playerItem
        playerItem = AVPlayerItem.init(asset: urlAsset!)
        // 每次都重新创建Player，替换replaceCurrentItemWithPlayerItem:，该方法阻塞线程

        player  = AVPlayer.init(playerItem: playerItem)
        // 初始化playerLayer
        playerLayer = AVPlayerLayer.init(player: player)
        //   playerLayer?.frame = self.bounds
        // 此处为默认视频填充模式
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        // 添加playerLayer到self.layer
        layer.insertSublayer(playerLayer!, at: 0)

        // 自动播放
        isAutoPlay = true
        isPlayBtnHidden = true
        // 添加播放进度计时器
        createTimer()
        // 本地文件不设置PlayerStateBuffering状态
        if videoURL?.scheme == "file" {
            state = .playerStatePlaying
            isLocalVideo = true

        }else {
            state = .buffering
            isLocalVideo = false

        }

        isPauseByUser = false

        NotificationCenter.default.addObserver(self, selector: #selector(moviePlayDidEnd(noti:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        //缓冲进度
        playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        // 缓冲区空了，需要等待数据
        playerItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        // 缓冲区有足够数据可以播放了
        playerItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
    }
    /**
     *  自动播放，默认不自动播放
     */
    func autoPlayTheVideo() {

        setPlayer()
    }
    /**
     *  播放
     */
    func play()  {


        controlView.playerStartBtnState(state:true)
        if state == .playerStatePause {
            state = .playerStatePlaying
        }
        isPauseByUser = false
        player?.play()

    }
    /**
     * 暂停
     */
    func pause() {
        controlView.playerStartBtnState(state:false)
        if state == .playerStatePlaying {
            state = .playerStatePause
        }
        isPauseByUser = true
        player?.pause()
    }
    /**
     *  重置player
     */
    func resetPlayer()  {
        if playerItem == nil {

            return
        }
        // 改为为播放完
        playDidEnd = false


        isAutoPlay = false
        if (timeObserve != nil) {
            player?.removeTimeObserver(timeObserve as Any)
            timeObserve = nil
        }

        // 改为为播放完
        playerItem?.removeObserver(self, forKeyPath: "status", context: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        playerItem?.removeObserver(self, forKeyPath: "status", context: nil)
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges", context: nil)
        playerItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty", context: nil)
        playerItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp", context: nil)
        self.tableView?.removeObserver(self, forKeyPath: "contentOffset")

        //移除通知
        REMOVENOTIFICATION(sender: self)

        // 暂停
        pause()
        // 移除原来的layer
        playerLayer?.removeFromSuperlayer()

        // 替换PlayerItem为nil
        player?.replaceCurrentItem(with: nil)
        // 把player置为nil
        playerItem = nil
        player = nil
        controlView.playerResetControlView()
        if !repeatToPlay {
            self.removeFromSuperview()
        }
        isCellVideo = false
        tableView = nil



    }

    /**
     *  用于cell上播放player
     *
     *  @param videoURL  视频的URL
     *  @param tableView tableView
     *  @param indexPath indexPath
     *  @param ImageViewTag ImageViewTag
     */
    func setVideoURLwithTableViewAtIndexPathwithImageViewTag(videoURL:URL,tableView:UITableView,superView:UIView, tag:Int) {
        if  playerItem != nil  {

            resetPlayer()
        }

        // 在cell上播放视频
        isCellVideo = true
        // 设置tableview
        self.tableView = tableView

        // 设置视频URL
        self.videoURL = videoURL
        // 在cell播放
        controlView.playerCellPlay()
        superView.addSubview(self)
        self.superView = superView
        self.frame = superView.bounds
        self.tableView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    // MARK: - 公有属性
    /** 视频URL */
    var videoURL:URL? {
        didSet {
            // 每次加载视频URL都设置重播为NO
            repeatToPlay = false
            playDidEnd = false
            isPauseByUser = true
            // 添加通知
            addNotifications()
            // 添加手势
            createGesture()

        }
    }
    /** 播放前占位图片，不设置就显示默认占位图（需要在设置视频URL之前设置） */
    var placeholderImage:UIImage?{
        didSet {


            layer.contents = placeholderImage?.cgImage


        }

    }
    /** 是否被用户暂停 */
    var isPauseByUser:Bool = true
    /** 视频标题 */
    var title:String? {
        didSet {
            controlView.titleLabel.text = title
        }
    }
    /** 是否有下载功能(默认是关闭) */
    var hasDownload:Bool? {
        didSet {
            controlView.downLoadBtn.isHidden = !hasDownload!

        }

    }
    /** 是否显示播放按钮(默认是关闭) */
    var isPlayBtnHidden:Bool? {
        didSet {
            controlView.playeBtn.isHidden = isPlayBtnHidden!

        }

    }
    /** 是否显示小视频(默认是关闭) */
    var isSmall:Bool = false
    var smallSize :CGSize = CGSize.zero
    var smallHeight:CGFloat = 0
    // MARK: - 私有属性
    /** 播放属性 */
    fileprivate var  player:AVPlayer?//播放器
    fileprivate  var  playerItem:AVPlayerItem?{//数据管家
        didSet{

        }
    }

    fileprivate var  urlAsset:AVURLAsset?//是AVAsset的子类，负责网络连接，请求数据
    /** playerLayer */
    fileprivate  var playerLayer:AVPlayerLayer?//图层
    /** 播发器的几种状态 */
    fileprivate  var state:MMPlayerState? {
        didSet {

            state == .buffering ? controlView.activity.startAnimating(): controlView.activity.stopAnimating()
        }
    }
    /** 是否自动播放 */
    var isAutoPlay:Bool = false
    /** 播放完了*/
    var playDidEnd:Bool = false
    /** 是否再次设置URL播放视频 */
    var repeatToPlay:Bool = false
    /** slider上次的值 */
    var sliderLastValue:Float = 0
    /** 是否播放本地文件 */
    var isLocalVideo:Bool = false
    var timeObserve:Any?
    var superView:UIView?
    /** 是否在cell上播放video */
    var isCellVideo:Bool = false
    var tableView:UITableView?

    // MARK: - 懒加载
    lazy var controlView:MMPlayerControlView = {
        let view = MMPlayerControlView()
        view.del = self

        return view
    }()
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()

        print("dsfd")
        controlView.frame = self.bounds
        if self.controlView.fullScreenBtn.isSelected {

            self.playerLayer?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_HEIGHT, height: SCREEN_WIDTH)
        } else {

            playerLayer?.frame = self.bounds
        }



    }
    deinit {

        playerItem = nil
        tableView = nil
        controlView.playerCancelAutoFadeOutControlView()
        NotificationCenter.default.removeObserver(self)
        if (timeObserve != nil) {
            player?.removeTimeObserver(timeObserve as Any)
            timeObserve = nil
        }
    }
}
extension MMPlayerView {
    // MARK: - MMPlayerControlViewDel
    func ControlViewWithBtnClick(sender: UIButton) {
        switch sender.tag {
        case 0:
            isPauseByUser = !isPauseByUser
            if isPauseByUser {
                pause()
                if state == .playerStatePlaying {
                    state = .playerStatePause
                }
            }else {
                play()
                if state == .playerStatePause {
                    state = .playerStatePlaying
                }
            }
            if !isAutoPlay {

                setPlayer()
            }
            break
        case 1:
            if isCellVideo {

                if sender.isSelected {
                    self.removeFromSuperview()

                    self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))


                    UIApplication.shared.keyWindow?.addSubview(self)
                    self.frame =  (UIApplication.shared.keyWindow?.bounds)!




                    self.controlView.backBtn.isHidden = false

                } else {

                    self.controlView.backBtn.isHidden = true



                    UIView.animate(withDuration: 0.5, animations: {

                        self.transform = CGAffineTransform.identity
                        self.superView?.addSubview(self)
                        self.frame =  (self.superView?.bounds)!


                    })
                }

            } else {


            }

            break
        case 2:

            break
        case 3:
            self.controlView.fullScreenBtn.isSelected = false
            self.controlView.backBtn.isHidden = true
            UIView.animate(withDuration: 0.5, animations: {

                self.transform = CGAffineTransform.identity
                self.superView?.addSubview(self)
                self.frame =  (self.superView?.bounds)!


            })


            break
        case 4:

            break
        case 5:
            playDidEnd = false
            repeatToPlay = false
            seekToTime(0, completionHandler: nil)
            break
        case 6:

            //del?.MMPlayerViewWithBtnClick(sender: sender)


            break
        case 7:

            break
        case 8:
            isPauseByUser = !isPauseByUser

            break
        default: break

        }

    }
    func ControlViewWithProgressSliderValueChanged(sender:UISlider) {
        // 拖动改变视频播放进度

        if player?.currentItem?.status == AVPlayerItemStatus.readyToPlay {

            var style = false
            let value = sender.value - sliderLastValue
            if  value > 0 {
                style = true
            }
            if value < 0 {
                style = false
            }
            if  value == 0 {
                return
            }
            sliderLastValue = sender.value
            // 暂停
            pause()
            let totalTime = Float((playerItem?.duration.value)!) / Float((playerItem?.duration.timescale)!)
            //计算出拖动的当前秒数
            let dragedSeconds = totalTime * sender.value
            //转换成CMTime才能给player来控制播放进度
            // let dragedCMTime = CMTime.init(value: CMTimeValue(dragedSeconds), timescale: 1)

            controlView.playerDraggedTimeAndTotalTimeAndIsForwardAndHasPreview(draggedTime: Int(dragedSeconds), totalTime: Int(totalTime), forawrd: style, preview: false)
            if totalTime > 0 {// 当总时长 > 0时候才能拖动slider



            }else {// 此时设置slider值为0
                sender.value = 0
            }
        }else {
            // player状态加载失败
            // 此时设置slider值为0
            sender.value = 0

        }

    }
    func ControlViewWithProgressSliderTouchEnded(sender:UISlider) {
        if player?.currentItem?.status == AVPlayerItemStatus.readyToPlay {

            isPauseByUser = false
            // 视频总时间长度
            let totalTime   = TimeInterval((playerItem?.duration.value)!) / TimeInterval((playerItem?.duration.timescale)!)

            //计算出拖动的当前秒数
            let target = totalTime *  Double(sender.value)

            seekToTime(target, completionHandler: nil)
        }

    }
    func ControlViewWithprogressSliderTap(tapValue:CGFloat) {
        if player?.currentItem?.status == AVPlayerItemStatus.readyToPlay {
            pause()
            isPauseByUser = false
            // 视频总时间长度
            let totalTime   = TimeInterval((playerItem?.duration.value)!) / TimeInterval((playerItem?.duration.timescale)!)

            //计算出拖动的当前秒数
            let target = totalTime *  Double(tapValue)

            seekToTime(target, completionHandler: nil)
        }


    }
}
// MARK: - 定时器
extension MMPlayerView {
    fileprivate func createTimer() {

        timeObserve = player?.addPeriodicTimeObserver(forInterval: CMTime.init(seconds: 1, preferredTimescale: 1), queue: nil, using: {[weak self] (time) in
            let currentItem = self?.playerItem

            if (currentItem != nil) {
                let loadedRanges = currentItem?.seekableTimeRanges
                if (loadedRanges?.count)! > 0 && (currentItem?.duration.timescale)! != 0 {
                    let currentTime = CMTimeGetSeconds((currentItem?.currentTime())!)
                    let totalTime:CGFloat = CGFloat ((currentItem?.duration.value)!) /  CGFloat((currentItem?.duration.timescale)!)

                    let value = CGFloat (currentTime) / totalTime
                    self?.controlView.playerCurrentTimeAndtotalTimeAndsliderValue(currentTime: Int(currentTime), totalTime: Int(totalTime), value: Float(value))
                }
            }})
        //滑动滚动条会回退 ,需要暂停定时器
        /**

         [timer setFireDate:[NSDate date]]; //继续。
         [timer setFireDate:[NSDate distantPast]];//开启
         [timer setFireDate:[NSDate distantFuture]];//暂停
         */
        // self.timer  = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MMPlayer.playerTimerAction), userInfo: nil, repeats: true)


    }

    fileprivate func seekToTime(_ secounds: TimeInterval, completionHandler:(()->Void)?) {
        if secounds.isNaN  {
            return
        }
        if self.player?.currentItem?.status == AVPlayerItemStatus.readyToPlay {
            let draggedTime = CMTimeMake(Int64(secounds), 1)
            self.player!.seek(to: draggedTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero, completionHandler: { (finished) in
                self.play()

                // if (!(self.playerItem?.isPlaybackLikelyToKeepUp)! && !self.isLocalVideo) {
                //self.state = .buffering
                // }

            })
        }
    }

}
// MARK: -  KVO
extension MMPlayerView {

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as? AVPlayerItem == self.player?.currentItem {
            if keyPath == "status" {
                if player?.currentItem?.status == AVPlayerItemStatus.readyToPlay {
                    state = .playerStatePlaying
                    play()
                }else if (player?.currentItem?.status == AVPlayerItemStatus.failed) {
                    state = .error
                    let error = playerItem?.error
                    controlView.playeritemStatusFailed(error:error!)
                }

            }else if (keyPath == "loadedTimeRanges") {
                // 计算缓冲进度
                let timeInterval = availableDuration()
                let duration = playerItem?.duration
                let totalDuration = CMTimeGetSeconds(duration!)
                controlView.playerSetProgress(progress: Float(timeInterval) / Float(totalDuration))
            }else if (keyPath == "playbackBufferEmpty") {
                // 当缓冲是空的时候
                if (playerItem?.isPlaybackBufferEmpty)! {
                    state = .buffering
                    bufferingSomeSecond()
                }
            }else if (keyPath == "playbackLikelyToKeepUp") {
                // 当缓冲好的时候
                if (playerItem?.isPlaybackLikelyToKeepUp)! && state == .buffering {
                    state = .playerStatePlaying

                }
            }
        }else if (object as? UITableView == tableView) {
            if keyPath == "contentOffset" {

                if !isSmall {


                    let cell = self.superView?.superview?.superview as? UITableViewCell
                    let visableCells = tableView?.visibleCells
                    guard cell != nil else {
                        resetPlayer()
                        return
                    }

                    guard (visableCells?.contains(cell! as UITableViewCell))! else {
                        resetPlayer()
                        return
                    }
                }else {
                    let offsetY = ((change![NSKeyValueChangeKey.newKey]! as AnyObject).cgPointValue.y)

                    if offsetY >= smallHeight {
                        updatePlayerViewToSmall()
                    }else {
                        updatePlayerViewToCell()
                    }
                }
            }
        }



    }

    // MARK: - 计算缓冲进度
    /**
     *  计算缓冲进度
     *
     *  @return 缓冲进度
     */
    private func availableDuration()->TimeInterval {
        let loadedTimeRanges = player?.currentItem?.loadedTimeRanges
        // 获取缓冲区域

        let timeRange = loadedTimeRanges?.first?.timeRangeValue
        let startSeconds = CMTimeGetSeconds((timeRange?.start)!)
        let durationSeconds = CMTimeGetSeconds((timeRange?.duration)!)
        return  startSeconds + durationSeconds // 计算缓冲总进度
    }
    // MARK: -  缓冲较差时候
    /**
     *  缓冲较差时候回调这里
     */
    private func bufferingSomeSecond() {
        state = .buffering
        // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
        var isBuffering = false
        if isBuffering {
            return
        }
        isBuffering = true
        // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
        player?.pause()
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            // 如果此时用户已经暂停了，则不再需要开启播放了
            if self.isPauseByUser {
                isBuffering = false
                return
            }
            // self.play()
            // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
            isBuffering = false
            if (self.playerItem?.isPlaybackLikelyToKeepUp)! {

                self.bufferingSomeSecond()
            }
        }
    }
    // MARK: - 更改播放器位置
    /**
     *  显示小视频
     */
    private func updatePlayerViewToSmall() {
        if !isSmall {
            return
        }
        UIApplication.shared.keyWindow?.addSubview(self)
        self.frame = CGRect.init(x: SCREEN_WIDTH-smallSize.width, y: smallHeight, width: smallSize.width, height: smallSize.height)
        controlView.frame = self.bounds
        
    }
    /**
     *  回到cell显示
     */
    private func updatePlayerViewToCell() {
        if !isSmall {
            return
        }
        self.removeFromSuperview()
        superView?.addSubview(self)
        self.frame = (superView?.bounds)!
        controlView.frame = self.bounds
    }
}
// MARK: - 通知
extension MMPlayerView {


    /** 监听 app 进入前后台 */
    fileprivate func addNotifications() {
        // app退到后台
        NotificationCenter.default.addObserver(self, selector: #selector(MMPlayerView.appDidEnterBackground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        // app进入前台
        NotificationCenter.default.addObserver(self, selector: #selector(MMPlayerView.appDidEnterPlayground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)


    }
    @objc fileprivate func appDidEnterBackground()  {
        controlView.playerCancelAutoFadeOutControlView()
        controlView.playerStartBtnState(state:false)
        player?.pause()
    }
    @objc private func appDidEnterPlayground()  {
        controlView.playerShowControlView()
        if !isPauseByUser {
            
            controlView.playerStartBtnState(state:true)
            isPauseByUser = false
            play()
        }
        
        
    }
    /** 监听playerItem是否播放完毕  */
    @objc fileprivate func moviePlayDidEnd(noti:NSNotification)  {
        state = .playerStateStopped
        playDidEnd = true
        controlView.playerPlayDidEnd()
    }
    
}
// MARK: - 创建手势
extension MMPlayerView {
    
    /** 隐藏/显示 MMPlayerControlView */
    fileprivate func createGesture() {
        let  singleTap = UITapGestureRecognizer.init(target: self, action: #selector(MMPlayerView.singleTapAction(tap:)))
        addGestureRecognizer(singleTap)
        // 双击(播放/暂停)
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(MMPlayerView.doubleTapAction(tap:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
    }
    @objc fileprivate func singleTapAction(tap:UIGestureRecognizer) {
        controlView.playerShowControlView()
    }
    @objc fileprivate func doubleTapAction(tap:UIGestureRecognizer) {
        // 显示控制层
        controlView.playerCancelAutoFadeOutControlView()
        controlView.playerShowControlView()
        if isPauseByUser {
            play()
        }else {
            pause()
        }
        if !isAutoPlay {
            
            setPlayer()
        }
        
    }
}
