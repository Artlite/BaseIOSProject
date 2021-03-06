import Foundation
import UIKit

public class DatePickerDialog: UIView { 
	
	public typealias DatePickerCallback = (_ date: NSDate?) -> Void
	
	/* Consts */	
	private let kDatePickerDialogDefaultButtonHeight: CGFloat = 50
	private let kDatePickerDialogDefaultButtonSpacerHeight: CGFloat = 1
	private let kDatePickerDialogCornerRadius: CGFloat = 7
	private let kDatePickerDialogDoneButtonTag: Int = 1
	
	/* Views */	
	private var dialogView: UIView!
	private var titleLabel: UILabel!
	private var datePicker: UIDatePicker!
	private var cancelButton: UIButton!
	private var doneButton: UIButton!
	
	/* Vars */	
	private var defaultDate: NSDate?
	private var datePickerMode: UIDatePickerMode?
	private var callback: DatePickerCallback?
	
	
	/* Overrides */	
	public init() {
        //CGRectMake(0, 0, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
		super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)))
		setupView() 
	} 
	
	required public init(coder aDecoder: NSCoder) { 
		fatalError("init(coder:) has not been implemented") 
	} 
	
	private func setupView() {
		self.dialogView = createContainerView() 
		
		self.dialogView!.layer.shouldRasterize = true
		self.dialogView!.layer.rasterizationScale = UIScreen.main.scale
		
		self.layer.shouldRasterize = true
		self.layer.rasterizationScale = UIScreen.main.scale
		
		self.dialogView!.layer.opacity = 0.5
		self.dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1) 
		
		self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

		self.doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
		self.cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 17);
		self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17);
		
		self.addSubview(self.dialogView!) 
	} 
	
	/* Handle device orientation changes */	
	func deviceOrientationDidChange(notification: NSNotification) {
		
        //CGRectMake(0, 0, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
		self.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
		let screenSize = countScreenSize() 
//		let dialogSize = CGSizeMake(300, 230 + kDatePickerDialogDefaultButtonHeight + kDatePickerDialogDefaultButtonSpacerHeight)
        let dialogSize = CGSize(width: 300, height: 230 + kDatePickerDialogDefaultButtonHeight + kDatePickerDialogDefaultButtonSpacerHeight);
        //CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)
		dialogView.frame = CGRect(origin: CGPoint(x: (screenSize.width - dialogSize.width) / 2, y: (screenSize.height - dialogSize.height) / 2), size: CGSize(width: dialogSize.width, height: dialogSize.height))
	} 
	
	/* Create the dialog view, and animate opening the dialog */	
	public func show(title: String, doneButtonTitle: String = "Done", cancelButtonTitle: String = "Cancel", defaultDate: NSDate = NSDate(), datePickerMode: UIDatePickerMode = .dateAndTime, callback: @escaping DatePickerCallback) {
		self.titleLabel.text = title
		self.doneButton.setTitle(doneButtonTitle, for: .normal)
		self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
		self.datePickerMode = datePickerMode
		self.callback = callback
		self.defaultDate = defaultDate
		self.datePicker.datePickerMode = self.datePickerMode ?? .date
		self.datePicker.date = (self.defaultDate ?? NSDate()) as Date
		
		/* */		
		UIApplication.shared.windows.first!.addSubview(self)
		UIApplication.shared.windows.first!.endEditing(true)
		
		NotificationCenter.default.addObserver(self, selector: #selector(DatePickerDialog.deviceOrientationDidChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
		
		/* Anim */		
        UIView.animate(
            withDuration: 0.2, 
			delay: 0, 
			options: UIViewAnimationOptions.curveEaseInOut,
			animations: { () -> Void in
				self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4) 
				self.dialogView!.layer.opacity = 1
				self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1) 
			}, 
			completion: nil
		) 
	} 
	
	/* Dialog close animation then cleaning and removing the view from the parent */	
	private func close() { 
		NotificationCenter.default.removeObserver(self)
		
		let currentTransform = self.dialogView.layer.transform
		
		let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
		let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + Double.pi * 270 / 180), 0, 0, 0) 
		
		self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1)) 
		self.dialogView.layer.opacity = 1
		
        UIView.animate(
            withDuration: 0.2,
			delay: 0, 
			options: [],
			animations: { () -> Void in
				self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0) 
				self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1)) 
				self.dialogView.layer.opacity = 0
		}) { (finished: Bool) -> Void in
				for v in self.subviews { 
					v.removeFromSuperview() 
				} 
				
				self.removeFromSuperview() 
				self.setupView() 
				
		} 
	} 
	
	/* Creates the container view here: create the dialog, then add the custom content and buttons */	
	private func createContainerView() -> UIView { 
		let screenSize = countScreenSize()
        /*CGSizeMake(
         300,
         230
         + kDatePickerDialogDefaultButtonHeight
         + kDatePickerDialogDefaultButtonSpacerHeight) */
        let dialogSize = CGSize(width: 300, height: 230
            + kDatePickerDialogDefaultButtonHeight
            + kDatePickerDialogDefaultButtonSpacerHeight)
		
		// For the black background
        self.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: screenSize.width, height: screenSize.height));
		
		// This is the dialog's container; we attach the custom content and the buttons to this one
        /*
         CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)*/
		let dialogContainer = UIView(frame: CGRect(origin: CGPoint(x: (screenSize.width - dialogSize.width) / 2, y: (screenSize.height - dialogSize.height) / 2), size: CGSize(width: dialogSize.width, height: dialogSize.height)))
		
		// First, we style the dialog to match the iOS8 UIAlertView >>>
		let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer) 
		gradient.frame = dialogContainer.bounds
		gradient.colors = [UIColor(red: 218 / 255, green: 218 / 255, blue: 218 / 255, alpha: 1).cgColor, 
			UIColor(red: 233 / 255, green: 233 / 255, blue: 233 / 255, alpha: 1).cgColor,
			UIColor(red: 218 / 255, green: 218 / 255, blue: 218 / 255, alpha: 1).cgColor]
		
		let cornerRadius = kDatePickerDialogCornerRadius
		gradient.cornerRadius = cornerRadius
		dialogContainer.layer.insertSublayer(gradient, at: 0) 
		
		dialogContainer.layer.cornerRadius = cornerRadius
		dialogContainer.layer.borderColor = UIColor(red: 198 / 255, green: 198 / 255, blue: 198 / 255, alpha: 1).cgColor
		dialogContainer.layer.borderWidth = 1
		dialogContainer.layer.shadowRadius = cornerRadius + 5
		dialogContainer.layer.shadowOpacity = 0.1
        //CGSizeMake(0 - (cornerRadius + 5) / 2, 0 - (cornerRadius + 5) / 2)
		dialogContainer.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
		dialogContainer.layer.shadowColor = UIColor.black.cgColor
		dialogContainer.layer.shadowPath = UIBezierPath(roundedRect: dialogContainer.bounds, cornerRadius: dialogContainer.layer.cornerRadius).cgPath
		
		// There is a line above the button
        /*CGRectMake(0, dialogContainer.bounds.size.height - kDatePickerDialogDefaultButtonHeight - kDatePickerDialogDefaultButtonSpacerHeight, dialogContainer.bounds.size.width, kDatePickerDialogDefaultButtonSpacerHeight)*/
		let lineView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: dialogContainer.bounds.size.height - kDatePickerDialogDefaultButtonHeight - kDatePickerDialogDefaultButtonSpacerHeight), size: CGSize(width: dialogContainer.bounds.size.width, height: kDatePickerDialogDefaultButtonSpacerHeight)))
		lineView.backgroundColor = UIColor(red: 198 / 255, green: 198 / 255, blue: 198 / 255, alpha: 1) 
		dialogContainer.addSubview(lineView) 
		// ˆˆˆ
		
		// Title
        /*CGRectMake(10, 10, 280, 30)*/
		self.titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 280, height: 30)))
		self.titleLabel.textAlignment = NSTextAlignment.center
		self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17) 
		dialogContainer.addSubview(self.titleLabel) 
		
		self.datePicker = UIDatePicker(frame: CGRect(origin: CGPoint(x: 0, y: 30), size: CGSize(width: 0, height: 0)))
		self.datePicker.autoresizingMask = UIViewAutoresizing.flexibleRightMargin
		self.datePicker.frame.size.width = 300
		dialogContainer.addSubview(self.datePicker) 
		
		// Add the buttons
		addButtonsToView(container: dialogContainer) 
		
		return dialogContainer
	} 
	
	/* Add buttons to container */	
	private func addButtonsToView(container: UIView) { 
		let buttonWidth = container.bounds.size.width / 2
		
		self.cancelButton = UIButton(type: UIButtonType.custom) as UIButton
        /*CGRectMake(
         0,
         container.bounds.size.height - kDatePickerDialogDefaultButtonHeight,
         buttonWidth,
         kDatePickerDialogDefaultButtonHeight
         ) */
		self.cancelButton.frame = CGRect(origin: CGPoint(x: 0, y: container.bounds.size.height - kDatePickerDialogDefaultButtonHeight), size: CGSize(width: buttonWidth, height: 0))
		self.cancelButton.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 1), for: UIControlState.normal)
		self.cancelButton.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5), for: UIControlState.highlighted) 
		self.cancelButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
		self.cancelButton.layer.cornerRadius = kDatePickerDialogCornerRadius
		self.cancelButton.addTarget(self, action: #selector(DatePickerDialog.buttonTapped(sender:)), for: UIControlEvents.touchUpInside)
		container.addSubview(self.cancelButton) 
		
		self.doneButton = UIButton(type: UIButtonType.custom) as UIButton
        /*CGRectMake(
         buttonWidth,
         container.bounds.size.height - kDatePickerDialogDefaultButtonHeight,
         buttonWidth,
         kDatePickerDialogDefaultButtonHeight
         ) */
		self.doneButton.frame = CGRect(origin: CGPoint(x: buttonWidth, y: container.bounds.size.height - kDatePickerDialogDefaultButtonHeight), size: CGSize(width: buttonWidth, height: kDatePickerDialogDefaultButtonHeight))
		self.doneButton.tag = kDatePickerDialogDoneButtonTag
		self.doneButton.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 1), for: UIControlState.normal)
		self.doneButton.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5), for: UIControlState.highlighted) 
		self.doneButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14) 
		self.doneButton.layer.cornerRadius = kDatePickerDialogCornerRadius
		self.doneButton.addTarget(self, action: #selector(DatePickerDialog.buttonTapped(sender:)), for: UIControlEvents.touchUpInside)
		container.addSubview(self.doneButton) 
	} 
	
	func buttonTapped(sender: UIButton!) { 
		if sender.tag == kDatePickerDialogDoneButtonTag { 
			self.callback?(self.datePicker.date as NSDate) 
		} else { 
			
			self.callback?(nil) 
		} 
		
		close() 
	} 
	
	/* Helper function: count and return the screen's size */	
	func countScreenSize() -> CGSize { 
		let screenWidth = UIScreen.main.applicationFrame.size.width
		let screenHeight = UIScreen.main.bounds.size.height
		
		return CGSize(width: screenWidth, height: screenHeight)
	} 
	
} 
