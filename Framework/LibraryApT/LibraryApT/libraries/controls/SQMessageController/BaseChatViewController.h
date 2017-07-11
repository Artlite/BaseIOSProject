////
////  ChatViewController.h
////  JQMessagesTest
////
////  Created by Dmitry Lernatovich on 2/23/16.
////  Copyright © 2016 Magnet. All rights reserved.
////
//
//#import "JSQMessages.h"
//#import "JSQMessagesViewController.h"
//#import <UIKit/UIKit.h>
//
//typedef enum { BLACK, WHITE } HeaderColor;
//
//@interface BaseChatViewController
//    : JSQMessagesViewController <UIActionSheetDelegate,
//                                 JSQMessagesComposerTextViewPasteDelegate>
//
//@property(nonatomic, strong) UIView *_Nullable customNavigationView;
//
//@property(nonatomic, assign) BOOL isFirstInitialization;
//@property(nonatomic, assign) BOOL isNeedServerUpdate;
//@property(nonatomic, assign) BOOL isPullDownToRefresh;
//
//#pragma mark - navigation methods
//
//- (void)navigateModalByControllerId:(NSString *_Nonnull)controllerID;
//
//- (void)closeController;
//
//- (void)closePopController;
//
//#pragma mark - must be overriden
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the current user id
// *  (must be overriden)
// *
// *  @return user ID value
// */
//- (NSString *_Nonnull)getUserID;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the user display name
// *  (must be overriden)
// *
// *  @return user display name
// */
//- (NSString *_Nonnull)getUserDisplayName;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the action after message sending
// *  (must be overriden)
// *
// *  @param message message object
// */
//- (void)onMessageSended:(JSQMessage *_Nonnull)message;
//
//#pragma mark - functional methods
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the add messaging to the chat history
// *
// *  @param userID      user ID
// *  @param displayName user display name
// *  @param date        message date
// *  @param message     message
// */
//- (void)addMessage:(NSString *_Nonnull)userID
//       displayName:(NSString *_Nonnull)displayName
//              date:(NSDate *_Nonnull)date
//           message:(NSString *_Nonnull)message;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to setting of the messages history
// *
// *  @param messages messages
// */
//- (void)setMessagesHistory:(NSMutableArray<JSQMessage *> *_Nonnull)messages;
//
//#pragma mark - optional methods
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting title for the controller
// *  (can be overriden)
// *
// *  @return title value
// */
//- (NSString *_Nonnull)getTitle;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the showing of the attachment button
// *  (can be overriden)
// *
// *  @return is need show attachment button
// */
//- (BOOL)isNeedAttachmentButton;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the showing of the avtars on the collection view
// *  (can be overriden)
// *
// *  @return is need avatar value
// */
//- (BOOL)isNeedAvatars;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the defining if developer needs in the outgoing name
// * under the message bubble
// *  (can be overriden)
// *
// *  @return defination
// */
//- (BOOL)isNeedOutgoingName;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the defining if developer needs in the incomming name
// * under the message bubble
// *  (can be overriden)
// *
// *  @return defination
// */
//- (BOOL)isNeedIncommingName;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the defining of the timestamp frequency
// *  (can be overriden)
// *
// *  @return timestamp frequency
// */
//- (int)getTimestampFrequency;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the self bubble color
// *  (can be overriden)
// *
// *  @return self bubble color
// */
//- (UIColor *_Nonnull)getSelfBubbleColor;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the self bubble text color
// *
// *  @return self bubble text color
// */
//- (UIColor *_Nonnull)getSelfBubbleTextColor;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the other bubble color
// *  (can be overriden)
// *
// *  @return self bubble color
// */
//- (UIColor *_Nonnull)getOtherBubbleColor;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the other bubble text color
// *
// *  @return other buble text color
// */
//- (UIColor *_Nonnull)getOtherBubbleTextColor;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which prpvide to getting of the cell font
// *
// *  @return cells font
// */
//- (UIFont *_Nonnull)getCellsFont;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the avatar size\
// *  (can be overriden)
// *
// *  @return avatar size
// */
//- (int)getAvatarSize;
//
//#pragma mark - additional menu item
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the adding of the additional menu item
// *
// *  @param imageName icon image name
// */
//- (void)addMenuItem:(NSString *_Nonnull)imageName;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the action when additional menu pressed
// *  (can be overriden)
// */
//- (void)onAdditionalMenuPressed;
//
//#pragma mark - getters
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the messages count value
// *
// *  @return message count
// */
//- (int)getMessageCount;
//
//#pragma mark - setters
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the setting of the chat title text
// *
// *  @param titleText current title text
// */
//- (void)setChatTitle:(NSString *_Nonnull)titleText;
//
//#pragma mark - attachment dialog functional
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the attacnebt dialog title
// *
// *  @return dialog title
// */
//- (NSString *_Nonnull)getDialogTitle;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the attachment dialog items
// *
// *  @return dialog items
// */
//- (NSArray<NSString *> *_Nonnull)getDialogButtons;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to action when button dialog pressed
// *
// *  @param index button index
// */
//- (void)onDialogButtonPressed:(int)index;
//
//#pragma mark - additional header view
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the adding of the additional header view before
// * UICollectionView
// *
// *  @param additionalHeaderView additional view
// */
//- (void)setHeaderViewText:(NSString *_Nullable)text
//                    color:(HeaderColor)headerColor;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the clearing of the header view
// */
//- (void)clearHeaderView;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the additional header lines
// *
// *  @return additional header text lines
// */
//- (int)getAdditionalHeaderLines;
//
//#pragma mark - avatar functional
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the add image by image name (image should be in bundle)
// *
// *  @param userID    user id
// *  @param imageName image name
// *  @param userName  user name (using for generating image from name if image
// * not exists in bundle)
// */
//- (void)addAvatarFromImageName:(NSString *_Nonnull)userID
//                     imageName:(NSString *_Nullable)imageName
//                      userName:(NSString *_Nonnull)userName;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the add image by image name (image should be in bundle)
// *
// *  @param userID    user id
// *  @param image image
// *  @param userName  user name (using for generating image from name if image
// * not exists in bundle)
// */
//- (void)addAvatarFromUIImage:(NSString *_Nonnull)userID
//                       image:(UIImage *_Nullable)image
//                    userName:(NSString *_Nonnull)userName;
//
//#pragma mark - custom navigation bar
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the defining if developer needs custom navigation bar
// *
// *  @return definition
// */
//- (BOOL)isNeedCustomNavigationBar;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method whihc provide to getting of the custom navigation bar view
// *  (must be overriden when [self isNeedCustomNavigationBar] == YES)
// *
// *  @return custom navigation view
// */
//- (UIView *_Nonnull)getCustomNavigationBar;
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the custom navigation view heigh
// *
// *  @return heigh value
// */
//- (CGFloat)getCustomNavigationViewHeight;
//
//@end
