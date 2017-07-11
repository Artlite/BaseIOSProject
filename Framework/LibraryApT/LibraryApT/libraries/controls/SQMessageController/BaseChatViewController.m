////
////  ChatViewController.m
////  JQMessagesTest
////
////  Created by Dmitry Lernatovich on 2/23/16.
////  Copyright © 2016 Magnet. All rights reserved.
////
//
//// This line should be added to po file: pod 'JSQMessagesViewController'
//
//#import "BaseChatViewController.h"
//#define K_COLOR_LIGHT_BACKGROUND                                               \
//  [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:0.7f];
//#define K_COLOR_BLACK_BACKGROUND                                               \
//  [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
//
//@interface BaseChatViewController ()
//
//@property(nonatomic, strong) NSMutableArray<JSQMessage *> *messages;
//@property(nonatomic, strong) JSQMessagesBubbleImage *outgoingBubbleImageData;
//@property(nonatomic, strong) JSQMessagesBubbleImage *incomingBubbleImageData;
//@property(nonatomic, strong)
//    NSMutableDictionary<NSString *, JSQMessagesAvatarImage *> *avatarDict;
//@property(nonatomic, strong)
//    NSMutableDictionary<NSString *, JSQMessagesAvatarImage *>
//        *namedAvatarDictionary;
//
//@property(nonatomic, strong) UILabel *labelAdditional;
//@property(nonatomic, strong) UIView *viewBlured;
//@property(nonatomic, strong) UIView *viewHeader;
//
//@end
//
//@implementation BaseChatViewController
//
//- (void)viewDidLoad {
//  [super viewDidLoad];
//  [self onInitializeContainers];
//  [self onInitializeBubbles];
//  [self onInitializeSenderInformation];
//  [self onInitalizeControllerUI];
//  [self refreshHeaderView:WHITE text:nil hiden:YES];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//  [super viewWillAppear:animated];
//  [self.view endEditing:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//  [super viewWillDisappear:animated];
//}
//
//#pragma mark - initialize functional
//
///**
// ===========================================================================================
//                                INITIALIZE FUNCTIONAL
// ===========================================================================================
// */
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the bubbles initialization
// */
//- (void)onInitializeBubbles {
//  JSQMessagesBubbleImageFactory *bubbleFactory =
//      [[JSQMessagesBubbleImageFactory alloc] init];
//
//  self.outgoingBubbleImageData = [bubbleFactory
//      outgoingMessagesBubbleImageWithColor:[self getSelfBubbleColor]];
//  self.incomingBubbleImageData = [bubbleFactory
//      incomingMessagesBubbleImageWithColor:[self getOtherBubbleColor]];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the container initialization
// */
//- (void)onInitializeContainers {
//  self.messages = [NSMutableArray new];
//  self.avatarDict = [NSMutableDictionary new];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the initialization of the sender informations
// */
//- (void)onInitializeSenderInformation {
//  self.senderId = [self getUserID];
//  self.senderDisplayName = [self getUserDisplayName];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the controller UI initialization
// */
//- (void)onInitalizeControllerUI {
//  [self setChatTitle:[self getTitle]];
//  self.inputToolbar.contentView.textView.pasteDelegate = self;
//  self.collectionView.collectionViewLayout.incomingAvatarViewSize =
//      CGRectMake(0, 0, [self getAvatarSize], [self getAvatarSize]).size;
//  self.collectionView.collectionViewLayout.outgoingAvatarViewSize =
//      CGRectMake(0, 0, [self getAvatarSize], [self getAvatarSize]).size;
//  self.showLoadEarlierMessagesHeader = NO;
//  self.collectionView.collectionViewLayout.messageBubbleFont =
//      [self getCellsFont];
//  if ([self isNeedAttachmentButton] == NO) {
//    self.inputToolbar.contentView.leftBarButtonItem = nil;
//  }
//
//  if ([self isNeedAvatars] == NO) {
//    self.collectionView.collectionViewLayout.incomingAvatarViewSize =
//        CGSizeZero;
//
//    self.collectionView.collectionViewLayout.outgoingAvatarViewSize =
//        CGSizeZero;
//  }
//
//  if (self.navigationController && self.navigationController.navigationBar) {
//    if ([self isNeedCustomNavigationBar] == YES) {
//      self.navigationController.navigationBarHidden = YES;
//    } else {
//      self.navigationController.navigationBarHidden = NO;
//    }
//  }
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the pressed action button performing (send message)
// *
// *  @param button            button
// *  @param text              message text
// *  @param senderId          sender ID
// *  @param senderDisplayName sender display name
// *  @param date              message date
// */
//- (void)didPressSendButton:(UIButton *)button
//           withMessageText:(NSString *)text
//                  senderId:(NSString *)senderId
//         senderDisplayName:(NSString *)senderDisplayName
//                      date:(NSDate *)date {
//
//  [JSQSystemSoundPlayer jsq_playMessageSentSound];
//  JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId
//                                           senderDisplayName:senderDisplayName
//                                                        date:date
//                                                        text:text];
//
//  [self.messages addObject:message];
//
//  [self onMessageSended:message];
//
//  [self finishSendingMessageAnimated:YES];
//}
//
//#pragma mark - attachment button
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the action when attachment button pressed
// *
// *  @param sender
// */
//- (void)didPressAccessoryButton:(UIButton *)sender {
//  [self.inputToolbar.contentView.textView resignFirstResponder];
//
//  UIActionSheet *sheet =
//      [[UIActionSheet alloc] initWithTitle:[self getDialogTitle]
//                                  delegate:self
//                         cancelButtonTitle:@"Cancel"
//                    destructiveButtonTitle:nil
//                         otherButtonTitles:nil];
//
//  for (NSString *value in [self getDialogButtons]) {
//    [sheet addButtonWithTitle:value];
//  }
//
//  [sheet showFromToolbar:self.inputToolbar];
//}
//
//- (void)actionSheet:(UIActionSheet *)actionSheet
//    didDismissWithButtonIndex:(NSInteger)buttonIndex {
//
//  if (buttonIndex == actionSheet.cancelButtonIndex) {
//    return;
//  }
//  [self onDialogButtonPressed:@(buttonIndex).intValue];
//}
//
//#pragma mark - JSQMessages CollectionView DataSource
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the current image
// *
// *  @param collectionView
// *  @param indexPath
// *
// *  @return
// */
//- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView
//       messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
//  return [self.messages objectAtIndex:indexPath.item];
//}
//
//- (void)collectionView:(JSQMessagesCollectionView *)collectionView
//    didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath {
//  [self.messages removeObjectAtIndex:indexPath.item];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the bubble data generation
// *
// *  @param collectionView collection view
// *  @param indexPath      index path
// *
// *  @return image data value
// */
//- (id<JSQMessageBubbleImageDataSource>)collectionView:
//                                           (JSQMessagesCollectionView *)
//                                               collectionView
//             messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//  JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
//
//  if ([message.senderId isEqualToString:self.senderId]) {
//    return self.outgoingBubbleImageData;
//  }
//
//  return self.incomingBubbleImageData;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the avatar generating if it is exists
// *
// *  @param collectionView collection view
// *  @param indexPath      index
// *
// *  @return avatar image
// */
//- (id<JSQMessageAvatarImageDataSource>)
//                   collectionView:(JSQMessagesCollectionView *)collectionView
//avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//  if ([self isNeedAvatars] == NO) {
//    return nil;
//  }
//
//  JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
//  JSQMessagesAvatarImage *avatar;
//
//  //  if ([message.senderId isEqualToString:self.senderId]) {
//  avatar =
//      [self getAvatarByID:message.senderId userName:message.senderDisplayName];
//  //  } else {
//  //    avatar = [self getAvatar:message.senderId
//  //                   imageName:nil
//  //                    userName:message.senderDisplayName];
//  //  }
//
//  return avatar;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the show of the timestamp (for example every 3
// * message
// * show timestamt)
// *
// *  @param collectionView collection view
// *  @param indexPath      index
// *
// *  @return string with date
// */
//- (NSAttributedString *)collectionView:
//                            (JSQMessagesCollectionView *)collectionView
//    attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
//  if (indexPath.item % [self getTimestampFrequency] == 0) {
//    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
//    return [[JSQMessagesTimestampFormatter sharedFormatter]
//        attributedTimestampForDate:message.date];
//  }
//
//  return nil;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the showing of the user name under the bubble data
// *
// *  @param collectionView collection view
// *  @param indexPath      index
// *
// *  @return user name
// */
//- (NSAttributedString *)collectionView:
//                            (JSQMessagesCollectionView *)collectionView
//    attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
//  JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
//
///**
// *  iOS7-style sender name labels
// */
//
//#pragma mark current user
//  if ([message.senderId isEqualToString:self.senderId]) {
//
//    if ([self isNeedOutgoingName] == NO) {
//      return nil;
//    }
//
//    if (indexPath.item - 1 >= 0) {
//      JSQMessage *previousMessage =
//          [self.messages objectAtIndex:indexPath.item - 1];
//      if ([[previousMessage senderId] isEqualToString:message.senderId]) {
//        return nil;
//      }
//    }
//  }
//
//#pragma mark other user
//
//  if (![message.senderId isEqualToString:self.senderId]) {
//
//    if ([self isNeedIncommingName] == NO) {
//      return nil;
//    }
//
//    if (indexPath.item - 1 >= 0) {
//      JSQMessage *previousMessage =
//          [self.messages objectAtIndex:indexPath.item - 1];
//      if ([[previousMessage senderId] isEqualToString:message.senderId]) {
//        return nil;
//      }
//    }
//  }
//
//  /**
//   *  Don't specify attributes to use the defaults.
//   */
//  return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the setting additional text on the bottom of the
// * message bubble
// *
// *  @param collectionView collection view
// *  @param indexPath      index
// *
// *  @return bottom text
// */
//- (NSAttributedString *)collectionView:
//                            (JSQMessagesCollectionView *)collectionView
//    attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
//  return nil;
//}
//
//#pragma mark - UICollectionView DataSource
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the count of the cells
// *
// *  @param collectionView collection view
// *  @param section        section
// *
// *  @return cells count
// */
//- (NSInteger)collectionView:(UICollectionView *)collectionView
//     numberOfItemsInSection:(NSInteger)section {
//  return [self.messages count];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the cell customization
// *
// *  @param collectionView collection view
// *  @param indexPath      index
// *
// *  @return generated cell
// */
//- (UICollectionViewCell *)collectionView:
//                              (JSQMessagesCollectionView *)collectionView
//                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//  JSQMessagesCollectionViewCell *cell =
//      (JSQMessagesCollectionViewCell *)[super collectionView:collectionView
//                                      cellForItemAtIndexPath:indexPath];
//
//  JSQMessage *msg = [self.messages objectAtIndex:indexPath.item];
//
//  if (!msg.isMediaMessage) {
//
//    if ([msg.senderId isEqualToString:self.senderId]) {
//      cell.textView.textColor = [self getSelfBubbleTextColor];
//    } else {
//      cell.textView.textColor = [self getOtherBubbleTextColor];
//    }
//
//    cell.textView.linkTextAttributes = @{
//      NSForegroundColorAttributeName : cell.textView.textColor,
//      NSUnderlineStyleAttributeName :
//          @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)
//    };
//  }
//
//  return cell;
//}
//
//#pragma mark - UICollectionView Delegate
//
//#pragma mark - Adjusting cell label heights
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the calculationg of the cell height for the timestamp
// * cell
// *
// *  @param collectionView       collection view
// *  @param collectionViewLayout collection view layout
// *  @param indexPath            index
// *
// *  @return calculated height
// */
//- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
//                              layout:(JSQMessagesCollectionViewFlowLayout *)
//                                         collectionViewLayout
//    heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
//
//  if (indexPath.item % [self getTimestampFrequency] == 0) {
//    return kJSQMessagesCollectionViewCellLabelHeightDefault;
//  }
//
//  return 0.0f;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the calculationg of the cell height for the message
// * cell
// *
// *  @param collectionView       collection view
// *  @param collectionViewLayout collection view layout
// *  @param indexPath            index
// *
// *  @return calculated height
// */
//
//- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
//                                       layout:
//                                           (JSQMessagesCollectionViewFlowLayout
//                                                *)collectionViewLayout
//    heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
//  /**
//   *  iOS7-style sender name labels
//   */
//  JSQMessage *currentMessage = [self.messages objectAtIndex:indexPath.item];
//
//#pragma mark current user
//  if ([[currentMessage senderId] isEqualToString:self.senderId]) {
//
//    if ([self isNeedOutgoingName] == NO) {
//      return 0.0f;
//    }
//
//    if (indexPath.item - 1 >= 0) {
//      JSQMessage *previousMessage =
//          [self.messages objectAtIndex:indexPath.item - 1];
//      if ([[previousMessage senderId]
//              isEqualToString:[currentMessage senderId]]) {
//        return 0.0f;
//      }
//    }
//  }
//
//#pragma mark other user
//  if (![[currentMessage senderId] isEqualToString:self.senderId]) {
//
//    if ([self isNeedIncommingName] == NO) {
//      return 0.0f;
//    }
//
//    if (indexPath.item - 1 >= 0) {
//      JSQMessage *previousMessage =
//          [self.messages objectAtIndex:indexPath.item - 1];
//      if ([[previousMessage senderId]
//              isEqualToString:[currentMessage senderId]]) {
//        return 0.0f;
//      }
//    }
//  }
//
//  return kJSQMessagesCollectionViewCellLabelHeightDefault;
//}
//
//- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
//                                 layout:(JSQMessagesCollectionViewFlowLayout *)
//                                            collectionViewLayout
//    heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
//  return 0.0f;
//}
//
//#pragma mark - JSQMessagesComposerTextViewPasteDelegate methods
//
//- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView
//   shouldPasteWithSender:(id)sender {
//  if ([UIPasteboard generalPasteboard].image) {
//    // If there's an image in the pasteboard, construct a media item with that
//    // image and `send` it.
//    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc]
//        initWithImage:[UIPasteboard generalPasteboard].image];
//    JSQMessage *message =
//        [[JSQMessage alloc] initWithSenderId:self.senderId
//                           senderDisplayName:self.senderDisplayName
//                                        date:[NSDate date]
//                                       media:item];
//    [self.messages addObject:message];
//    [self finishSendingMessage];
//    return NO;
//  }
//  return YES;
//}
//
//#pragma mark - avatar functional
//
///**
// ===========================================================================================
//                                    AVATAR FUNCTIONAL
// ===========================================================================================
// */
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the generate image from the user name
// *
// *  @param name user name
// *
// *  @return generated image
// */
//- (JSQMessagesAvatarImage *)getAvatarFromName:(NSString *_Nonnull)userID
//                                         name:(NSString *_Nonnull)name {
//
//  if ([self.namedAvatarDictionary.allKeys containsObject:userID]) {
//    JSQMessagesAvatarImage *cachedImage = self.namedAvatarDictionary[userID];
//    return cachedImage;
//  }
//
//  JSQMessagesAvatarImage *avatar;
//  NSString *firstLetterName;
//  NSArray<NSString *> *nameArray = [name componentsSeparatedByString:@" "];
//  for (NSString *value in nameArray) {
//    if (value.length > 0) {
//      if (firstLetterName == nil) {
//        firstLetterName = @"";
//      }
//      firstLetterName = [NSString stringWithFormat:@"%@%c", firstLetterName,
//                                                   [value characterAtIndex:0]];
//    }
//  }
//
//  if (firstLetterName == nil) {
//    firstLetterName = @"NA";
//  }
//
//  avatar = [JSQMessagesAvatarImageFactory
//      avatarImageWithUserInitials:firstLetterName.uppercaseString
//                  backgroundColor:[UIColor jsq_messageBubbleBlueColor]
//                        textColor:[UIColor whiteColor]
//                             font:[UIFont boldSystemFontOfSize:18]
//                         diameter:[self getAvatarSize]];
//
//  if (avatar) {
//    [self.namedAvatarDictionary setObject:avatar forKey:userID];
//  }
//
//  return avatar;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the generate avatar image form image name
// *
// *  @param imageName image name
// *
// *  @return generated image
// */
//- (JSQMessagesAvatarImage *)getAvatarFromImage:(NSString *_Nonnull)userID
//                                     imageName:(NSString *_Nonnull)imageName {
//
//  if ([self.avatarDict.allKeys containsObject:userID]) {
//    return self.avatarDict[userID];
//  }
//
//  @try {
//    JSQMessagesAvatarImage *outgoingAvatar = [JSQMessagesAvatarImageFactory
//        avatarImageWithImage:[UIImage imageNamed:imageName]
//                    diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
//
//    if (outgoingAvatar) {
//      [self.avatarDict setObject:outgoingAvatar forKey:userID];
//    }
//
//    return outgoingAvatar;
//  } @catch (NSException *exception) {
//    NSLog(@"%@ : %@", self, exception);
//  }
//  return nil;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the generate avatar image form image name
// *
// *  @param imageName image name
// *
// *  @return generated image
// */
//- (JSQMessagesAvatarImage *_Nonnull)
//getAvatarFromUIImage:(NSString *_Nonnull)userID
//               image:(UIImage *_Nullable)image {
//
//  if ([self.avatarDict.allKeys containsObject:userID]) {
//    return self.avatarDict[userID];
//  }
//
//  @try {
//    JSQMessagesAvatarImage *outgoingAvatar = [JSQMessagesAvatarImageFactory
//        avatarImageWithImage:image
//                    diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
//
//    if (outgoingAvatar) {
//      [self.avatarDict setObject:outgoingAvatar forKey:userID];
//    }
//
//    return outgoingAvatar;
//  } @catch (NSException *exception) {
//    NSLog(@"%@ : %@", self, exception);
//  }
//  return nil;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the avatar image
// *
// *  @param imageName user image name
// *  @param userName  user name
// *
// *  @return generated avatar
// */
//- (JSQMessagesAvatarImage *)getAvatar:(NSString *)userID
//                            imageName:(NSString *)imageName
//                             userName:(NSString *)userName {
//
//  JSQMessagesAvatarImage *avatar =
//      [self getAvatarFromImage:userID imageName:imageName];
//
//  if (avatar == nil) {
//    avatar = [self getAvatarFromName:userID name:userName];
//  }
//
//  return avatar;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the avatar image
// *
// *  @param imageName user image name
// *  @param userName  user name
// *
// *  @return generated avatar
// */
//- (JSQMessagesAvatarImage *_Nonnull)getAvatar:(NSString *_Nonnull)userID
//                                        image:(UIImage *_Nullable)imageName
//                                     userName:(NSString *_Nullable)userName {
//
//  JSQMessagesAvatarImage *avatar =
//      [self getAvatarFromUIImage:userID image:imageName];
//
//  if (avatar == nil) {
//    avatar = [self getAvatarFromName:userID name:userName];
//  }
//
//  return avatar;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the avatar by user ID and name
// *
// *  @param userID   user ID
// *  @param userName user name
// *
// *  @return avatar
// */
//- (JSQMessagesAvatarImage *_Nonnull)getAvatarByID:(NSString *_Nonnull)userID
//                                         userName:(NSString *_Nonnull)userName {
//  if ([self.avatarDict.allKeys containsObject:userID]) {
//    JSQMessagesAvatarImage *avatar = self.avatarDict[userID];
//    if (avatar != nil) {
//      return avatar;
//    }
//  }
//
//  JSQMessagesAvatarImage *avatar =
//      [self getAvatarFromName:userID name:userName];
//
//  return avatar;
//}
//
//#pragma mark add avatar function
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the add image by image name (image should be in
// * bundle)
// *
// *  @param userID    user id
// *  @param imageName image name
// *  @param userName  user name (using for generating image from name if image
// * not exists in bundle)
// */
//- (void)addAvatarFromImageName:(NSString *_Nonnull)userID
//                     imageName:(NSString *_Nullable)imageName
//                      userName:(NSString *_Nonnull)userName {
//  [self getAvatar:userID imageName:imageName userName:userName];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the add image by image name (image should be in
// * bundle)
// *
// *  @param userID    user id
// *  @param image image
// *  @param userName  user name (using for generating image from name if image
// * not exists in bundle)
// */
//- (void)addAvatarFromUIImage:(NSString *_Nonnull)userID
//                       image:(UIImage *_Nullable)image
//                    userName:(NSString *_Nonnull)userName {
//  [self getAvatar:userID image:image userName:userName];
//}
//
//#pragma mark - message functional
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
//- (void)addMessage:(NSString *)userID
//       displayName:(NSString *)displayName
//              date:(NSDate *)date
//           message:(NSString *)message {
//  JSQMessage *messageObject = [[JSQMessage alloc] initWithSenderId:userID
//                                                 senderDisplayName:displayName
//                                                              date:date
//                                                              text:message];
//  [self.messages addObject:messageObject];
//  [self.collectionView reloadData];
//  if (self.automaticallyScrollsToMostRecentMessage) {
//    [self scrollToBottomAnimated:YES];
//  }
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to setting of the messages history
// *
// *  @param messages messages
// */
//- (void)setMessagesHistory:(NSMutableArray<JSQMessage *> *_Nonnull)messages {
//  [self.messages removeAllObjects];
//  [self.messages addObjectsFromArray:messages];
//  [self.collectionView reloadData];
//  if (self.automaticallyScrollsToMostRecentMessage) {
//    [self scrollToBottomAnimated:YES];
//  }
//}
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
//- (void)addMenuItem:(NSString *_Nonnull)imageName {
//  @try {
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
//        initWithImage:[UIImage imageNamed:imageName]
//                style:UIBarButtonItemStylePlain
//               target:self
//               action:@selector(onAdditionalMenuPressed)];
//  } @catch (NSException *exception) {
//    NSLog(@"%@ : %@", self, exception);
//  }
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the action when additional menu pressed
// *  (can be overriden)
// */
//- (void)onAdditionalMenuPressed {
//}
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
//- (NSString *_Nonnull)getDialogTitle {
//  return @"Media messages";
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the attachment dialog items
// *
// *  @return dialog items
// */
//- (NSArray<NSString *> *_Nonnull)getDialogButtons {
//  return @[ @"Send photo", @"Send location", @"Send video" ];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to action when button dialog pressed
// *
// *  @param index button index
// */
//- (void)onDialogButtonPressed:(int)index {
//  NSLog(@"%@ : %@", self, @"Button dialog pressed");
//}
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
//                    color:(HeaderColor)headerColor {
//  [self refreshHeaderView:headerColor text:text hiden:NO];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the clearing of the header view
// */
//- (void)clearHeaderView {
//  self.viewHeader.hidden = YES;
//  if ([self isNeedCustomNavigationBar] == YES) {
//    self.topContentAdditionalInset = [self getCustomNavigationViewHeight];
//  } else {
//    self.topContentAdditionalInset = 0;
//  }
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the refreshing of the header view
// */
//- (void)refreshHeaderView:(HeaderColor)headerColor
//                     text:(NSString *)labelText
//                    hiden:(BOOL)isHiden {
//
//  // Initialize label (for group chat)
//  CGRect labelFrame = CGRectMake(8, 8, self.view.frame.size.width - 16, 0);
//  if (self.labelAdditional == nil) {
//    // If label not exist, lets create it
//    self.labelAdditional = [[UILabel alloc] initWithFrame:labelFrame];
//    self.labelAdditional.numberOfLines = [self getAdditionalHeaderLines];
//    self.labelAdditional.font = [UIFont systemFontOfSize:15];
//    self.labelAdditional.lineBreakMode = NSLineBreakByTruncatingTail;
//  } else {
//    // If label exist just reload the frame for the label
//    self.labelAdditional.frame = labelFrame;
//  }
//  // Set label text
//  self.labelAdditional.text = labelText;
//  // Set label to size to fit
//  [self.labelAdditional sizeToFit];
//
//  // Define additional header shift from top
//  CGFloat heighBar = 64.0f;
//  // Shift from navigation bar
//  if (self.navigationController && self.navigationController.navigationBar) {
//    heighBar = @(self.navigationController.navigationBar.frame.origin.y +
//                 self.navigationController.navigationBar.frame.size.height)
//                   .floatValue;
//    // If navigation bar is transluent than set shift value to 0.0
//    if (self.navigationController.navigationBar.translucent == NO) {
//      heighBar = 0.0f;
//    }
//
//    // Set shift from custom navigation bar
//    if ([self isNeedCustomNavigationBar] == YES) {
//      // Make frame
//      CGRect frame = CGRectMake(0, 0, [self getScreenWitdh],
//                                [self getCustomNavigationViewHeight]);
//      // Get navigation bar from overriden method
//      if (!self.customNavigationView) {
//        self.customNavigationView = [self getCustomNavigationBar];
//      }
//      // Set frame to navigation bar
//      self.customNavigationView.frame = frame;
//      // Add custom navigation bar to main view if it not exist
//      if (![self.view.subviews containsObject:self.customNavigationView]) {
//        [self.view addSubview:self.customNavigationView];
//      }
//      // Calculate shift from custom navigation bar
//      heighBar = @(frame.origin.y + frame.size.height).floatValue;
//    }
//  }
//
//  // Create additional header frame
//  CGRect headerFrame = CGRectMake(0, heighBar, labelFrame.size.width + 16,
//                                  self.labelAdditional.frame.size.height + 16);
//  // Create blured view frame
//  CGRect bluredFrame = CGRectMake(0, 0, 1000, 1000);
//
//  // Initialize header view
//  if (self.viewHeader == nil) {
//    self.viewHeader = [[UIView alloc] initWithFrame:headerFrame];
//    self.viewHeader.clipsToBounds = YES;
//  } else {
//    // IF header view is exists, just set the frame
//    self.viewHeader.frame = headerFrame;
//  }
//
//  // Create blured view if it not exist
//  if (self.viewBlured == nil) {
//    self.viewBlured = [[UIView alloc] initWithFrame:bluredFrame];
//    UIBlurEffect *blurEffect =
//        [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *blurEffectView =
//        [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    blurEffectView.frame = self.viewBlured.bounds;
//    blurEffectView.autoresizingMask =
//        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.viewBlured addSubview:blurEffectView];
//  }
//
//  // Add blured view as subview to additional header view
//  if (![self.viewHeader.subviews containsObject:self.viewBlured]) {
//    [self.viewHeader addSubview:self.viewBlured];
//  }
//
//  // Add label to additional header view
//  if (![self.viewHeader.subviews containsObject:self.labelAdditional]) {
//    [self.viewHeader addSubview:self.labelAdditional];
//  }
//
//  // Setting up the colors
//  UIColor *textColor;
//  UIColor *backgroundColor;
//
//  switch (headerColor) {
//  case BLACK:
//    textColor = [UIColor whiteColor];
//    backgroundColor = K_COLOR_BLACK_BACKGROUND;
//    break;
//  case WHITE:
//    textColor = [UIColor blackColor];
//    backgroundColor = K_COLOR_LIGHT_BACKGROUND;
//    break;
//  default:
//    textColor = [UIColor blackColor];
//    backgroundColor = K_COLOR_LIGHT_BACKGROUND;
//    break;
//  }
//
//  self.labelAdditional.textColor = textColor;
//  self.viewHeader.backgroundColor = backgroundColor;
//
//  // Add additional header view to main view if it not exist
//  if (![self.view.subviews containsObject:self.viewHeader]) {
//    [self.view addSubview:self.viewHeader];
//  }
//
//  // Set hiden to addtional header view
//  self.viewHeader.hidden = isHiden;
//  // Reflow layout
//  [self.view layoutIfNeeded];
//
//  CGFloat additionalHeigh =
//      @(self.viewHeader.frame.size.height + self.viewHeader.frame.origin.y)
//          .floatValue;
//  self.topContentAdditionalInset = additionalHeigh;
//}
//
//#pragma mark - methods which must/should/can be overriden
//
///**
// ===========================================================================================
//                                OVERRIDEN FUNCTIONAL
// ===========================================================================================
// */
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the additional header lines
// *
// *  @return additional header text lines
// */
//- (int)getAdditionalHeaderLines {
//  return 4;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting title for the controller
// *  (can be overriden)
// *
// *  @return title value
// */
//- (NSString *_Nonnull)getTitle {
//  return @"Controller";
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the showing of the attachment button
// *  (can be overriden)
// *
// *  @return is need show attachment button
// */
//- (BOOL)isNeedAttachmentButton {
//  return NO;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the showing of the avtars on the collection view
// *  (can be overriden)
// *
// *  @return is need avatar value
// */
//- (BOOL)isNeedAvatars {
//  return YES;
//}
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
//- (BOOL)isNeedOutgoingName {
//  return NO;
//}
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
//- (BOOL)isNeedIncommingName {
//  return YES;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the defining of the timestamp frequency
// *  (can be overriden)
// *
// *  @return timestamp frequency
// */
//- (int)getTimestampFrequency {
//  return 3;
//}
//
//#pragma mark bubbles settings
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the self bubble color
// *  (can be overriden)
// *
// *  @return self bubble color
// */
//- (UIColor *_Nonnull)getSelfBubbleColor {
//  return [UIColor jsq_messageBubbleLightGrayColor];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the self bubble text color
// *
// *  @return self bubble text color
// */
//- (UIColor *_Nonnull)getSelfBubbleTextColor {
//  return [UIColor blackColor];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the other bubble color
// *  (can be overriden)
// *
// *  @return self bubble color
// */
//- (UIColor *_Nonnull)getOtherBubbleColor {
//  return [UIColor jsq_messageBubbleBlueColor];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the other bubble text color
// *
// *  @return other buble text color
// */
//- (UIColor *_Nonnull)getOtherBubbleTextColor {
//  return [UIColor whiteColor];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which prpvide to getting of the cell font
// *
// *  @return cells font
// */
//- (UIFont *_Nonnull)getCellsFont {
//  return [UIFont systemFontOfSize:15];
//}
//
//#pragma mark avatar settings
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the avatar size\
// *  (can be overriden)
// *
// *  @return avatar size
// */
//- (int)getAvatarSize {
//  return 33;
//}
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
//- (BOOL)isNeedCustomNavigationBar {
//  return NO;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to hiding of the status bar
// *
// *  @return definition
// */
//- (BOOL)prefersStatusBarHidden {
//  return [self isNeedCustomNavigationBar];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method whihc provide to getting of the custom navigation bar view
// *  (must be overriden when [self isNeedCustomNavigationBar] == YES)
// *
// *  @return custom navigation view
// */
//- (UIView *_Nonnull)getCustomNavigationBar {
//  [NSException
//       raise:@"Method overriden exception"
//      format:@"The method \"getCustomNavigationBar\" should be overriden"];
//  return nil;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the custom navigation view heigh
// *
// *  @return heigh value
// */
//- (CGFloat)getCustomNavigationViewHeight {
//  return 63.0f;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the iOS screen size
// *
// *  @return current screen size
// */
//- (CGRect)getScreenSize {
//  CGRect screenRect = [[UIScreen mainScreen] bounds];
//  return screenRect;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the screen height
// *
// *  @return current screen height
// */
//- (CGFloat)getScreenHeight {
//  CGRect size = [self getScreenSize];
//  return size.size.height;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the screen width
// *
// *  @return current screen width
// */
//- (CGFloat)getScreenWitdh {
//  CGRect size = [self getScreenSize];
//  return size.size.width;
//}
//
//#pragma mark must be overriden
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the current user id
// *  (must be overriden)
// *
// *  @return user ID value
// */
//- (NSString *_Nonnull)getUserID {
//  [NSException raise:@"Method overriden exception"
//              format:@"The method \"getUserID\" should be overriden"];
//  return nil;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the getting of the user display name
// *  (must be overriden)
// *
// *  @return user display name
// */
//- (NSString *_Nonnull)getUserDisplayName {
//  [NSException raise:@"Method overriden exception"
//              format:@"The method \"getUserDisplayName\" should be overriden"];
//  return nil;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the action after message sending
// *  (must be overriden)
// *
// *  @param message message object
// */
//- (void)onMessageSended:(JSQMessage *_Nonnull)message {
//  [NSException raise:@"Method overriden exception"
//              format:@"The method \"onMessageSended\" should be overriden"];
//}
//
//#pragma mark -  getters
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide to getting of the messages count value
// *
// *  @return message count
// */
//- (int)getMessageCount {
//  return @(self.messages.count).intValue;
//}
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
//- (void)setChatTitle:(NSString *_Nonnull)titleText {
//  self.title = titleText;
//}
//
//#pragma mark - methods from BaseViewController
//
///**
// *  Method which provide the show view controller modally by it ID
// *
// *  @param controllerID current controller ID
// */
//- (void)navigateModalByControllerId:(NSString *)controllerID {
//  [self disableInteraction];
//  UIViewController *controller =
//      [[self storyboard] instantiateViewControllerWithIdentifier:controllerID];
//  //  controller.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//  if (!controller.navigationController) {
//    UINavigationController *navigationController =
//        [[UINavigationController alloc] initWithRootViewController:controller];
//    [navigationController setNavigationBarHidden:YES];
//    [self presentViewController:navigationController
//                       animated:YES
//                     completion:nil];
//  } else {
//    [self presentViewController:controller animated:YES completion:nil];
//  }
//  [NSTimer scheduledTimerWithTimeInterval:2
//                                   target:self
//                                 selector:@selector(enableUserInteraction)
//                                 userInfo:nil
//                                  repeats:NO];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method which provide the disabling of the user interaction
// */
//- (void)disableInteraction {
//  self.view.userInteractionEnabled = NO;
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  method which provide the enabling of the user interaction
// */
//- (void)enableUserInteraction {
//  self.view.userInteractionEnabled = YES;
//}
//
///**
// * Method which provide the close of the current view controller
// */
//- (void)closeController {
//  if (self.navigationController) {
//    [self.navigationController popViewControllerAnimated:YES];
//  }
//  [self closePopController];
//}
//
///**
// *  @author Dmitriy Lernatovich
// *
// *  Method whihc provide to closing of the popup navigation controller
// */
//- (void)closePopController {
//  [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//@end
