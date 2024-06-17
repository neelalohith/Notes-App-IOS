//
//  NoteSwiftDataApp.swift
//  NoteSwiftData
//
//  Created by Neelalohith R Kashyap on 6/17/24.
//

import SwiftUI
import SwiftData

@main
struct NoteSwiftDataApp: App {
    
    @State var noteSearchText: String = ""
    @State var noteSortBy = NoteSortBy.createdAt
    @State var noteOrderBy = OrderBy.descending
    
    @State var tagSearchText = ""
    @State var tagOrderBy = OrderBy.ascending
    
    var body: some Scene {
        WindowGroup {
            TabView{
                noteList
                tagList
            }
            .modelContainer(for: [
                Note.self,
                Tag.self
            ])
        }
    }
    
    var noteList: some View {
        NavigationStack{
          NoteListView(_allNotes: noteListQuery)
                .searchable(text: $noteSearchText, prompt: "Search The Notes")
                .textInputAutocapitalization(.never)
                .navigationTitle("Note View")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading){
                        Menu {
                            Picker("Sort By", selection: $noteSortBy){
                                ForEach(NoteSortBy.allCases){
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteSortBy.text, systemImage: "line.horizontal.3.decrease.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Menu {
                            Picker("Order By", selection: $noteOrderBy){
                                ForEach(OrderBy.allCases){
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteOrderBy.text, systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
        }
        .tabItem{
            Label("Notes", systemImage: "note")
        }
    }
    
    var noteListQuery: Query<Note, [Note]> {
        let sortOrder: SortOrder = noteOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Note>?
        if !noteSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(
                #Predicate{
                    $0.content.contains(noteSearchText)
            })
        }
        
        if noteSortBy == .content {
            return Query(filter: predicate, sort: \.content, order: sortOrder)
        }
        else{
            return Query(filter: predicate, sort: \.createdAt, order: sortOrder)
        }
    }
    
    var tagList: some View {
        NavigationStack{
            TagListView(_allTags: tagListQuery)
                .searchable(text: $tagSearchText, prompt: "Search the Tags")
                .navigationTitle("Tag View")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        Menu {
                            Picker("Order By", selection: $tagOrderBy){
                                ForEach(OrderBy.allCases){
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(tagOrderBy.text, systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
        }
        .tabItem{
            Label("Tags", systemImage: "tag")
        }
    }
    
    var tagListQuery: Query<Tag, [Tag]> {
        let sortOrder: SortOrder = tagOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Tag>?
        if !tagSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(
                #Predicate{
                    $0.name.contains(tagSearchText)
            })
        }
        return Query(filter: predicate, sort: \.name, order: sortOrder)
    }
}
