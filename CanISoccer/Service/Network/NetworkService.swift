//
//  NetworkService.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/03.
//

import Alamofire
import RxSwift

protocol NetworkServiceType {
    func load<T: Decodable>(request: URLRequestConvertible, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NetworkServiceType {
    
    private(set) var session: Session
    
    init(with session: Session = .default) {
        self.session = session
    }
    
    func load<T>(request: URLRequestConvertible, completion: @escaping ((Result<T, Error>) -> Void)) where T: Decodable {
        session.request(request)
            .responseDecodable(of: T.self ) { result in
                switch result.result {
                
                case .success(let decodable):
                    return completion(.success(decodable))

                case .failure(let error):
                    return completion(.failure(error))
                }
            }
    }
    
}
