//
//  ImageOrNameView.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 20.04.16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

@IBDesignable
public class ImageOrNameView: UIView {

	private static let K_STRING_TO_REMOVE: String! = "!@#$%^&*()_+=-?></.,~`±}{][\"\'§";

	private static let K_DEFAULT_NAME: String! = "Not available";

	@IBInspectable var textColor: UIColor = UIColor.white {
		didSet {
			self.labelText.textColor = self.textColor;
		}
	}

	@IBInspectable var textBackground: UIColor = UIColor.blue {
		didSet {
			self.viewRound.backgroundColor = self.textBackground;
		}
	}

	@IBInspectable var textSize: CGFloat = 15 {
		didSet {
			self.labelText.font = UIFont.boldSystemFont(ofSize: self.textSize);
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
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
		self.onViewInitialize();
		self.onCreateView();
	}

	/**
	 Method which provide the view initializations
	 */
	private func onViewInitialize() {
		let view: UIView! = Bundle.main.loadNibNamed("ImageOrNameView",
			owner: self,
			options: nil)![0] as! UIView;
		view.frame = self.bounds;
		self.addSubview(view);
	}

	/**
	 Method which provide the actions when View is created
	 */
	private func onCreateView() {
		self.textBackground = ColorHelper.rgb(r: 0, g: 97, b: 152);
	}

	/**
	 Method whcih provide the setting of the image by URL and name

	 - parameter URL:      url
	 - parameter userName: user name
	 */
	public func set(imageURL URL: String?, userName: String?) {
		self.hideAllControls();
        self.set(userName: userName);
		self.set(imageURL: URL);
	}

	/**
	 Method which provide the setting data from image and user name

	 - parameter image:    image
	 - parameter userName: user name
	 */
	public func set(image: UIImage?, userName: String?) {
		self.hideAllControls();
		if (image == nil) {
            self.set(userName: userName);
		} else {
			self.imageAvatar.image = image;
			self.setImageVisibility(visible: true);
		}
	}

	/**
	 Method which provide to hiding of the all controls
	 */
	public func hideAllControls() {
		self.setRoundVisibility(visible: false);
		self.setImageVisibility(visible: false);
	}

	/**
	 Method which provide the setting of the user name

	 - parameter userName: user name
	 */
	private func set(userName: String?) {
		let charactersToRemove: CharacterSet = CharacterSet(charactersIn: ImageOrNameView.K_STRING_TO_REMOVE);
        let list:[String]? = userName?.components(separatedBy: charactersToRemove);
		var userNameCopy = list?.joined(separator: "");
		if (StringHelper.isEmpty(userNameCopy) == true) {
			userNameCopy = ImageOrNameView.K_DEFAULT_NAME;
		}
		var result: String = "";
		let namesArray: [String]! = userNameCopy!.components(separatedBy: " ");
		for name in namesArray {
			result.append(StringHelper.trim(toIndex: name, index: 1));
		}
		self.labelText.text = StringHelper.trim(toIndex: result.uppercased(),
			index: Int32(self.maxLength));
		self.setRoundVisibility(visible: true);
	}

	/**
	 Method which provide the setting of thge image URL inside the image

	 - parameter URL: image URL
	 */
	private func set(imageURL URL: String?) {
		self.imageAvatar.setURLImage(URL) { [weak self](result) in
			if (result == true) {
				self?.setImageVisibility(visible: true);
				self?.setRoundVisibility(visible: false);
			} else {
				self?.setImageVisibility(visible: false);
				self?.setRoundVisibility(visible: true);
			}
		}
	}

	/**
	 Method which provid the setting of the visibility for the RoundView

	 - author: Dmitriy Lernatovich

	 - parameter visible: is need visible
	 */
	private func setRoundVisibility(visible: Bool) {
		DispatchQueue.main.async(execute: { [weak self] in
			self?.viewRound.isHidden = !visible;
		});
	}

	/**
	 Method which provid the setting of the visibility for the ImageView

	 - author: Dmitriy Lernatovich

	 - parameter visible: is need visible
	 */
	private func setImageVisibility(visible: Bool) {
		DispatchQueue.main.async(execute: { [weak self] in
			self?.imageAvatar.isHidden = !visible;
		});
	}

}
