//
//  Tracker.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/21/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

@objc public final class KurioTracker: NSObject {
    
    
    /// Set tracker to launch from push notification instead.
    /// This will set first current screen from push notification.
    /// Usually called in PushNotificationManager.
    public static func trackFromPushNotification() {
        // Calling this will only set current screen, since there is no view screen push notification.
        TrackerManager.shared.launchFromPushNotification()
    }
    
    /// Set tracker to launch from deeplinking instead.
    /// This will set first current screen from deeplinking.
    /// Usually called in PushNotificationManager.
    public static func trackFromDeeplinking() {
        // Calling this will only set current screen, since there is no view screen deeplinking.
        TrackerManager.shared.launchFromDeeplinking()
    }
    
    // MARK: - Tracking ID 1 - 10
    
    public static func trackStartApplication() {
        TrackerManager.shared.log(withScreenView: .StartApplication,
                                 screenNameType: .StartApplication,
                                 property: "",
                                 origin: .None,
                                 andTag: .Application)
    }
    
    public static func trackLeaveApplication() {
        TrackerManager.shared.log(withScreenView: .LeaveApplication,
                                 screenNameType: .LeaveApplication,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .Application)
    }
    
    public static func trackViewWelcome() {
        TrackerManager.shared.log(withScreenView: .Welcome,
                                 screenNameType: .Welcome,
                                 property: "",
                                 origin: .StartApplication,
                                 andTag: .Welcome)
    }
    
    @available(*, deprecated, message: "This tracker will not be used in the future, use action 102 instead.")
    public static func trackReadArticle(withArticleId articleId: String,
                                        origin: ScreenNameType) {
        TrackerManager.shared.log(withScreenView: .Read,
                                 screenNameType: .ArticleDetail(articleId: articleId),
                                 property: articleId,
                                 origin: origin,
                                 andTag: .ArticleDetail)
    }
    
    @available(*, deprecated, message: "This tracker will not be used in the future, use action 102 instead.")
    public static func trackLeaveArticle(withArticleId articleId: String,
                                         origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .Leave,
                                 property: articleId,
                                 origin: origin,
                                 andTag: .ArticleDetail)
    }
    
    public static func trackTappedArticleOriginalView(withArticleId articleId: String,
                                                      origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .TapOriginalView,
                                 property: "",
                                 origin: origin,
                                 andTag: .ArticleDetail)
    }
    
    public static func trackTappedArticleURL(withOrigin origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .TapURL,
                                 property: "",
                                 origin: origin,
                                 andTag: .ArticleDetail)
    }
    
    public static func trackShare(withTargetShare targetShare: String) {
        TrackerManager.shared.log(withEvent: .Share,
                                 property: targetShare,
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .ArticleDetail)
    }
    
    public static func trackChangeFont(withSize size: String,
                                       origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .ChangeFontSize,
                                 property: size,
                                 origin: origin,
                                 andTag: .ArticleDetail)
    }
    
    // MARK: - Tracking ID 11 - 20
    
    public static func trackFavoriteArticle(withArticleId articleId: String) {
        TrackerManager.shared.log(withEvent: .Favorite,
                                 property: articleId,
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .Favorite)
    }
    
    public static func trackUnfavoriteArticle(withArticleId articleId: String) {
        TrackerManager.shared.log(withEvent: .Unfavorite,
                                 property: articleId,
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .Favorite)
    }
    
    public static func trackTappedArticleImage(withUrlString urlString: String,
                                               origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .TapImage,
                                 property: urlString,
                                 origin: origin,
                                 andTag: .ArticleDetail)
    }
    
    public static func trackTappedArticleVideo(withOrigin origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .TapURL,
                                 property: "",
                                 origin: origin,
                                 andTag: .ArticleDetail)
    }
    
    public static func trackViewSearch() {
        TrackerManager.shared.log(withScreenView: .Search,
                                 screenNameType: .Search,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .Search)
    }
    
    public static func trackViewSearchArticle(withKeyword keyword: String) {
        TrackerManager.shared.log(withScreenView: .SearchWithKeyword,
                                 screenNameType: .SearchKeyword(keyword: keyword),
                                 property: keyword,
                                 origin: .Search,
                                 andTag: .Search)
    }
    
    public static func trackFollowTopic(withStreamFormat streamFormat: String,
                                        origin: ScreenNameType = TrackerManager.shared.currentScreen) {
        TrackerManager.shared.log(withEvent: .FollowTopic,
                                 property: streamFormat,
                                 origin: origin,
                                 andTag: .Topics)
    }
    
    // MARK: - Tracking ID 21 - 30
    
    public static func trackUnfollowTopic(withStreamFormat streamFormat: String,
                                          origin: ScreenNameType = TrackerManager.shared.currentScreen) {
        TrackerManager.shared.log(withEvent: .UnfollowTopic,
                                 property: streamFormat,
                                 origin: origin,
                                 andTag: .Topics)
    }
    
    public static func trackViewPreviewArticleList(withStreamFormat streamFormat: String,
                                                   origin: ScreenNameType) {
        TrackerManager.shared.log(withScreenView: .PreviewArticle,
                                 screenNameType: .ArticleList(streamFormat: streamFormat),
                                 property: streamFormat,
                                 origin: origin,
                                 andTag: .ArticleList)
    }
    
    
    // MARK: - Tracking ID 31 - 40
    
    public static func trackViewTopics() {
        TrackerManager.shared.log(withScreenView: .TopicList,
                                 screenNameType: .TopicList,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .Topics)
    }
    
    public static func trackViewSubtopics(withTopicId topicId: String) {
        TrackerManager.shared.log(withScreenView: .Subtopic,
                                  screenNameType: .SubtopicList(topicGroupId: topicId),
                                  property: topicId,
                                  origin: .TopicList,
                                  andTag: .SubTopics)
    }
    
    public static func trackViewEditMyKurio() {
        TrackerManager.shared.log(withScreenView: .MyKurio,
                                 screenNameType: .MyKurio,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .MyKurio)
    }
    
    public static func trackViewSettings() {
        TrackerManager.shared.log(withScreenView: .Settings,
                                 screenNameType: .Settings,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .Setting)
    }
    
    public static func trackTogglingPushNotification(withValue value: Bool,
                                                     origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .TogglePushNotif,
                                 property: value,
                                 origin: origin,
                                 andTag: .Setting)
    }
    
    public static func trackTogglingNightMode(withValue value: Bool,
                                              origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .ToggleNightMode,
                                 property: value,
                                 origin: origin,
                                 andTag: .Setting)
    }
    
    public static func trackTogglingShowImage(withValue value: Bool,
                                              origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .ToggleShowImage,
                                 property: value,
                                 origin: origin,
                                 andTag: .Setting)
    }
    
    public static func trackTogglingParallaxEffect(withValue value: Bool,
                                                   origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .ToggleParallax,
                                 property: value,
                                 origin: origin,
                                 andTag: .Setting)
    }
    
    public static func trackViewPromoCode() {
        TrackerManager.shared.log(withScreenView: .PromoCode,
                                 screenNameType: .PromoCode,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .PromoCode)
    }
    
    // MARK: - Tracking ID 41 - 50
    
    public static func trackSubmitPromoCode(withCode code: String,
                                            origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .SubmitPromoCode,
                                 property: code,
                                 origin: origin,
                                 andTag: .PromoCode)
    }
    
    public static func trackInvalidatePromoCode(withPromoId promoId: String,
                                                origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .InvalidatePromoCode,
                                 property: promoId,
                                 origin: origin,
                                 andTag: .PromoCode)
    }
    
    @objc public static func trackInviteFriends(withMediaType mediaType: String) {
        TrackerManager.shared.log(withEvent: .InviteFriends,
                                 property: mediaType,
                                 origin: .Settings,
                                 andTag: .InviteFriends)
    }
    
    public static func trackSendFeedback() {
        TrackerManager.shared.log(withEvent: .SendFeedback,
                                 property: "",
                                 origin: .Settings,
                                 andTag: .SendFeedback)
    }
    
    public static func trackRateKurioApplication() {
        TrackerManager.shared.log(withEvent: .RateKurio,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .RateKurio)
    }
    
    public static func trackLogoutAccount(withOrigin origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .Logout,
                                 property: "",
                                 origin: origin,
                                 andTag: .SignOut)
    }
    
    public static func trackViewSignIn(withOrigin origin: ScreenNameType) {
        TrackerManager.shared.log(withScreenView: .SignIn,
                                 screenNameType: .SignIn,
                                 property: "",
                                 origin: origin,
                                 andTag: .SignIn)
    }
    
    public static func trackLoginAccount(withMediaType mediaType: String,
                                         origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .Login,
                                 property: mediaType,
                                 origin: origin,
                                 andTag: .SignIn)
    }
    
    public static func trackViewSignUp(withOrigin origin: ScreenNameType) {
        TrackerManager.shared.log(withScreenView: .SignUp,
                                 screenNameType: .SignUp,
                                 property: "",
                                 origin: origin,
                                 andTag: .SignUp)
    }
    
    public static func trackViewForgotPassword() {
        TrackerManager.shared.log(withScreenView: .ForgotPassword,
                                 screenNameType: .ForgotPassword,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .ForgotPassword)
    }
    
    // MARK: - Tracking ID 51 - 60
    
    public static func trackViewChangePassword() {
        TrackerManager.shared.log(withScreenView: .ChangePassword,
                                 screenNameType: .ChangePassword,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .ChangePassword)
    }
    
    public static func trackTappedGetStarted() {
        TrackerManager.shared.log(withEvent: .TapGetStarted,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .Welcome)
    }
    
    public static func trackReceivePushNotification(withArticleId articleId: String,
                                                    origin: ScreenNameType) {
        TrackerManager.shared.log(withScreenView: .StartApplication,
                                 screenNameType: .PushNotif,
                                 property: articleId,
                                 origin: origin,
                                 andTag: .Application)
    }
    
    public static func trackViewFavoritesArticle(withOrigin origin: ScreenNameType) {
        TrackerManager.shared.log(withScreenView: .FavoriteList,
                                 screenNameType: .FavoriteList,
                                 property: "",
                                 origin: origin,
                                 andTag: .Favorite)
    }
    
    public static func trackViewDontMissIt() {
        TrackerManager.shared.log(withScreenView: .DontMissIt,
                                 screenNameType: .DontMissIt,
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .DontMissIt)
    }
    
    public static func trackViewStreamsArticle(withStreamFormat streamFormat: String) {
        TrackerManager.shared.log(withScreenView: .StreamsArticle,
                                 screenNameType: .ArticleList(streamFormat: streamFormat),
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .ArticleList)
    }
    
    public static func trackViewStreamsVideo(withStreamFormat streamFormat: String) {
        TrackerManager.shared.log(withScreenView: .StreamsVideo,
                                 screenNameType: .VideoList(streamFormat: streamFormat),
                                 property: "",
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: .VideoList)
    }
    
    public static func trackViewChooseLocation(withStreamFormat streamFormat: String) {
        TrackerManager.shared.log(withScreenView: .ChooseLocation,
                                  screenNameType: .ChooseLocation,
                                  property: "",
                                  origin: .ArticleList(streamFormat: streamFormat),
                                  andTag: .ChooseLocation)
    }
    
    public static func trackTapAutoDetect() {
        TrackerManager.shared.log(withEvent: .TapAutoDetect, property: "",
                                  origin: TrackerManager.shared.currentScreen,
                                  andTag: .ArticleList)
    }
    
    public static func trackTapManualLocation() {
        TrackerManager.shared.log(withEvent: .TapManualLocation, property: "",
                                  origin: TrackerManager.shared.currentScreen,
                                  andTag: .ArticleList)
    }
    
    public static func trackSelectManualLocation(withLocationId locationId: Int) {
        TrackerManager.shared.log(withEvent: .SelectManualLocation,
                                  property: "\(locationId)",
                                  origin: TrackerManager.shared.currentScreen,
                                  andTag: .ChooseLocation)
    }
    
    // MARK: - Tracking ID 100 - 110
    
    public static func trackArticleReadSession(withProperty property: PropertyRead) {
        TrackerManager.shared.log(withEvent: .ArticleReadSession,
                                 property: property,
                                 origin: .ArticleDetail(articleId: property.articleId),
                                 andTag: .ArticleDetail)
    }
    
    public static func trackChangeArticleStreamTab(withProperty property: PropertyChangeTab) {
        TrackerManager.shared.log(withScreenView: .ChangeArticleStreamTab,
                                 screenNameType: .ArticleList(streamFormat: property.toStreamFormat),
                                 property: property,
                                 origin: .ArticleList(streamFormat: property.toStreamFormat),
                                 andTag: .ArticleList)
    }
    
    public static func trackTappedArticleMoreFromRelatedArticle(withProperty property: PropertyTapRelatedArticle) {
        TrackerManager.shared.log(withEvent: .TappedArticleMoreFromRelatedArticle,
                                 property: property,
                                 origin: .ArticleDetail(articleId: property.articleId),
                                 andTag: .ArticleDetail)
    }
    
    public static func trackTappedArticleMoreFromTopics(withProperty property: PropertyTapRelatedArticle) {
        TrackerManager.shared.log(withEvent: .TappedArticleMoreFromTopics,
                                 property: property,
                                 origin: .ArticleDetail(articleId: property.articleId),
                                 andTag: .ArticleDetail)
    }
    
    public static func trackVideoClick(withProperty property: PropertyVideoClick) {
        TrackerManager.shared.log(withEvent: .VideoClick,
                                 property: property,
                                 origin: .VideoList(streamFormat: property.placement),
                                 andTag: .VideoList)
    }
    
    // MARK: - Tracking ID 111 - 120
    
    public static func trackVideoStart(withProperty property: PropertyVideoStart,
                                       origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .VideoStart,
                                  property: property,
                                  origin: origin,
                                  andTag: .VideoList)
    }
    
    public static func trackVideoStop(withProperty property: PropertyVideoStop,
                                    origin: ScreenNameType) {
        TrackerManager.shared.log(withEvent: .VideoStop,
                                  property: property,
                                  origin: origin,
                                  andTag: .VideoList)
    }
    
    public static func trackChangeVideoStreamTab(withProperty property: PropertyChangeTab) {
            TrackerManager.shared.log(withScreenView: .ChangeVideoStreamTab,
                                     screenNameType: .VideoList(streamFormat: property.toStreamFormat),
                                     property: property,
                                     origin: .VideoList(streamFormat: property.fromStreamFormat),
                                     andTag: .VideoList)
    }
    
    public static func trackTappedArticleMoreFromSameSource(withProperty property: PropertyTapRelatedArticle) {
        TrackerManager.shared.log(withEvent: .TappedArticleMoreFromSameSource,
                                 property: property,
                                 origin: .ArticleDetail(articleId: property.articleId),
                                 andTag: .ArticleDetail)
    }
    
    public static func trackTappedVideoMoreFromSameSection(withProperty property: PropertyTapRelatedVideo) {
        TrackerManager.shared.log(withEvent: .TappedVideoMoreFromSameSection,
                                 property: property,
                                 origin: .VideoDetail(videoId: property.videoId),
                                 andTag: .VideoDetail)
    }
}
