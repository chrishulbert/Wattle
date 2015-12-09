# Wattle

Wattle is an example of a super-simple Swift wrapper for NSURLConnection that makes your life smoother
when it comes to talking to your API. Basically it's a replacement for Alamofire. It looks like this:

        // Simplest possible example.
        "emojis".get { response in
            print(response.responseJSON)
        }
        
        // A querystring param.
        "meta".get(["since": "2015-01-02"]) { response in
            print(response.responseJSON)
        }	

        // Some parsing (i'd recommend you should put parsing as an extension on your model classes).
        "users".get { response in
            if let users = response.responseJSON as? [NSDictionary] {
                let names = users.map { $0["login"]! }
                print(names)
            } else {
                print("Error: \(response.error)")
            }
        }

This isn't a Cocoapod, rather the idea is that you'd use this as an example of how to build your own wrapper, or
simply copy-and-paste the Wattle folder into your project to start with, and customise it from that point as your
requirements evolve. Hopefully this way, you'll get a better understanding of how it works (and it's only 125 lines of code anyway) and it'll 'fit' better with your needs.

This project came out of the realisation that AFNetworking 2 wasn't a great match for Swift (also it has been crashy/security-buggy over the last year), and Alamofire is very feature-limited which made it difficult to use for my
needs. Finally, NSURLSession is quite a nice API, so it doesn't really need much of a wrapper anyway.

## What to look at

This is an example Xcode project that uses Wattle. Look at `Networking/ViewController.swift` to see how to use it.
Look in the `Networking/Wattle` folder to see the networking code. It's only 125 lines of code at last count! Super simple.

## Why the name?

Since Alamofire was named after the state flower of Mattt's home state, I thought I'd name this after Australia's national flower.
