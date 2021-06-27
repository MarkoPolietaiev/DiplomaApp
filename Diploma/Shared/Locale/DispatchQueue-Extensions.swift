//
//  DispatchQueue-Extensions.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import Foundation

public extension DispatchQueue {
    private static var onceTracker = [String]()

    ///    Execute the given `block` only once during app's lifecycle
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self);
        defer {
            objc_sync_exit(self)
        }

        if onceTracker.contains(token) { return }
        onceTracker.append(token)
        block()
    }
}
