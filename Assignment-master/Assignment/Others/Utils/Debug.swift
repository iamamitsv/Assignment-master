//
//  Debug.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import Foundation

final class Debug {
        static var isEnabled = true
        static func log(_ msg: @autoclosure () -> String = "", _ file: @autoclosure () -> String = #file, _ line: @autoclosure () -> Int = #line, _ function: @autoclosure () -> String = #function) {
        if isEnabled {
            let fileName = file().components(separatedBy: "/").last ?? ""
            print("\n<======================[Debug]======================>\n")
            print("[File: \(fileName)] [line: \(line())]\n[Function: \(function())]\n\(msg())")
        }
    }
}
