//
//  Tag.swift
//  NoteSwiftData
//
//  Created by Neelalohith R Kashyap on 6/17/24.
//

import Foundation
import SwiftData

@Model
class Tag {
    var id: String?
    var name: String = ""
    
    @Relationship var notes: [Note]?
    @Attribute(.ephemeral) var isChecked = false
    
    init(id: String, name: String, notes: [Note]) {
        self.id = id
        self.name = name
        self.notes = notes
    }
}
