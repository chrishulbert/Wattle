//
//  ViewController.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Simplest possible example.
        "emojis".get { response in
            println(response.responseJSON)
        }

        // Some parsing (i'd recommend you should put parsing as an extension on your model classes).
        "users".get { response in
            if let users = response.responseJSON as? [NSDictionary] {
                let names = users.map { $0["login"]! }
                println(names)
            } else {
                println("Error: \(response.error)")
            }
        }
        
        // A querystring param.
        "meta".get(parameters: ["since": "2015-01-02"]) { response in
            println(response.responseJSON)
        }

    }

}

