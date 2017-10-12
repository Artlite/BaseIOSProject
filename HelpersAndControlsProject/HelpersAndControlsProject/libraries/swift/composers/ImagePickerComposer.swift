//
//  ImagePickerComposer.swift
//  CameraProject
//
//  Created by Dmitry Lernatovich on 03.07.16.
//  Copyright © 2016 Dmitry Lernatovich. All rights reserved.
//

import UIKit

public class ImagePickerComposer: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	// Image Picker callback
	typealias OnImagePickerCallback = (_ image: UIImage?) -> Void;

	// Image picker
	let imagePicker = UIImagePickerController()

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
	 Method which provide the image picking

	 - parameter picker: image picking
	 - parameter info:   info from controller
	 */
	@nonobjc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			self.callback?(pickedImage);
		}
		self.controller?.dismiss(animated: true, completion: nil)
	}

	/**
	 Method which provide the picking cancelling

	 - parameter picker: image picker
	 */
	@nonobjc func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		self.controller?.dismiss(animated: true, completion: nil)
	}

	/**
	 Method which provide the image picking

	 - parameter type:     source type (gallery, camera)
	 - parameter callback: image picker callback
	 */
	final func pick(imageFrom type: UIImagePickerControllerSourceType, callback: OnImagePickerCallback?) {
		self.callback = callback;
		imagePicker.allowsEditing = false;
		imagePicker.sourceType = type;
		self.controller?.present(imagePicker, animated: true, completion: nil);
	}
}
