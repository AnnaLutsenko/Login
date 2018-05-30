//
//  RequestManager.swift
//  Login
//
//  Created by Anna on 10.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

/// Enums
enum RequestError: Error {
    case wrongUrl
    
    var localizedDescription: String {
        switch self {
        case .wrongUrl: return "Can not create url"
        }
    }
}

enum URLConstants: String, URLConvertible {
    private static let baseURL = URL(string: "https://apiecho.cf/api/")
    //
    case signUp = "signup/"
    case login = "login/"
    case getText = "get/text/"
    
    func asURL() throws -> URL {
        guard var url = URLConstants.baseURL else { throw RequestError.wrongUrl }
        url.appendPathComponent(self.rawValue)
        return url
    }
}

enum ServerError: Int, Error {
    case unknownError = -1
    case wrongData = -2
    case clientError = 422
    case userNotExists = 401
    case unauthorized = 403
    
    init(rawValue: Int) {
        
        switch rawValue {
        case ServerError.clientError.rawValue: self = .clientError
        case ServerError.userNotExists.rawValue: self = .userNotExists
        case ServerError.wrongData.rawValue: self = .wrongData
        case ServerError.unauthorized.rawValue: self = .unauthorized
        default: self = .unknownError
        }
    }
    
    init(response: HTTPURLResponse?) {
        guard let httpResponse = response else {
            self = .unknownError
            return
        }
        self.init(rawValue: httpResponse.statusCode)
    }
    
    var localizedDescription: String {
        switch self {
        case .clientError:
            return "User with that name or email already exists."
        case .userNotExists:
            return "Wrong email or password. Please try again."
        case .unauthorized:
            return "You are not authorizer or you don't have rights."
        case .wrongData:
            return "Server returned wrong data. Try later please"
        default:
            return "Ops! Something went wrong. Could you try later."
        }
    }
}

/// Protocols
protocol ErrorHandlerProtocol {
    typealias Failure = ((Error) -> Void)
}

protocol RequestManagerProtocol: ErrorHandlerProtocol {
    func request<T>(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, success: @escaping ((T) -> Void), failure: @escaping Failure)
}

/// Managers
class DefaultRequestManager: RequestManagerProtocol {
    func request<T>(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, success: @escaping ((T) -> Void), failure: @escaping (Error) -> Void) {
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                    
                case .success(let json):
                    guard let unboxableData = json as? T else {
                        failure(ServerError.wrongData)
                        return
                    }
                    SVProgressHUD.showSuccess(withStatus: nil)
                    success(unboxableData)
                    
                case .failure(_):
                    let error = ServerError(response: response.response)
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
                    failure(error)
                }
        }
    }
}
