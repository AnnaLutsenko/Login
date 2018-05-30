//
//  DataProvider.swift
//  Login
//
//  Created by Anna on 27.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import Alamofire

/// Protocols
protocol AuthorizatorProtocol: ErrorHandlerProtocol {
    typealias AccessToken = String
    typealias SucceedAuthorized = ((AccessToken) -> Void)
    
    var accessToken: AccessToken? { get }
    func signUp(name: String, email: String, password: String, success: @escaping SucceedAuthorized, failure: @escaping Failure)
    func login(email: String, password: String, success: @escaping SucceedAuthorized, failure: @escaping Failure)
}

protocol DataProviderProtocol: ErrorHandlerProtocol {
    func getText(success: @escaping ((String) -> Void), failure: @escaping Failure)
}

/// Data Providers
class NetworkDataProvider: DataProviderProtocol, AuthorizatorProtocol {
    static let shared = NetworkDataProvider()
    /// Keys for parsing data
    private struct Constants {
        static let accessTokenKey = "access_token"
        static let dataKey = "data"
        static let nameKey = "name"
        static let emailKey = "email"
        static let passwordKey = "password"
        static let authKey = "Authorization"
        static let bearer = "Bearer"
    }
    
    private let requestManager: RequestManagerProtocol
    private (set) var accessToken: AuthorizatorProtocol.AccessToken?
    
    init(requestManager: RequestManagerProtocol = DefaultRequestManager()) {
        self.requestManager = requestManager
    }
    
    func getText(success: @escaping ((String) -> Void), failure: @escaping ErrorHandlerProtocol.Failure) {
        guard let auth = self.accessToken else {
            failure(ServerError.unauthorized)
            return
        }
        
        let header = [Constants.authKey: "\(Constants.bearer) \(auth)"]
        
        requestManager.request(URLConstants.getText, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header, success: { (dict: [String : Any]) in
            guard let text = dict[Constants.dataKey] as? String else {
                failure(ServerError.wrongData)
                return
            }
            success(text)
        }, failure: failure)
    }
    
    func signUp(name: String, email: String, password: String, success: @escaping AuthorizatorProtocol.SucceedAuthorized, failure: @escaping ErrorHandlerProtocol.Failure) {
        let body = [Constants.nameKey: name,
                    Constants.emailKey: email,
                    Constants.passwordKey: password]
        requestManager.request(URLConstants.signUp, method: .post, parameters: body, encoding: URLEncoding.default, headers: nil, success: { [weak self] (dictionary: [String : Any]) in
            self?.processAuthResponse(response: dictionary, success: success, failure: failure)
            }, failure: failure)
    }
    
    func login(email: String, password: String, success: @escaping AuthorizatorProtocol.SucceedAuthorized, failure: @escaping ErrorHandlerProtocol.Failure) {
        let body = [Constants.emailKey: email,
                    Constants.passwordKey: password]
        requestManager.request(URLConstants.login, method: .post, parameters: body, encoding: URLEncoding.default, headers: nil, success: { [weak self] (dictionary: [String : Any]) in
            self?.processAuthResponse(response: dictionary, success: success, failure: failure)
            }, failure: failure)
    }
    
    private func processAuthResponse(response: ([String : Any]), success: @escaping AuthorizatorProtocol.SucceedAuthorized, failure: @escaping ErrorHandlerProtocol.Failure) {
        guard let data = response[Constants.dataKey] as? [String : Any],
            let accessToken = data[Constants.accessTokenKey] as? AccessToken else {
                failure(ServerError.wrongData)
                return
        }
        self.accessToken = accessToken
        success(accessToken)
    }
    
}
