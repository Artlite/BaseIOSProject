//
//  BaseViewController.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

enum SearchEvent {
	case SEARCH, CANCEL;
}

class BaseViewController: UIViewController, UISearchBarDelegate {

	var closeTap: UITapGestureRecognizer?;
	var isNeedUpdate: Bool = false;

	// MARK: Transferted functional
	// Object to transfert
	private var toTransfert: AnyObject?;
	// Transferted object
	var transfertedObject: AnyObject?;

	/**
	 Method which provide the on create functional
	 */
	override func viewDidLoad() {
		super.viewDidLoad()
		self.onCreateController();
		self.removeFromNotifications();
		self.registerForKeyboardNotifications();
		self.registerForNotifications();
		self.onInitialUpdate();
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated);
		if (self.isNeedUpdate == true) {
			self.isNeedUpdate = false;
			self.onInitialUpdate();
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated);
		if (self.needRemoveNotifications() == true) {
			self.removeFromNotifications();
			self.registerForKeyboardNotifications();
			self.registerForNotifications();
		}
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated);
		if (self.needRemoveNotifications() == true) {
			self.removeFromNotifications();
		}
	}

	/**
	 Method which provide the deinitialization of the controller
	 */
	deinit {
		self.removeFromNotifications();
	}

	/**
	 Method which provide the functional when did receive memory warning
	 */
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	/**
	 Method which provide the functional when controller is created

	 - returns: nothing to return
	 */
	func onCreateController() {
	}

	/**
	 Method which provide the removing notification when controller hiding

	 - returns: need value
	 */
	func needRemoveNotifications() -> Bool {
		return true;
	}

	/**
	 Method which provide the navigation by segue ID

	 - parameter sequeID: segue ID

	 - returns: nothing to return
	 */
	final func navigate(sequeID: String!) {
		self.navigate(sequeID: sequeID, transfertedObject: nil);
	}

	/**
	 Method which provide the navigation by segue ID

	 - author: Dmitriy Lernatovich

	 - parameter sequeID:           sequeID: segue ID
	 - parameter transfertedObject: transferted object
	 */
	final func navigate(sequeID: String!, transfertedObject: AnyObject?) {
		self.toTransfert = transfertedObject;
		DispatchQueue.main.async(execute: {
			AppLogger.info(owner: self, messageObject: sequeID as NSObject?, additional: "func navigate(sequeID: String!)");
			self.performSegue(withIdentifier: sequeID, sender: self);
		})
	}

	/**
	 Method which provide the navigation by segue ID

	 - parameter sequeID: segue ID

	 - returns: nothing to return
	 */
	final func navigate(push sequeID: String!) {
		DispatchQueue.main.async(execute: {
			AppLogger.info(owner: self, messageObject: sequeID as NSObject?, additional: "func navigate(sequeID: String!)");
			self.navigationController?.performSegue(withIdentifier: sequeID, sender: self);
		})
	}

	/**
	 Method which provide the navigation by segue ID

	 - parameter sequeID: segue ID

	 - returns: nothing to return
	 */
	final func navigateWithClosing(sequeID: String!) {
		self.dismiss(animated: false) {
			DispatchQueue.main.async(execute: {
				AppLogger.info(owner: self, messageObject: sequeID as NSObject?, additional: "func navigate(sequeID: String!)");
				self.performSegue(withIdentifier: sequeID, sender: self);
			})
		}
	}

	// MARK: Prepare for seque method
	/**
	 Method which provide the preparartion for notification

	 - parameter segue:  segue
	 - parameter sender: sender
	 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController: UINavigationController? = segue.destination as? UINavigationController;
        if (destinationNavigationController != nil) {
            let targetController: BaseViewController? = destinationNavigationController?.topViewController as? BaseViewController;
            targetController?.transfertedObject = self.toTransfert;
        } else {
            let targetController: BaseViewController? = segue.destination as? BaseViewController;
            targetController?.transfertedObject = self.toTransfert;
        }
        self.toTransfert = nil;
    }

	// MARK: Close controller

	/**
	 Method which provide the close of the controller
	 */
	final func closeController() {
		if ((self.navigationController) != nil) {
			self.navigationController?.popViewController(animated: true);
		}
		self.dismiss(animated: true, completion: nil);
	}

	/**
	 Method which provide the back pressed navigation
	 */
	final func onBackPressed() {
		if ((self.navigationController) != nil) {
			self.navigationController?.popViewController(animated: true);
		}
	}

	/**
	 Method which provide the closing of the pop controller
	 */
	final func closePopController() {
		self.dismiss(animated: true, completion: nil);
	}

	// MARK: Functional with post processing
	/**
	 Method which provide the action with post processing functional

	 - author: Dmitriy Lernatovich

	 - parameter object: object fro post processing
	 */
	final func onBackPressedWithProcessing(object: AnyObject?, event: ControllerResultEvent) {
		let controllers: [UIViewController]? = self.navigationController?.viewControllers;
		if (controllers != nil) {
			let size: Int = controllers!.count;
			if (size >= 2) {
				let baseController: BaseViewController? = controllers![size - 2] as? BaseViewController;
				self.onBackPressed();
				baseController?.onControllerResult(object: object, event: event);
				return;
			}
		}
		self.onBackPressed();
	}

	/**
	 Method which provide the closing of the previous controller and close current controller with it

	 - author: Dmitriy Lernatovich
	 */
	final func onBackPressedFromPrevious() {
		var controllerToClose: BaseViewController? = nil;
		let controllers: [UIViewController]? = self.navigationController?.viewControllers;
		if (controllers != nil) {
			let size: Int = controllers!.count;
			if (size >= 3) {
				controllerToClose = controllers![size - 3] as? BaseViewController;
			}
			if (controllerToClose != nil) {
				self.navigationController?.popToViewController(controllerToClose!, animated: true);
				return;
			}
		}
		self.onBackPressed();
	}

	/**
	 Method which provide on controller result
	 (WARNING: SHOULD BE OVERRIDEN IF NEEDED)

	 - author: Dmitriy Lernatovich

	 - parameter object: object for result
	 */
	func onControllerResult(object: AnyObject?, event: ControllerResultEvent) {

	}

	// MARK: Keyboard functional
	/**
	 Method which provide the keyboard hiding
	 */
	final func hideKeyboard() {
		self.view.endEditing(true);
	}

	// MARK: Search event
	/**
	 Method which provide the search event action

	 - parameter event: event type
	 - parameter text:  text to search
	 */
	func onSearchEvent(event event: SearchEvent, text: String?) {

	}

	// MARK: Initial refresh
	/**
	 Method which provide the setting of the need update
	 */
	final func setNeedUpdate() {
		self.isNeedUpdate = true;
		if ((self.isVisibleController() == true)
			&& (self.needImidiatellyUpdate() == true)) {
				self.onInitialUpdate();
		}
	}

	/**
	 Method which provide the initial updating
	 */
	func onInitialUpdate() {

	}

	/**
	 Method which provide the checking of the controller visibility

	 - returns: controller visibility
	 */
	final func isVisibleController() -> Bool {
		if ((self.isViewLoaded == true) && (self.view.window != nil)) {
			return true;
		}
		return false;
	}

	/**
	 Method which provide the imidiatelly update when it required

	 - returns: required value
	 */
	func needImidiatellyUpdate() -> Bool {
		return false;
	}

	/**
	 Method which provide to add of the taping to hide keyboard
	 */
	func addTapHideKeyboard() {
		GetsureHelper.addClick(target: self, view: self.view, selector: #selector(BaseViewController.hideKeyboard));
		GetsureHelper.addSwipe(target: self, view: self.view, direction: UISwipeGestureRecognizerDirection.down, selector: #selector(BaseViewController.hideKeyboard));
	}

	// MARK: Classes

	/// Class for oncontroller result event
	class ControllerResultEvent: NSObject {
		private var code: Int = -1;
		/**
		 Contructor

		 - author: Dmitriy Lernatovich

		 - parameter eventCode: event code

		 - returns: event object
		 */
		init(eventCode: Int) {
			self.code = eventCode;
		}

		/**
		 Method which provide the comparasions of the objects

		 - author: Dmitriy Lernatovich

		 - parameter object: object for compare

		 - returns: compaing value
		 */
        override func isEqual(_ object: Any?) -> Bool {
            if let compare = object as? ControllerResultEvent {
                if (self.code == compare.code) {
                    return true;
                }
            }
            return false;
        }
	}

//    /**
//     Method which provide the title setting
//
//     - parameter text: title text
//     */
//    final func setTitle(text:String?){
//        self.navigationItem.title = text;
//    }

}
