//
//  RegExpConstants.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 6/9/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

public class RegExpConstants: NSObject {

	public static let K_PHONE: String! = "^([\\+]{0,1}[0-9]{0,2}[\\(]{0,1}[0-9]{3}[\\)]{0,1}[0-9]{7})$";
	public static let K_PASSWORD: String! = "^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]).{5,60}$";
	public static let K_EMAIL: String! = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

}
