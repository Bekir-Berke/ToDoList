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
    @State private var showingSheet = false
    @State private var path = NavigationPath()
    @Query private var todoItems: [ToDoItem]
    @Query (filter: #Predicate<ToDoItem> {todo in
        todo.isCompleted == false
    }) var todos: [ToDoItem]
    @Query(filter: #Predicate<ToDoItem> {todo in
        todo.isCompleted == true
    }) var completedTodos: [ToDoItem]
    var body: some View {
        NavigationStack(path: $path){
            List{
                Section(header: Text("Tamamlanmayanlar")){
                    ForEach(todos){todo in
                        HStack{
                            NavigationLink(value: todo){
                                Text(todo.title)
                                .font(.headline)
                            }
                        }
                    }.onDelete(perform: deleteTodo(_:))

                }
                Section(header: Text("Tamamlananlar")){
                    ForEach(completedTodos){todo in
                        HStack{
                            NavigationLink(value: todo){
                                Text(todo.title)
                                .font(.headline)
                                .strikethrough()
                            }
                        }
                    }.onDelete(perform: deleteTodo(_:))
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationDestination(for: ToDoItem.self){todo in
                ToDoDetailView(todo: todo)
            }
            .toolbar{
                EditButton()
                Button(action: {
                    showingSheet.toggle()
                }){
                    Image(systemName: "plus")
                }.sheet(isPresented: $showingSheet){
                    CreateToDoView()
                }
            }
        }
    }
    func deleteTodo(_ indexSet: IndexSet){
        for index in indexSet{
            let todo = todoItems[index]
            modelContext.delete(todo)
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
