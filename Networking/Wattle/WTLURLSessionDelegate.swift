//
//  WTLURLSessionDelegate.swift
//  Networking
//
//  Created by Chris Hulbert on 8/06/2015.
//  Copyright (c) 2015 Chris Hulbert. All rights reserved.
//

import Foundation

class WTLURLSessionDelegate: NSObject, URLSessionDelegate {
    
    // MARK: - NSURLSessionDelegate
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // For example, you may want to override this to accept some self-signed certs here.
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust &&
            Constants.selfSignedHosts.contains(challenge.protectionSpace.host) {
            // Allow the self-signed cert.
            guard let serverTrust = challenge.protectionSpace.serverTrust else { print("Invalid server trust."); return }
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            // You *have* to call completionHandler either way, so call it to do the default action.
            completionHandler(.performDefaultHandling, nil)
        }
    }
    
    // MARK: - Constants
    
    struct Constants {
        // A list of hosts you allow self-signed certificates on.
        // You'd likely have your dev/test servers here.
        // Please don't put your production server here!
        static let selfSignedHosts: Set<String> = ["dev.example.com", "test.example.com"]
    }
    
}
