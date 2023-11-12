//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Bekir Berke Yılmaz on 29.09.2023.
//

import SwiftUI
import SwiftData

struct ToDoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = NavigationPath()
    @State private var showingAlert = false
    @Bindable var todo: ToDoItem
    var body: some View {
            Form{
                Section(header:Text("Başlık").bold()){
                    TextField("Title", text: $todo.title)
                }
                Section(header: Text("Açıklama").bold()){
                    TextField("Açıklama", text: $todo.userDescription)
                }
                Section{
                    HStack{
                        Button(){
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            todo.isCompleted.toggle()
                        } label : {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        Text("İşaretle")
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: 120)
                .listRowInsets(.init())
                .listRowBackground(Color.blue)
            }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ToDoItem.self, configurations: config)
        let sampleData = ToDoItem(title: "Örnek Başlık", description: "Örnek Açıklama", isCompleted: false)
        return ToDoDetailView(todo: sampleData).modelContainer(container)
    }catch{
        fatalError("Failed to create model container")
    }
}
