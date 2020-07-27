//
//  DataItem.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import Foundation

struct DataItem: Decodable {
    let data : DataValue
    let name : String
}

enum DataType {
    case text
    case image
    case selector
}

enum DataValue: Decodable {

    case imageData(ImageData), textData(TextData),  selectorData(SelectorData)

    init(from decoder: Decoder) throws {
        if let imageData = try? decoder.singleValueContainer().decode(ImageData.self) {
            self = .imageData(imageData)
            return
        }

        if let textData = try? decoder.singleValueContainer().decode(TextData.self) {
            self = .textData(textData)
            return
        }
        
        if let selectorData = try? decoder.singleValueContainer().decode(SelectorData.self) {
            self = .selectorData(selectorData)
            return
        }

        throw DataError.missingValue
    }

    enum DataError:Error {
        case missingValue
    }

}
