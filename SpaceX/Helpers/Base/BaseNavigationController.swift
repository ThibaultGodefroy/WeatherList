//
//  BaseNavigationController.swift
//  ONP
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
	
	override var childForStatusBarStyle: UIViewController? { self.topViewController }
}
