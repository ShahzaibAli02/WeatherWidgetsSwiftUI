//
//  Result.swift
//  App
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation
class Result<T> {
    var errorCode: Int = -1
    var errorIconName: String = "error"
    var message: String = ""
    var description: String = ""
    var data: T? = nil

    // Default initializer
    init(errorCode: Int = -1, errorIconName: String = "ic_error", message: String = "", description: String = "", data: T? = nil) {
        self.errorCode = errorCode
        self.errorIconName = errorIconName
        self.message = message
        self.description = description
        self.data = data
    }

    // Initializer for cases with data and an error
    init(errorCode: Int, message: String, data: T) {
        self.errorCode = errorCode
        self.message = message
        self.data = data
    }

    // Initializer for cases with an error code, icon name, message, and description
    init(errorCode: Int, errorIconName: String, message: String, description: String) {
        self.errorCode = errorCode
        self.errorIconName = errorIconName
        self.message = message
        self.description = description
    }

    // Initializer for cases with data only
     init(data: T) {
        self.data = data
    }
}
