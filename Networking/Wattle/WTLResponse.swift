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
    let data: Data!
    let response: URLResponse!
    var error: Error?
    
    // Helpers.
    var HTTPResponse: HTTPURLResponse! {
        return response as? HTTPURLResponse
    }
    var responseJSON: Any? {
        if let data = data {
            return try? JSONSerialization.jsonObject(with: data, options: [])
        } else {
            return nil
        }
    }
    
    var responseString: String? {
        if let data = data, let string = String(data: data, encoding: .utf8) {
            return string
        } else {
            return nil
        }
    }
}
