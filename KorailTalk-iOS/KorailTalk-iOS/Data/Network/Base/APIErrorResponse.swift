//
//  APIErrorResponse.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

struct APIErrorResponse: Decodable, Error {
    private let code: String
    let message: String
    let errors: [ValidationError]?
    
    var errorCode: APIErrorCode {
        return APIErrorCode(rawValue: code) ?? .unknown
    }
    
    struct ValidationError: Decodable {
        let field: String
        let value: String
        let reason: String
    }
}
