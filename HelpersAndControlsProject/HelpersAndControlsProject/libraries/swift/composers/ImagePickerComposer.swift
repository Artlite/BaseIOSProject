//
//  ImagePickerComposer.swift
//  CameraProject
//
//  Created by Dmitry Lernatovich on 03.07.16.
//  Copyright © 2016 Dmitry Lernatovich. All rights reserved.
//

import UIKit

public class ImagePickerComposer: NSObject,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    // Image Picker callback
    public typealias OnImagePickerCallback = (_ image: UIImage?) -> Void;
    
    // Image picker
    public let imagePicker = UIImagePickerController()
    
    // Controller
    weak var controller: UIViewController?;
    // Callback
    var callback: OnImagePickerCallback?;
    
    /**
     Contructor which provide the creating composer with controller to pick
     
     - parameter controller: controller to pick
     
     - returns: composer object
     */
    init(controller: UIViewController?) {
        super.init();
        self.controller = controller;
        self.imagePicker.delegate = self;
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    /**
     Method which provide the picking cancelling
     
     - parameter picker: image picker
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.callback?(pickedImage);
        }
        self.controller?.dismiss(animated: true, completion: nil)
    }
    
    /**
     Method which provide the picking cancelling
     
     - parameter picker: image picker
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.controller?.dismiss(animated: true, completion: nil)
    }
    
    /**
     Method which provide the image picking
     
     - parameter type:     source type (gallery, camera)
     - parameter callback: image picker callback
     */
    public final func pick(imageFrom type: UIImagePickerControllerSourceType,
                           callback: OnImagePickerCallback?) {
        self.pick(imageFrom: type, allowEdit: false, callback: callback);
    }
    
    /**
     Method which provide the image picking
     
     - parameter type:     source type (gallery, camera)
     - parameter callback: image picker callback
     */
    public final func pick(imageFrom type: UIImagePickerControllerSourceType,
                           allowEdit isAbleEdit:Bool,
                           callback: OnImagePickerCallback?) {
        self.callback = callback;
        imagePicker.allowsEditing = isAbleEdit;
        imagePicker.sourceType = type;
        self.controller?.present(imagePicker, animated: true, completion: nil);
    }
}
