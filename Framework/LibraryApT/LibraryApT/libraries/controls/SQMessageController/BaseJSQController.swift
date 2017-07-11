////
////  BaseJSQController.swift
////  EsteeHR
////
////  Created by Dmitry Lernatovich on 20.04.16.
////  Copyright © 2016 Magnet. All rights reserved.
////
//
//import UIKit
//import ChatKit
//
//class BaseJSQController: JSQMessagesViewController, UIActionSheetDelegate,
//JSQMessagesComposerTextViewPasteDelegate {
//    
//    var messages:[JSQMessage]! = [];
//    var incommingBubble:JSQMessagesBubbleImage?;
//    var outgoingBubble:JSQMessagesBubbleImage?;
//    var avatarDict:Dictionary<String, JSQMessagesAvatarImage>! = [:];
//    var nameAvatarDictionary:Dictionary<String, JSQMessagesAvatarImage>! = [:];
//    
//    override func viewDidLoad() {
//        super.viewDidLoad();
//        self.registerForNotifications();
//        self.onInitializeInterface();
//    }
//    
//    deinit{
//        NotificationsHelper.removeFromNotifications(owner: self);
//    }
//    
//    /**
//     Method which provide the registration for notifications
//     */
//    func registerForNotifications(){
//        
//    }
//    
//    //MARK: Initialize functional
//    /**
//     Method which provide the bubble initialization
//     */
//    private func onInitializeInterface(){
//        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGRectMake(0, 0, self.getAvatarSize(), self.getAvatarSize()).size;
//        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGRectMake(0, 0, self.getAvatarSize(), self.getAvatarSize()).size;
//        self.showLoadEarlierMessagesHeader = false;
//        self.collectionView.collectionViewLayout.messageBubbleFont = self.getBubbleFont();
//        if(self.isNeedAttachmentButton() == false){
//            self.inputToolbar.contentView.leftBarButtonItem = nil;
//        }
//        if(self.isNeedAvatar() == false){
//            self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
//            self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
//        }
//        //Set up bubbles
//        let bubbleFactory:JSQMessagesBubbleImageFactory = JSQMessagesBubbleImageFactory();
//        self.outgoingBubble = bubbleFactory.outgoingMessagesBubbleImageWithColor(self.getSelfBubbleColor());
//        self.incommingBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(self.getOtherBubbleColor());
//    }
//    
//    //MARK: JSQMessagesViewController delegate
//    /**
//     Method which provide to getting message item by index
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index path
//     
//     - returns: data value
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
//        return self.messages[indexPath.item];
//    }
//    
//    /**
//     Method which provide the message removing from the table view
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index path
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
//        self.messages.removeAtIndex(indexPath.item);
//    }
//    
//    /**
//     Method which provide to getting of the bubble image by index
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index
//     
//     - returns: bubble image
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
//        let message:JSQMessage! = self.messages[indexPath.item];
//        let senderID:String? = message.senderId;
//        
//        if (StringHelper.compareString(senderID, another: self.senderId) == true) {
//            return self.outgoingBubble;
//        }
//        
//        return self.incommingBubble;
//    }
//    
//    /**
//     Method which provide to getting of the avatar by user ID or name
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index path
//     
//     - returns: avatar image
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
//        
//        if(self.isNeedAvatar() == false){
//            return nil;
//        }
//        
//        let message:JSQMessage! = self.messages[indexPath.item];
//        let userID:String! = message.senderId;
//        let userDisplayName:String! = message.senderDisplayName;
//        let avatar:JSQMessagesAvatarImage! = self.getAvatar(byID: userID, andName: userDisplayName);
//        return avatar;
//    }
//    
//    /**
//     Method which provide the top attributed text
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index
//     
//     - returns: attributed text
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
//        if((indexPath.item % self.getTimestampFrequency()) == 0){
//            let message:JSQMessage! = self.messages[indexPath.item];
//            return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date);
//        }
//        return nil;
//    }
//    
//    /**
//     Method which provide to getting of the user name
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index path
//     
//     - returns: attributed text
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
//        
//        let message:JSQMessage! = self.messages[indexPath.item];
//        
//        //CURRENT USER
//        if(StringHelper.compareString(message.senderId, another: self.senderId) == true){
//            if(self.isNeedOutgoingName() == false){
//                return nil;
//            }
//            
//            if(indexPath.item - 1 >= 0){
//                let previousMessage:JSQMessage! = self.messages[indexPath.item - 1];
//                if(StringHelper.compareString(previousMessage.senderId, another: message.senderId) == true){
//                    return nil;
//                }
//            }
//        }
//        
//        //OTHER USER
//        if(StringHelper.compareString(message.senderId, another: self.senderId) == false){
//            if(self.isNeedIncommingName() == false){
//                return nil;
//            }
//            
//            if(indexPath.item - 1 >= 0){
//                let previousMessage:JSQMessage! = self.messages[indexPath.item - 1];
//                if(StringHelper.compareString(previousMessage.senderId, another: message.senderId) == true){
//                    return nil;
//                }
//            }
//        }
//        
//        /**
//         *  Don't specify attributes to use the defaults.
//         */
//        return NSAttributedString(string: message.senderDisplayName);
//    }
//    
//    /**
//     Method which provide the bottom text
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index path
//     
//     - returns: bottom text
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
//        return nil;
//    }
//    
//    //MARK: DataSource
//    /**
//     Method which provide to getting of the messages count
//     
//     - parameter collectionView: collection view
//     - parameter section:        section
//     
//     - returns: items count
//     */
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.messages.count;
//    }
//    
//    /**
//     Method which provide the cell customization
//     
//     - parameter collectionView: collection view
//     - parameter indexPath:      index path
//     
//     - returns: cell
//     */
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell:JSQMessagesCollectionViewCell! = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell;
//        let message:JSQMessage! = self.messages[indexPath.item];
//        if(message.isMediaMessage == false){
//            if(StringHelper.compareString(message.senderId, another: self.senderId) == true){
//                cell.textView.textColor = self.getSelfBubbleTextColor();
//            }else{
//                cell.textView.textColor = self.getOtherBubbleTextColor();
//            }
//            cell.textView.linkTextAttributes = [NSForegroundColorAttributeName:cell!.textView.textColor!,
//                                                NSUnderlineStyleAttributeName: (NSUnderlineStyle.StyleSingle.rawValue | NSUnderlineStyle.PatternSolid.rawValue)];
//        }
//        
//        return cell;
//    }
//    
//    //MARK: Cell label heigh
//    /**
//     Method which provide to getting height for the time label
//     
//     - parameter collectionView:       collection view
//     - parameter collectionViewLayout: collection layout
//     - parameter indexPath:            index path
//     
//     - returns: heigh value
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        if ((indexPath.item % self.getTimestampFrequency()) == 0) {
//            return kJSQMessagesCollectionViewCellLabelHeightDefault;
//        }
//        return 0.0;
//    }
//    
//    /**
//     Method which provide to getting of the current user name heigh
//     
//     - parameter collectionView:       collection view
//     - parameter collectionViewLayout: layout
//     - parameter indexPath:            index
//     
//     - returns: heigh
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        let message:JSQMessage! = self.messages[indexPath.item];
//        
//        //CURRENT USER
//        if(StringHelper.compareString(message.senderId, another: self.senderId) == true){
//            if(self.isNeedOutgoingName() == false){
//                return 0.0;
//            }
//            
//            if(indexPath.item - 1 >= 0){
//                let previousMessage:JSQMessage! = self.messages[indexPath.item - 1];
//                if(StringHelper.compareString(previousMessage.senderId, another: message.senderId) == true){
//                    return 0.0;
//                }
//            }
//        }
//        
//        //OTHER USER
//        if(StringHelper.compareString(message.senderId, another: self.senderId) == false){
//            if(self.isNeedIncommingName() == false){
//                return 0.0;
//            }
//            
//            if(indexPath.item - 1 >= 0){
//                let previousMessage:JSQMessage! = self.messages[indexPath.item - 1];
//                if(StringHelper.compareString(previousMessage.senderId, another: message.senderId) == true){
//                    return 0.0;
//                }
//            }
//        }
//        
//        return kJSQMessagesCollectionViewCellLabelHeightDefault;
//    }
//    
//    /**
//     Method which provide the getting heigh for the bottom layout
//     
//     - parameter collectionView:       collection view
//     - parameter collectionViewLayout: collection layout
//     - parameter indexPath:            index
//     
//     - returns: heigh
//     */
//    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        return 0.0;
//    }
//    
//    /**
//     Method which provide to sending the media message
//     
//     - parameter textView: textview
//     - parameter sender:   sender
//     
//     - returns: is media content
//     */
//    func composerTextView(textView: JSQMessagesComposerTextView!, shouldPasteWithSender sender: AnyObject!) -> Bool {
//        if (UIPasteboard.generalPasteboard().image != nil) {
//            let item:JSQPhotoMediaItem = JSQPhotoMediaItem(image: UIPasteboard.generalPasteboard().image);
//            let message:JSQMessage = JSQMessage(senderId: self.senderId, senderDisplayName: self.senderDisplayName, date:NSDate(timeIntervalSinceNow: 0), media: item);
//            self.messages.append(message);
//            self.finishSendingMessage();
//            return false;
//        }
//        return true;
//    }
//    
//    //MARK: Buttons methods
//    /**
//     Method which provide the action when user press the send message button
//     
//     - parameter button:            button
//     - parameter text:              message text
//     - parameter senderId:          sender ID
//     - parameter senderDisplayName: sender display name
//     - parameter date:              date of message
//     */
//    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
//        self.add(messageWith: senderId, displayName: senderDisplayName, date: date, message: text);
//        self.onMessageSended(messageText: text);
//        self.finishSendingMessageAnimated(true);
//    }
//    
//    /**
//     Method which provide the action when user press accessory button
//     MARK: Should be overriden
//     
//     - parameter sender: button
//     */
//    override func didPressAccessoryButton(sender: UIButton!) {
//        
//    }  
//}
