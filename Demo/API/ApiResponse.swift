//
//  ApiResponse.swift
//  Demo
//
//  Created by yamaguchi on 2016/12/06.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import ObjectMapper


enum RequestStatus<T: Mappable> {
    case none
    case requesting
    case error(Error)
    case Response(T)
}
