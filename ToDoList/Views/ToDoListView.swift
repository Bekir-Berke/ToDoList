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
    @Query private var todoItems: [ToDoItem]
    @Query(filter: #Predicate<ToDoItem> {todo in
        todo.isCompleted == true
    }) var completedTodos: [ToDoItem]
    var body: some View {
        NavigationStack{
            List{
                ForEach(todoItems){todo in
                    VStack(alignment: .leading){
                        NavigationLink(destination: ToDoDetailView(todo: todo)){
                            if todo.isCompleted == true{
                                Text(todo.title)
                                    .font(.headline)
                                    .strikethrough()
                            }else{
                                Text(todo.title)
                                    .font(.headline)
                            }
                        }
                    }
                    HStack{
                        Button{
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            todo.isCompleted.toggle()
                        } label : {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                    }

                }.onDelete(perform: deleteTodo(_:))
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar{
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
