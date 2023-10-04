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
                Button("Tamamlandı olarak işaretle"){
                    todoUpdate()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()              }.alert("Tamamlandı olarak işaretlendi", isPresented: $showingAlert){
                        Button("Tamam", role: .cancel){}
                    }
            }
        }
    }
    func todoUpdate(){
        todo.isCompleted = true
        showingAlert = true
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
