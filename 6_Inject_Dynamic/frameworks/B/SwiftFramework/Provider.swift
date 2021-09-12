//
//  Provider.swift
//  SwiftFramework
//
//  Created by Luis Antonio Gomez Vazquez on 12/09/21.
//

import UIKit

public class Provider: NSObject {
    @objc public func getNextViewController() -> UIViewController {
        return ViewController()
    }
}
