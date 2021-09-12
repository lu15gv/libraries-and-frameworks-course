//
//  SwiftStaticLibrary.swift
//  SwiftStaticLibrary
//
//  Created by Luis Antonio Gomez Vazquez on 02/09/21.
//
import Foundation

public class SwiftClass {
    public static func pi(decimals: Int) {
        let pi = Double.pi
        print(String(format: "%.\(decimals)f", pi))
    }
}

