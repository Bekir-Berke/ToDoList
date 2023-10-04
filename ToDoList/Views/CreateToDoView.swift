//
//  CreateToDoView.swift
//  ToDoList
//
//  Created by Bekir Berke Yılmaz on 28.09.2023.
//

import SwiftUI
import SwiftData
struct CreateToDoView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var todoItems: [ToDoItem]
    @State private var title = ""
    @State private var userDescription = ""
    @State private var isCompleted = false
    @State private var isShowing = false
    @State private var taskIsComplete = true
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Başlık").bold()){
                    TextField("", text: $title)
                }
                Section(header: Text("Açıklama").bold()){
                    TextField("", text: $userDescription, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .textFieldStyle(.plain)
                        .labelsHidden()
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                Section{
                    Button(action: {addTodo()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()}, label: {
                        HStack{
                            Spacer()
                            Text("Ekle")
                            Spacer()
                        }
                    }).buttonStyle(.borderedProminent)
                    .alert("Listeye eklendi", isPresented: $isShowing){
                            Button("Tamam"){}
                        }
                }
                .frame(width: 100)
                .listRowInsets(.init())
                .listRowBackground(Color.clear)
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    func addTodo(){
        let todo = ToDoItem(title: title, description: userDescription, isCompleted: isCompleted)
        modelContext.insert(todo)
        isShowing = true
    }

}

#Preview {
    CreateToDoView()
}
