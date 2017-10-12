//
//  Model.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/26.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import ObjectMapper
class Model: Mappable {
    var message: String?
    var data: ModelData?
    //评论
    var groupId:Int = 0
    var hasMore:Bool = false
    var newComment:Bool = false
    var totalNumber:Int = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]

    }

}
// MARK: - ModelData
class ModelData: Mappable {

    //发现
    var my_top_category_list: [My_top_category_list]?
    var rotate_banner: Rotate_banner?
    var categories: Categories?
    var god_comment: God_comment?
    var my_category_list: [My_category_list]?
    //分类
    var max_time: CGFloat = 0.0
    var min_time: Int = 0
    var tip: String?
    var data: [SubData]?
    var category_info: Category_info?
    var has_new_message: Bool = false
    var has_more: Bool = false
    //段友秀
    var banner : Banner?
    //评论
    var stick_comments : [Comment]?
    var recent_comments : [Comment]?
    var top_comments : [Comment]?
    //评论详情
    var cellType : Int = 0
    var commentCount : Int = 0
    var content : String?
    var createTime : Int = 0
    var delete : Int = 0
    var diggCount : Int = 0
    var dongtaiId : Int = 0
    var group : Group?
    var id : Int = 0
    var isPgcAuthor : Int = 0
    var logParam : LogParam?
    var shareUrl : String?
    var status : Int = 0
    var text : String?
    var user : User?
    var userDigg : Int = 0
    //回复评论
    var hotComments : [Comment]?
    var offset : Int = 0
    var stickHasMore : Bool = false
    var stickTotalNumber : Int = 0
    var totalCount : Int = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        my_top_category_list <- map["my_top_category_list"]
        rotate_banner <- map["rotate_banner"]
        categories <- map["categories"]
        god_comment <- map["god_comment"]
        my_category_list <- map["my_category_list"]
        category_info <- map["category_info"]
        tip <- map["tip"]
        has_more <- map["has_more"]
        data <- map["data"]
        banner <- map["banner"]
        top_comments <- map["top_comments"]
        recent_comments <- map["recent_comments"]
        stick_comments <- map["stick_comments"]
        cellType <- map["cell_type"]
        commentCount <- map["comment_count"]
        content <- map["content"]
        createTime <- map["create_time"]
        delete <- map["delete"]
        diggCount <- map["digg_count"]
        dongtaiId <- map["dongtai_id"]
        group <- map["group"]
        id <- map["id"]
        isPgcAuthor <- map["is_pgc_author"]
        logParam <- map["log_param"]
        shareUrl <- map["share_url"]
        status <- map["status"]
        text <- map["text"]
        user <- map["user"]
        userDigg <- map["user_digg"]
        has_more <- map["has_more"]
        hotComments <- map["hot_comments"]
        offset <- map["offset"]
        stickHasMore <- map["stick_has_more"]
        stickTotalNumber <- map["stick_total_number"]
        totalCount <- map["total_count"]
    }
}

class My_top_category_list: NSObject {

}

class Target_users: NSObject {

}
// MARK: - Url_list
class Url_list: Mappable {
    var url: String?
    var expires: Int = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        url <- map["url"]

    }
}
// MARK: - Banner_url
class Banner_url: Mappable {

    var id: Int = 0
    var title: String?
    var url_list: [Url_list]?
    var height: Int = 0
    var uri: String?
    var width: Int = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        url_list <- map["url_list"]
        height <- map["height"]

        uri <- map["uri"]

        width <- map["width"]

    }
}
class Banners: Mappable {
    var schema_url: String?
    var target_users: [Target_users]?
    var banner_url: Banner_url?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        schema_url <- map["schema_url"]
        target_users <- map["target_users"]
        banner_url <- map["banner_url"]

    }
}
// MARK: - Rotate_banner
class Rotate_banner: Mappable {
    var count: Int = 0
    var banners: [Banners]?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        count <- map["count"]
        banners <- map["banners"]

    }
}
class Material_bar: NSObject {

}
// MARK: - Category_list
class Category_list: Mappable {
    var is_recommend: Bool = false
    var icon: String?
    var share_type: Int = 0
    var mix_weight: String?
    var id: Int = 0
    var is_top: Bool = false
    var icon_url: String?
    var total_updates: Int = 0
    var small_icon_url: String?
    var is_risk: Bool = false
    var big_category_id: Int = 0
    var top_start_time: String?
    var type: Int = 0
    var buttons: String?
    var allow_text: Int = 0
    var extra: String?
    var tag: String?
    var intro: String?
    var post_rule_id: Int = 0
    var priority: Int = 0
    var subscribe_count: Int = 0
    var allow_multi_image: Int = 0
    var name: String?
    var today_updates: Int = 0
    var status: Int = 0
    var small_icon: String?
    var top_end_time: String?
    var visible: Bool = false
    var material_bar: [Material_bar]?
    var allow_gif: Int = 0
    var allow_text_and_pic: Int = 0
    var allow_video: Int = 0
    var channels: String?
    var dedup: Int = 0
    var share_url: String?
    var placeholder: String?
    var has_timeliness: Bool = false
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        icon_url <- map["icon_url"]
        name <- map["name"]
        subscribe_count <- map["subscribe_count"]
        today_updates <- map["today_updates"]
        total_updates <- map["total_updates"]
        placeholder <- map["placeholder"]

    }
}
// MARK: - Categories
class Categories: Mappable {
    var icon: String?
    var category_count: Int = 0
    var id: Int = 0
    var intro: String?
    var category_list: [Category_list]?
    var name: String?
    var priority: Int = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        icon <- map["icon"]
        category_count <- map["category_count"]
        id <- map["id"]
        intro <- map["intro"]
        category_list <- map["category_list"]
        name <- map["name"]
        priority <- map["priority"]

    }

}

class God_comment: NSObject {
    var icon: String?
    var count: Int = 0
    var intro: String?
    var name: String?

}

class My_category_list: NSObject {

}

class User: Mappable {

    var user_verified: Bool = false
    var ugc_count: Int = 0
    var is_following: Bool = false
    var followers: Int = 0
    var user_id: Int = 0
    var followings: Int = 0
    var is_pro_user: Bool = false
    var name: String?
    var avatar_url: String?
    //评论详情
    var authorBadge : [AnyObject]?
    var descriptionField : String?
    var isBlocked : Int = 0
    var isBlocking : Int = 0
    var isFollowed : Int = 0
    var isFollowing : Int = 0
    var isProUser : Bool = false
    var screenName : String?
    var userAuthInfo : String?
    var userRelation : Int = 0
    var userVerified : Int = 0
    var verifiedReason : String?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        user_id <- map["user_id"]
        name <- map["name"]
        avatar_url <- map["avatar_url"]
        authorBadge <- map["author_badge"]
        descriptionField <- map["description"]
        isBlocked <- map["is_blocked"]
        isBlocking <- map["is_blocking"]
        isFollowed <- map["is_followed"]
        isFollowing <- map["is_following"]
        isProUser <- map["is_pro_user"]
        screenName <- map["screen_name"]
        userAuthInfo <- map["user_auth_info"]
        userRelation <- map["user_relation"]
        userVerified <- map["user_verified"]
        verifiedReason <- map["verified_reason"]
    }
}

class Origin_video: NSObject {

    var url_list: [Url_list]?
    var width: Int = 0
    var uri: String?
    var height: Int = 0

}

class Neihan_hot_link: NSObject {

}

class Dislike_reason: NSObject {
    var type: Int = 0
    var id: Int = 0
    var title: String?

}

class Large_cover: Mappable {
    var url_list: [Url_list]?
    var uri: String?
    required init?(map: Map) {

    }
    func mapping(map: Map) {

        url_list <- map["url_list"]
        uri <- map["uri"]

    }
}

class Medium_cover: Mappable {
    var url_list: [Url_list]?
    var uri: String?
    required init?(map: Map) {

    }
    func mapping(map: Map) {

        url_list <- map["url_list"]
        uri <- map["uri"]

    }
}

//class 480p_video :NSObject {
//
//    var url_list: [Url_list]?
//    var width: Int = 0
//    var uri: String?
//    var height: Int = 0
//
//}
//
//@objc(360p_video)
//class 360p_video :NSObject, NSCoding, NSCopying {
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//        self.whc_Decode(aDecoder)
//    }
//
//    func encodeWithCoder(aCoder: NSCoder) {
//        self.whc_Encode(aCoder)
//    }
//
//    func copyWithZone(zone: NSZone) -> AnyObject {
//        return self.whc_Copy()
//    }
//
//    var url_list: [Url_list]?
//    var width: Int = 0
//    var uri: String?
//    var height: Int = 0
//
//}

class p_video720: Mappable {

    var url_list: [Url_list]?
    var width: Int = 0
    var uri: String?
    var height: Int = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        url_list <- map["url_list"]
        width <- map["width"]
        uri <- map["uri"]
        height <- map["height"]
    }
}

class Activity: NSObject {

}

class Danmaku_attrs: NSObject {

    var allow_send_danmaku: Int = 0
    var allow_show_danmaku: Int = 0

}

class Group: Mappable {
    var user_favorite: Int = 0
    var user: User?
    var publish_time: String?
    var uri: String?
    var id: Int = 0
    var origin_video: Origin_video?
    var play_count: Int = 0
    var display_type: Int = 0
    var group_id: Int = 0
    var category_visible: Bool = false
    var title: String?
    var video_wh_ratio: Int = 0
    var flash_url: String?
    var user_repin: Int = 0
    var cover_image_uri: String?
    var neihan_hot_link: Neihan_hot_link?
    var status_desc: String?
    var status: Int = 0
    var dislike_reason: [Dislike_reason]?
    var repin_count: Int = 0
    var cover_image_url: String?
    var digg_count: Int = 0
    var share_count: Int = 0
    var type: Int = 0
    var video_width: CGFloat = 0
    var neihan_hot_start_time: String?
    var is_video: Int = 0
    var has_hot_comments: Int = 0
    var comment_count: Int = 0
    var go_detail_count: Int = 0
    var favorite_count: Int = 0
    var large_cover: Large_cover?
    var text: String?
    var online_time: Int = 0
    var category_name: String?
    var download_url: String?
    var create_time: Int = 0
    var category_id: Int = 0
    var user_digg: Int = 0
    var category_type: Int = 0
    var share_url: String?
    var is_anonymous: Bool = false
    var quick_comment: Bool = false
    var bury_count: Int = 0
    var media_type: Int = 0
    var user_bury: Int = 0
    var medium_cover: Medium_cover?
    var share_type: Int = 0
    var duration: CGFloat = 0.0
    //var 480p_video: 480p_video?
    var video_height: CGFloat = 0
    var is_public_url: Int = 0
    var content: String?
    var video_id: String?
    var neihan_hot_end_time: String?
    var is_can_share: Int = 0
    var is_neihan_hot: Bool = false
    var mp4_url: String?
    var has_comments: Int = 0
    var keywords: String?
    // var 360p_video: 360p_video?
    var p_video720: p_video720?
    var m3u8_url: String?
    var label: Int = 0
    var id_str: String?
    var activity: Activity?
    var allow_dislike: Bool = false
    var danmaku_attrs: Danmaku_attrs?
    var is_multi_image: Int = 0
    var thumb_image_list: [Thumb_image_list]?
    var large_image_list: [Large_image_list]?
    var middle_image: Middle_image?
    var large_image: Large_image?
    var gifvideo: Gifvideo?
    //评论详情
    var groupId : Int = 0
    var groupIdStr : String?
    var itemId : Int = 0
    var itemIdStr : String?
    var itemType : Int = 0
    var mediaType : Int = 0
    var openUrl : String?
    var thumbUrl : String?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        text <- map["text"]
        large_cover <- map["large_cover"]
        medium_cover <- map["medium_cover"]
        thumb_image_list <- map["thumb_image_list"]
        p_video720 <- map["720p_video"]
        video_id <- map["video_id"]
        video_height <- map["video_height"]
        video_width <- map["video_width"]
        middle_image <- map["middle_image"]
        large_image <- map["large_image"]
        is_video <- map["is_video"]
        is_multi_image <- map["is_multi_image"]
        type <- map["type"]
        gifvideo <- map["gifvideo"]
        category_name <- map["category_name"]
        groupId <- map["group_id"]
        groupIdStr <- map["group_id_str"]
        itemId <- map["item_id"]
        itemIdStr <- map["item_id_str"]
        itemType <- map["item_type"]
        mediaType <- map["media_type"]
        openUrl <- map["open_url"]
        thumbUrl <- map["thumb_url"]
        title <- map["title"]
    }
}

//class Comments: NSObject {
//
//}

class SubData: Mappable {
    var group: Group?
    var online_time: Int = 0
    var type: Int = 0
    var comments: [Comment]?
    var display_time: Int = 0
    //var ad:[String]?
    //回复详情
    var content : String?
    var createTime : Int = 0
    var diggCount : Int = 0
    var id : Int = 0
    var isOwner : Bool = false
    var replyToComment : Comment?
    var text : String?
    var user : User?
    var userDigg : Bool = false
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        group <- map["group"]
        comments <- map["comments"]
        content <- map["content"]
        createTime <- map["create_time"]
        diggCount <- map["digg_count"]
        id <- map["id"]
        isOwner <- map["is_owner"]
        replyToComment <- map["reply_to_comment"]
        text <- map["text"]
        user <- map["user"]
        userDigg <- map["user_digg"]
    }
}
class Category_info: Mappable {
    var is_recommend: Bool = false
    var icon: String?
    var share_type: Int = 0
    var mix_weight: String?
    var id: Int = 0
    var background_image: String?
    var is_top: Bool = false
    var icon_url: String?
    var total_updates: Int = 0
    var small_icon_url: String?
    var is_risk: Bool = false
    var is_my_subscription: Bool = false
    var big_category_id: Int = 0
    var top_start_time: String?
    var is_my_top: Bool = false
    var buttons: String?
    var type: Int = 0
    var extra: String?
    var allow_text: Int = 0
    var intro: String?
    var post_rule_id: Int = 0
    var tag: String?
    var priority: Int = 0
    var subscribe_count: Int = 0
    var allow_multi_image: Int = 0
    var name: String?
    var today_updates: Int = 0
    var status: Int = 0
    var small_icon: String?
    var top_end_time: String?
    var visible: Bool = false
    var material_bar: [Material_bar]?
    var allow_gif: Int = 0
    var allow_text_and_pic: Int = 0
    var allow_video: Int = 0
    var channels: String?
    var dedup: Int = 0
    var placeholder: String?
    var has_timeliness: Bool = false
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        icon <- map["icon"]
        icon_url <- map["icon_url"]
        small_icon_url <- map["small_icon_url"]
        small_icon <- map["small_icon"]
        subscribe_count <- map["subscribe_count"]
        total_updates <- map["total_updates"]
        placeholder <- map["placeholder"]
    }
}

class Thumb_image_list: Mappable {
    var width: CGFloat = 0
    var is_gif: Bool = false
    var url_list: [Url_list]?
    var url: String?
    var uri: String?
    var height: CGFloat = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        url_list <- map["url_list"]
        url <- map["url"]
        uri <- map["uri"]
        width <- map["width"]
        height <- map["height"]
        is_gif <- map["is_gif"]

    }
}

class Large_image_list: NSObject {
    var width: Int = 0
    var is_gif: Bool = false
    var url_list: [Url_list]?
    var url: String?
    var uri: String?
    var height: Int = 0

}
class Middle_image: Mappable {
    var width: CGFloat = 0
    var url_list: [Url_list]?
    var uri: String?
    var r_height: CGFloat = 0
    var r_width: CGFloat = 0
    var height: CGFloat = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        url_list <- map["url_list"]
        uri <- map["uri"]
        height <- map["height"]
        width <- map["width"]

    }
}
class Large_image: Mappable {
    var width: Int = 0
    var url_list: [Url_list]?
    var uri: String?
    var r_height: Int = 0
    var r_width: Int = 0
    var height: Int = 0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        url_list <- map["url_list"]
        uri <- map["uri"]
        width <- map["width"]
        height <- map["height"]

    }
}
class Gifvideo: Mappable {
    var video_id:String?
    var p_video720: p_video720?
    var mp4_url:String?
    var video_height:CGFloat = 0
    var video_width:CGFloat = 0
    var duration: CGFloat = 0.0
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        p_video720 <- map["p_video720"]
        video_id <- map["video_id"]
        mp4_url <- map["mp4_url"]
        video_height <- map["video_height"]
        video_width <- map["video_width"]
        duration <- map["duration"]
    }
}
class Banner : Mappable{

    var bannerList : [BannerList]?
    var eachShowTime : Int = 0
    var total : Int = 0

    required init?(map: Map){}


    func mapping(map: Map)
    {
        bannerList <- map["banner_list"]
        eachShowTime <- map["each_show_time"]
        total <- map["total"]

    }


}
class BannerList : Mappable{

    var height : Int = 0
    var id : Int = 0
    var imgUri : String?
    var schemaUrl : String?
    var title : String?
    var urlList : [String]?
    var width : Int = 0


    required init?(map: Map) {

    }
    func mapping(map: Map)
    {
        height <- map["height"]
        id <- map["id"]
        imgUri <- map["img_uri"]
        schemaUrl <- map["schema_url"]
        title <- map["title"]
        urlList <- map["url_list"]
        width <- map["width"]

    }

}
class Comment : Mappable {

    var avatar_url : String?
    var buryCount : Int = 0
    var comment_id : Int = 0
    var createTime : Int = 0
    var descriptionField : String?
    var diggCount : Int = 0
    var groupId : Int = 0
    var id : Int = 0
    var isDigg : Int = 0
    var isProUser : Bool = false
    var platform : String?
    var platformId : String?
    var secondLevelCommentsCount : Int = 0
    var shareType : Int = 0
    var shareUrl : String?
    var status : Int = 0
    var text : String?
    var userBury : Int = 0
    var userDigg : Int = 0
    var userId : Int = 0
    var user_name : String?
    var userProfileImageUrl : String?
    var userProfileUrl : String?
    var userVerified : Bool = false
    //回复详情
    var authorBadge : [AnyObject]?

    var isFollowed : AnyObject?
    var isFollowing : AnyObject?
    var isOwner : Bool = false
    var isPgcAuthor : Bool = false
    var userAuthInfo : String?
    var userRelation : Int = 0
    var verifiedReason : String?
    required init?(map: Map) {

    }
    func mapping(map: Map)
    {
        avatar_url <- map["avatar_url"]
        buryCount <- map["bury_count"]
        comment_id <- map["comment_id"]
        createTime <- map["create_time"]
        descriptionField <- map["description"]
        diggCount <- map["digg_count"]
        groupId <- map["group_id"]
        id <- map["id"]
        isDigg <- map["is_digg"]
        isProUser <- map["is_pro_user"]
        platform <- map["platform"]
        platformId <- map["platform_id"]
        secondLevelCommentsCount <- map["second_level_comments_count"]
        shareType <- map["share_type"]
        shareUrl <- map["share_url"]
        status <- map["status"]
        text <- map["text"]
        userBury <- map["user_bury"]
        userDigg <- map["user_digg"]
        userId <- map["user_id"]
        user_name <- map["user_name"]
        userProfileImageUrl <- map["user_profile_image_url"]
        userProfileUrl <- map["user_profile_url"]
        userVerified <- map["user_verified"]
        authorBadge <- map["author_badge"]

        isFollowed <- map["is_followed"]
        isFollowing <- map["is_following"]
        isOwner <- map["is_owner"]
        isPgcAuthor <- map["is_pgc_author"]
        userAuthInfo <- map["user_auth_info"]
        userRelation <- map["user_relation"]
        userVerified <- map["user_verified"]
        verifiedReason <- map["verified_reason"]
    }
    
    
}
class LogParam :Mappable{

    var authorId : Int = 0
    var groupId : Int = 0
    var groupSource : Int = 0
    required init?(map: Map){}
    func mapping(map: Map)
    {
        authorId <- map["author_id"]
        groupId <- map["group_id"]
        groupSource <- map["group_source"]

    }

    
}
