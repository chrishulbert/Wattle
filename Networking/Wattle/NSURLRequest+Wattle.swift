//
//  NSURLRequest+Wattle.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import Foundation

extension NSURLRequest {
    
    /// Helper for making a URL request. This is to be used internally by the string extension
    /// in wattle, not by the rest of your app.
    /// JSON encodes parameters if any are provided. You may want to change this if your server uses, say, XML.
    /// Adds any headers specific to only this request too if provided. Any headers you use all the time should be in
    /// NSURLSessionConfiguration.wattleSessionConfiguration.
    /// You may want to extend this if your requests need any further customising, eg timeouts etc.
    class func requestWithURL(URL: NSURL, method: String, queryParameters: [String: String]?, bodyParameters: NSDictionary?, headers: [String: String]?) -> NSURLRequest {

        // If there's a querystring, append it to the URL.
        let actualURL: NSURL
        if let queryParameters = queryParameters {
            let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: true)!
            components.queryItems = map(queryParameters) { (key, value) in NSURLQueryItem(name: key, value: value) }
            actualURL = components.URL!
        } else {
            actualURL = URL
        }
        
        // Make the request for the given method.
        let request = NSMutableURLRequest(URL: actualURL)
        request.HTTPMethod = method
        
        // Add any body JSON params (for POSTs).
        if let bodyParameters = bodyParameters {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(bodyParameters, options: nil, error: nil)
        }
        
        // Add any extra headers if given.
        if let headers = headers {
            for (field, value) in headers {
                request.addValue(value, forHTTPHeaderField: field)
            }
        }
        
        return request
    }
    
}
