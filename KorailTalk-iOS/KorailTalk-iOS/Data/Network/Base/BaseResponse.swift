//
//  BaseResponse.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

struct BaseResponse<T: Decodable>: Decodable {
    let message: String
    let data: T?
}
