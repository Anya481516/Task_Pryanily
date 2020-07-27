//
//  AllData.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import Foundation

struct AllData : Decodable {
    let data : [DataItem]
    let view : [String]
}
