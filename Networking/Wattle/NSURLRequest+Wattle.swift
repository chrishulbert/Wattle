//
//  NSURLRequest+Wattle.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import Foundation

extension URLRequest {
    
    /// Helper for making a URL request. This is to be used internally by the string extension
    /// in wattle, not by the rest of your app.
    /// JSON encodes parameters if any are provided. You may want to change this if your server uses, say, XML.
    /// Adds any headers specific to only this request too if provided. Any headers you use all the time should be in
    /// NSURLSessionConfiguration.wattleSessionConfiguration.
    /// You may want to extend this if your requests need any further customising, eg timeouts etc.
    static func request(url: URL, method: String, queryParameters: [String: String]?, bodyParameters: NSDictionary?, headers: [String: String]?) -> URLRequest {
        
        // If there's a querystring, append it to the URL.
        let actualURL: URL
        if let queryParameters = queryParameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = queryParameters.map({ (key, value) in URLQueryItem(name: key, value: value) })
            actualURL = components.url!
        } else {
            actualURL = url
        }
        
        // Make the request for the given method.
        var request = URLRequest(url: actualURL)
        request.httpMethod = method
        
        // Add any body JSON params (for POSTs).
        if let bodyParameters = bodyParameters {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
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
