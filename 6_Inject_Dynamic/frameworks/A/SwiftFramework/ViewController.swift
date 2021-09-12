//
//  ViewController.swift
//  SwiftFramework
//
//  Created by Luis Antonio Gomez Vazquez on 12/09/21.
//

import UIKit

final class ViewController: UIViewController {
    
    private let color: UIColor = .red
    private let text: String = "Flow A"
    
    private let label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.text = text
    }
}
