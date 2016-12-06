//
//  APIRequest.swift
//  Demo
//
//  Created by yamaguchi on 2016/11/30.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

protocol APIRequest {
    
    var parameters: [String: AnyObject] { get }
    var baseURL: String { get }
    var path: String { get }
    var mehtod: String { get }
    
}
