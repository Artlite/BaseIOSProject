//
//  ImageOrNameView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 20.04.16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

@IBDesignable
class ImageOrNameView: UIView {

	private static let K_STRING_TO_REMOVE: String! = "!@#$%^&*()_+=-?></.,~`±}{][\"\'§";

	private static let K_DEFAULT_NAME: String! = "Not available";

	@IBInspectable var textColor: UIColor = UIColor.whiteColor() {
		didSet {
			self.labelText.textColor = self.textColor;
		}
	}

	@IBInspectable var textBackground: UIColor = UIColor.blueColor() {
		didSet {
			self.viewRound.backgroundColor = self.textBackground;
		}
	}

	@IBInspectable var textSize: CGFloat = 15 {
		didSet {
			self.labelText.font = UIFont.boldSystemFontOfSize(self.textSize);
		}
	}

	@IBInspectable var maxLength: Int = 2;

	@IBOutlet weak var viewRound: RoundView!
	@IBOutlet weak var imageAvatar: RoundImageView!
	@IBOutlet weak var labelText: UILabel!
	/**
	 Constructor which provide the initialization from frame

	 - parameter frame: frame
	 */
	override init(frame: CGRect) {
		super.init(frame: frame);
		self.onViewInitialize();
		self.onCreateView();
	}

	/**
	 Constructor which provide the initialization from coder

	 - parameter aDecoder: coder
	 */
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
		self.onViewInitialize();
		self.onCreateView();
	}

	/**
	 Method which provide the view initializations
	 */
	private func onViewInitialize() {
		let view: UIView! = NSBundle.mainBundle().loadNibNamed("ImageOrNameView",
			owner: self,
			options: nil)![0] as! UIView;
		view.frame = self.bounds;
		self.addSubview(view);
	}

	/**
	 Method which provide the actions when View is created
	 */
	func onCreateView() {
		self.textBackground = ColorHelper.rgb(r: 0, g: 97, b: 152);
	}

	/**
	 Method whcih provide the setting of the image by URL and name

	 - parameter URL:      url
	 - parameter userName: user name
	 */
	internal func set(imageURL URL: String?, userName: String?) {
		self.hideAllControls();
		self.set(userName);
		self.set(imageURL: URL);
	}

	/**
	 Method which provide the setting data from image and user name

	 - parameter image:    image
	 - parameter userName: user name
	 */
	internal func set(image image: UIImage?, userName: String?) {
		self.hideAllControls();
		if (image == nil) {
			self.set(userName);
		} else {
			self.imageAvatar.image = image;
			self.setImageVisibility(true);
		}
	}

	/**
	 Method which provide to hiding of the all controls
	 */
	internal func hideAllControls() {
		self.setRoundVisibility(false);
		self.setImageVisibility(false);
	}

	/**
	 Method which provide the setting of the user name

	 - parameter userName: user name
	 */
	private func set(userName: String?) {
		let charactersToRemove: NSCharacterSet = NSCharacterSet(charactersInString: ImageOrNameView.K_STRING_TO_REMOVE);
		var userNameCopy = (userName?.componentsSeparatedByCharactersInSet(charactersToRemove))?.joinWithSeparator("");
		if (StringHelper.isEmptyString(userNameCopy) == true) {
			userNameCopy = ImageOrNameView.K_DEFAULT_NAME;
		}
		var result: String = "";
		let namesArray: [String]! = userNameCopy!.componentsSeparatedByString(" ");
		for name in namesArray {
			result.appendContentsOf(StringHelper.trimToIndex(name, index: 1));
		}
		self.labelText.text = StringHelper.trimToIndex(result.uppercaseString,
			index: Int32(self.maxLength));
		self.setRoundVisibility(true);
	}

	/**
	 Method which provide the setting of thge image URL inside the image

	 - parameter URL: image URL
	 */
	private func set(imageURL URL: String?) {
		self.imageAvatar.setURLImage(URL) { [weak self](result) in
			if (result == true) {
				self?.setImageVisibility(true);
				self?.setRoundVisibility(false);
			} else {
				self?.setImageVisibility(false);
				self?.setRoundVisibility(true);
			}
		}
	}

	/**
	 Method which provid the setting of the visibility for the RoundView

	 - author: Dmitriy Lernatovich

	 - parameter visible: is need visible
	 */
	private func setRoundVisibility(visible: Bool) {
		dispatch_async(dispatch_get_main_queue(), { [weak self] in
			self?.viewRound.hidden = !visible;
		});
	}

	/**
	 Method which provid the setting of the visibility for the ImageView

	 - author: Dmitriy Lernatovich

	 - parameter visible: is need visible
	 */
	private func setImageVisibility(visible: Bool) {
		dispatch_async(dispatch_get_main_queue(), { [weak self] in
			self?.imageAvatar.hidden = !visible;
		});
	}

}
