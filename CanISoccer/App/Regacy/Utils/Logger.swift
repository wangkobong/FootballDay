//
//  Logger.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

struct Logger {
    static func printLog(_ value: Any) {
        print("--------------- Logger Print -----------------")
        print(value)
        print("----------------------------------------------")
    }
    
    static func debugPrintLog(_ value: Any) {
        print("--------------- Logger DebugPrint -----------------")
        debugPrint(value)
        print("---------------------------------------------------")
    }
}
