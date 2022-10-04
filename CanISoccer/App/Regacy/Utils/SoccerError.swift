//
//  SoccerError.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/05.
//

import Foundation

protocol ErrorResponse: Codable { }

struct SoccerErrorResponse: ErrorResponse {
    let code: String
    let error: String
    
    func errorType() -> SoccerError {
        let error = SoccerError.init(rawValue: code)!
        return error
    }
}

enum SoccerError: String, Error {
    case serverError = "-1"
}

extension SoccerError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .serverError: return "서버 에러입니다."
        }
    }
}
