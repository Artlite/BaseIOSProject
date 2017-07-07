////
////  BaseJSQController+Messages.swift
////  EsteeHR
////
////  Created by Dmitry Lernatovich on 20.04.16.
////  Copyright © 2016 Magnet. All rights reserved.
////
//
//import ChatKit
//extension BaseJSQController{
//    
//    /**
//     Method which provide the adding message functional
//     
//     - parameter userID:      user ID
//     - parameter displayName: display name
//     - parameter date:        data
//     - parameter message:     message
//     */
//    final func add(messageWith userID:String?, displayName:String?, date:NSDate?, message:String?){
//        if((userID == nil) || (displayName == nil) || (date == nil) || (message == nil)){
//            return;
//        }
//        let message:JSQMessage! = JSQMessage(senderId: userID!, senderDisplayName: displayName!, date: date!, text: message!);
//        self.messages.append(message);
//        self.collectionView.reloadData();
//        if (self.automaticallyScrollsToMostRecentMessage == true) {
//            self.scrollToBottomAnimated(true);
//        }
//    }
//    
//    /**
//     Method which provide the adding message functional
//     
//     - parameter userID:      user ID
//     - parameter displayName: display name
//     - parameter date:        data
//     - parameter message:     message
//     */
//    final func create(messageWith userID:String?, displayName:String?, date:NSDate?, message:String?) -> JSQMessage?{
//        if((userID == nil) || (displayName == nil) || (date == nil) || (message == nil)){
//            return nil;
//        }
//        let message:JSQMessage! = JSQMessage(senderId: userID!, senderDisplayName: displayName!, date: date!, text: message!);
//        return message;
//    }
//    
//    /**
//     Method which provide to messages setting
//     
//     - parameter messageObjects: messages
//     */
//    final func set(messages messageObjects:[JSQMessage]?){
//        if(messageObjects == nil){
//            return;
//        }
//        self.messages.removeAll();
//        self.messages.appendContentsOf(messageObjects!);
//        self.collectionView.reloadData();
//        if (self.automaticallyScrollsToMostRecentMessage == true) {
//            self.scrollToBottomAnimated(true);
//        }
//    }
//    
//    /**
//     Method which provide the message sended functional
//     
//     - parameter text: message sended
//     */
//    func onMessageSended(messageText text:String?){
//        
//    }
//    
//}
