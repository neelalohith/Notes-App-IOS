//
//  Note.swift
//  NoteSwiftData
//
//  Created by Neelalohith R Kashyap on 6/17/24.
//

import Foundation
import SwiftData

@Model
class Note {
    @Attribute(.unique) var id: String?
    var content: String = ""
    var createdAt: Date = Date()
    
    @Relationship(inverse: \Tag.notes) var tags: [Tag]?
    
    init(id: String, content: String, createdAt: Date, tags: [Tag]) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.tags = tags
    }
}
