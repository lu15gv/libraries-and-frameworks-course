//
//  ViewController.swift
//  InjectDynamicExample
//
//  Created by Luis Antonio Gomez Vazquez on 12/09/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextViewControllerTapped() {
        // 1.- Getting the dynamic framework from somewhere
        // ...
        // 2.- Creating a Bundle with the obtained file (dynamic framework)
        guard let bundle = Bundle(path: Bundle.main.bundlePath + "/MySecretFolder/SwiftFramework.framework") else {
            statusLabel?.text = "Unable to find dynamic framework"
            return
        }
        // 3.- Loading the bundle (dynamic framework) in memory
        bundle.load()
        // 4.- Creating an object from the module name and target class: Module.Class
        guard let nsObjectType = NSClassFromString("SwiftFramework.Provider") as? NSObject.Type else { return }
        let nsObject = nsObjectType.init()
        // 5.- Executing methods of the nsObject and getting the returned object (an unmanaged object)
        let unmanagedObject = nsObject.perform(Selector("getNextViewController"))
        // 6.- Casting the unmanaged object to the target object
        guard let viewController = unmanagedObject?.takeUnretainedValue() as? UIViewController else { return }
        // 7.- Eureka!!... don't do this in a productive project. YOU WILL BE BANNED FROM APPSTORE
        navigationController?.pushViewController(viewController, animated: true)
    }
}

