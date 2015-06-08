//
//  WTLResponse.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import Foundation

/// This wraps up all the response from a URL request together,
/// so it'll be easy for you to add any helpers/fields as you need it.
struct WTLResponse {
    // Actual fields.
    let data: NSData!
    let response: NSURLResponse!
    var error: NSError?
    
    // Helpers.
    var HTTPResponse: NSHTTPURLResponse! {
        return response as? NSHTTPURLResponse
    }
    var responseJSON: AnyObject? {
        if let data = data {
            return NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
        } else {
            return nil
        }
    }
    var responseString: String? {
        if let data = data,
            string = NSString(data: data, encoding: NSUTF8StringEncoding) {
            return String(string)
        } else {
            return nil
        }
    }
}
