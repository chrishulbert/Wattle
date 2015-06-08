//
//  String+Wattle.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import Foundation

typealias WTLCompletion = WTLResponse -> Void

extension String {
    
    /// Simply does an HTTP GET/POST/PUT/DELETE using the receiver as the endpoint eg 'users'.
    /// This endpoint is appended to the baseURL which is specified in Constants below.
    /// These should be your main entry-point into Wattle from the rest of your app.
    /// It's an exercise to the reader to extend these to allow custom headers if you require.
    /// Also, if you think this string extension technique is a tad twee (i'll concede that's possible) you can of course
    /// make these as static functions of a class of your choosing.
    func get(parameters: [String: String]? = nil, completion: WTLCompletion) {
        requestWithMethod("GET", queryParameters: parameters, completion: completion)
    }
    func post(parameters: NSDictionary? = nil, completion: WTLCompletion) {
        requestWithMethod("POST", bodyParameters: parameters, completion: completion)
    }
    func put(parameters: NSDictionary? = nil, completion: WTLCompletion) {
        requestWithMethod("PUT", bodyParameters: parameters, completion: completion)
    }
    func delete(parameters: NSDictionary? = nil, completion: WTLCompletion) {
        requestWithMethod("DELETE", bodyParameters: parameters, completion: completion)
    }

    /// Used to contain the common code for GET and POST and DELETE and PUT.
    func requestWithMethod(method: String,
        queryParameters: [String: String]? = nil,
        bodyParameters: NSDictionary? = nil,
        completion: WTLCompletion) {
        /// Tack on the endpoint to the base URL.
        let URL = NSURL(string: self, relativeToURL: Constants.baseURL)!
        // Create the request, with the JSON payload or querystring if necessary.
        let request = NSURLRequest.requestWithURL(URL,
            method: method,
            queryParameters: queryParameters,
            bodyParameters: bodyParameters,
            headers: nil)
        let task = NSURLSession.sharedWattleSession.dataTaskWithRequest(request) {
            data, response, error in
            let wrappedResponse = WTLResponse(data: data, response: response, error: error)
            completion(wrappedResponse)
        }
        task.resume()
    }

    // MARK: - Constants
    
    struct Constants {
        /// This is the base URL for your requests.
        static let baseURL = NSURL(string: "https://api.github.com/")!
    }
}
