//
//  Filters.swift
//  NoteSwiftData
//
//  Created by Neelalohith R Kashyap on 6/17/24.
//

import Foundation

enum NoteSortBy: Identifiable, CaseIterable {
    var id: Self {
        self
    }
    case createdAt
    case content
    
    var text: String {
        switch self {
        case .createdAt : return "Created At"
        case .content : return "Content"
        }
    }
}

enum OrderBy: Identifiable, CaseIterable {
    var id: Self {
        self
    }
    case ascending
    case descending
    var text: String {
        switch self {
        case .ascending : return "Ascending"
        case .descending : return "Descending"
        }
    }
}
