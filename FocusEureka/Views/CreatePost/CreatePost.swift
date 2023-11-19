//
//  CreatePost.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI
import PhotosUI
struct CreatePost: View {
    @StateObject var createPostVM = CreatePostViewModel()
    @State var title: String = ""
    @State var contents: String = ""
    @State var address: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var zipcode: String = ""
    @State var start_date: String = ""
    @State var start_time: String = ""
    @State var end_date: String = ""
    @State var end_time: String = ""
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
                        .foregroundColor(Color.purple)
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
                        TextField("date start",text: $start_date)
                            .disableAutocorrection(true)
                            .focused($displayKeybaord)
                        TextField("date end",text: $end_date)
                            .disableAutocorrection(true)
                            .focused($displayKeybaord)
                    }
                    TextField("Time start",text: $start_time)
                        .disableAutocorrection(true)
                        .focused($displayKeybaord)
                    TextField("Time end",text: $end_time)
                        .disableAutocorrection(true)
                        .focused($displayKeybaord)
                }
                Button(action: {
                    Task{
                        try await createPostVM.uploadPost(title:self.title,
                                                          contents:self.contents,
                                                          address:self.address,
                                                          city:self.city,
                                                          state:self.state,
                                                          zipcode:self.zipcode,
                                                          start_date:self.start_date,
                                                          start_time:self.start_time,
                                                          end_date:self.end_date,
                                                          end_time:self.end_time,
                                                          isEvent:self.isEvent)
                    }
                }, label: {
                    Text("upload to firebase")
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
}

#Preview {
    CreatePost()
}
