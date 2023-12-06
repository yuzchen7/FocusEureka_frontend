//
//  CreatePost.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI
import PhotosUI
struct CreatePost: View {
    @EnvironmentObject var loginViewModel: LoginViewModel;
    @StateObject var createPostVM = CreatePostViewModel()
    @State var title: String = ""
    @State var contents: String = ""
    @State var address: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var zipcode: String = ""
    @State var start_date = Date()
    @State var start_time = Date()
    @State var end_date = Date()
    @State var end_time = Date()
    @State var isEvent: Bool = false
    @FocusState var displayKeybaord:Bool

    var body: some View {
        VStack{
            Form{
                Section{
                    if !createPostVM.selectedImages.isEmpty{
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack{
                                ForEach(createPostVM.selectedImages, id: \.self) {displayImg in
                                    Image(uiImage: displayImg)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 175, height: 175)
                                }
                            }
                        }
                    }
                    PhotosPicker(selection: $createPostVM.inputImages, matching: .images) {
                        Text("Upload images")
                    }
                }
                Section{
                    
                    TextEditor(text: $contents)
                        .disableAutocorrection(true)
                        .font(.custom("HelveticaNeue", size: 18))
                        .lineSpacing(5)
                        .frame(height: 260)
                        .background(Color.gray.opacity(0.1))
                        .focused($displayKeybaord)
                    
                    TextField("Title",text: $title)
                        .disableAutocorrection(true)
                        .focused($displayKeybaord)
                    TextField("Address",text: $address)
                        .disableAutocorrection(true)
                        .focused($displayKeybaord)
                    HStack{
                        TextField("City",text: $city)
                            .disableAutocorrection(true)
                            .focused($displayKeybaord)
                        TextField("State",text: $state)
                            .disableAutocorrection(true)
                            .focused($displayKeybaord)
                    }
                    TextField("zip-code",text: $zipcode)
                        .disableAutocorrection(true)
                        .focused($displayKeybaord)
                    Toggle(isOn: $isEvent) {
                        Label("Event?", systemImage: "balloon.fill")
                    }
                    .toggleStyle(.button)
                    if(isEvent){
                            DatePicker("date start", selection: $start_date, displayedComponents: .date)
                            DatePicker("date end", selection: $end_date, displayedComponents: .date)
                    }
                    HStack{
                        DatePicker("Time start", selection: $start_time, displayedComponents: .hourAndMinute)
                        DatePicker("Time end", selection: $end_time, displayedComponents: .hourAndMinute)
                    }
                }
                Button(action: {
                    Task{
                        if(!contents.isEmpty && !title.isEmpty && !address.isEmpty && !city.isEmpty && !state.isEmpty && !zipcode.isEmpty && createPostVM.selectedImages.count != 0){
                            try await createPostVM.uploadPost(title:self.title,
                                                              contents:self.contents,
                                                              address:self.address,
                                                              city:self.city,
                                                              state:self.state,
                                                              zipcode:self.zipcode,
                                                              start_date:convertDateToString(originalDate: self.start_date),
                                                              start_time:convertTimeToString(originalTime: self.start_time),
                                                              end_date:convertDateToString(originalDate: self.end_date),
                                                              end_time:convertTimeToString(originalTime: self.end_time),
                                                              isEvent:self.isEvent, ownerid: loginViewModel.currentUser?.id ?? 0)
                            title = ""
                            contents = ""
                            address = ""
                            city = ""
                            state = ""
                            zipcode = ""
                            start_date = Date.now
                            start_time = Date.now
                            end_date = Date.now
                            end_time = Date.now
                            isEvent = false;
                        }
                    }
                }, label: {
                    Text("                        post! V(^_^)V")
                })
                
            }
            if(createPostVM.isLoading){
                ProgressView()
            }
            if(displayKeybaord){
            Button(action: {
                displayKeybaord = false;
            }, label: {
                Text("Dismiss")
            })
            }
        }
    }
    
    func convertTimeToString(originalTime: Date) -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: originalTime)
    }
    
    func convertDateToString(originalDate: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: originalDate)
    }
}

#Preview {
    CreatePost()
}
