//
//  APIRouter.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/03.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var baseURL: String { get }
    var endPoint: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queries: [String: String]? { get }
}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        let urlString = baseURL.appending(endPoint)
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        
        var request = URLRequest(url: url)
        request.method = httpMethod
        request.httpBody = body
        
        if let headers = headers {
            headers.forEach { header in
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        request = try URLEncodedFormParameterEncoder().encode(queries, into: request)
        return request
    }
}
