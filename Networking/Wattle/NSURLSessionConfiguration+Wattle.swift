//
//  NSURLSessionConfiguration+Wattle.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import Foundation

extension NSURLSessionConfiguration {
    
    /// Just like defaultSessionConfiguration, returns a newly created session configuration object, customised
    /// from the default to your requirements.
    class func wattleSessionConfiguration() -> NSURLSessionConfiguration {
        let config = defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 20 // Make things timeout quickly.
        config.HTTPAdditionalHeaders = ["MyResponseType": "JSON"] // My web service needs to be explicitly asked for JSON.
        config.HTTPShouldUsePipelining = true // Might speed things up if your server supports it.
        return config
    }
    
}
