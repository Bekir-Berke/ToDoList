//
//  ContentView.swift
//  ToDoList
//
//  Created by Bekir Berke Yılmaz on 28.09.2023.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var todoItems: [ToDoItem]
    var body: some View {
        NavigationStack{
            List(todoItems){ todo in
                HStack{
                    if todo.isCompleted == true{
                        NavigationLink(destination: ToDoDetailView(todo: todo)){
                            Text(todo.title)
                                .strikethrough()
                        }
                    }else{
                        NavigationLink(destination: ToDoDetailView(todo: todo)){
                            Text(todo.title)
                        }

                    }
                }
                .swipeActions{
                    Button{
                        modelContext.delete(todo)
                    } label: {
                        Text("Sil")
                    }.tint(.red)
                    
                    Button{
                        if todo.isCompleted == true{
                            todo.isCompleted = false
                        }else{
                            todo.isCompleted = true
                        }
                    } label: {
                        Text("Tamamlandı")
                    }.tint(.green)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar{
                NavigationLink(destination: CreateToDoView()){
                    Text("Ekle")
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
