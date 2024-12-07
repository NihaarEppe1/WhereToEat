//
//  Item.swift
//  Where-TO-eat
//
//  Created by Nihaar Eppe on 4/23/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
