//
//  SwiftClass.swift
//  SwiftFramework
//
//  Created by Luis Antonio Gomez Vazquez on 11/09/21.
//

import Foundation

public class SwiftClass {
    public static func pi(decimals: Int) {
        let pi = Double.pi
        print(String(format: "%.\(decimals)f", pi))
    }
}
