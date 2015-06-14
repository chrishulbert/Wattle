//
//  NSURLSession+Wattle.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import Foundation

    extension NSURLSession {
        
        /// Just like sharedSession, this returns a shared singleton session object.
        class var sharedWattleSession: NSURLSession {
            // The session is stored in a nested struct because you can't do a 'static let' singleton in a class extension.
            struct Instance {
                /// The singleton URL session, configured to use our custom config and delegate.
                static let session = NSURLSession(
                    configuration: NSURLSessionConfiguration.wattleSessionConfiguration(),
                    delegate: WTLURLSessionDelegate(), // Delegate is retained by the session.
                    delegateQueue: NSOperationQueue.mainQueue())
            }
            return Instance.session
        }
        
    }
