////
////  BaseJSQController+Avatars.swift
////  EsteeHR
////
////  Created by Dmitry Lernatovich on 20.04.16.
////  Copyright © 2016 Magnet. All rights reserved.
////
//
//import ChatKit
//extension BaseJSQController {
//    
//    //MARK: Avatar functional
//    /**
//     Method which provide ot getting of the avatar image
//     
//     - parameter ID:   current ID
//     - parameter name: current name
//     
//     - returns: image value
//     */
//    final func getAvatar(byID ID:String!, andName name:String!) -> JSQMessagesAvatarImage? {
//        var avatar:JSQMessagesAvatarImage? = self.getAvatar(byID: ID);
//        if(avatar == nil){
//            if(self.nameAvatarDictionary.keys.contains(name) == false){
//                self.requestAvatar(ID);
//            }
//            avatar = self.getAvatar(byName: name);
//        }
//        return avatar;
//    }
//    
//    /**
//     Method which provide to getting of the avatr by user ID
//     
//     - parameter byID: user ID
//     */
//    final func getAvatar(byID userID:String!) -> JSQMessagesAvatarImage?{
//        let avatar:JSQMessagesAvatarImage? = self.avatarDict[userID];
//        return avatar;
//    }
//    
//    /**
//     Method which provide to getting of the user avatar by name
//     
//     - parameter userName: user name
//     
//     - returns: avatar image
//     */
//    final func getAvatar(byName userName:String!) -> JSQMessagesAvatarImage? {
//        var avatar:JSQMessagesAvatarImage? = self.nameAvatarDictionary[userName];
//        if(avatar != nil){
//            return avatar;
//        }
//        
//        var letters:String! = "";
//        let namesArray:[String]! = userName.componentsSeparatedByString(" ");
//        for name in namesArray {
//            letters.appendContentsOf(StringHelper.trimToIndex(name, index: 1).uppercaseString);
//        }
//        
//        if (StringHelper.isEmptyString(letters) == true) {
//            letters = "NA";
//        }
//        
//        avatar = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(letters, backgroundColor: self.getNamedImageColor(), textColor: self.getNamedTextColor(), font: self.getNamedFont(), diameter: UInt(self.getAvatarSize()));
//        
//        if(avatar != nil){
//            self.nameAvatarDictionary[userName] = avatar;
//        }
//        return avatar;
//    }
//    
//    /**
//     Method which provide the avatar adding
//     
//     - parameter userID: user id
//     - parameter image:  image
//     */
//    final func addAvatar(userID:String?, image:UIImage?) {
//        if((userID == nil) || (image == nil)){
//            return;
//        }
//        let avatar:JSQMessagesAvatarImage! = JSQMessagesAvatarImageFactory.avatarImageWithImage(image!, diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault));
//        
//        if(avatar != nil){
//            self.avatarDict[userID!] = avatar;
//        }
////        self.collectionView.reloadData();
//    }
//    
//}
