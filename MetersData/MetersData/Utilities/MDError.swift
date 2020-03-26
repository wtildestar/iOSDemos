//
//  MDError.swift
//  MetersData
//
//  Created by wtildestar on 15/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

enum MDError: String, Error {
    case invalidUrl         = "This url created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case invalidToUserResponse = "There was an error retrieving Bearer Token. Please try again."
    case unableToSend       = "Unable to complete your sending request. Please check your internet connection."
}
