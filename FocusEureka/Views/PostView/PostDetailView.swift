//
//  PostDetailView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI
import MapKit

struct PostDetailView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel;
    var detailedPost:Posts
    enum userInput{
        case commentInput, userReply
    }
    @State var weekdays:[String] = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @State var dayInWeek: String?
    //    @StateObject var postVM = PostsViewModel()
    @EnvironmentObject var postVM: PostsViewModel
    @State var isGrouping: Bool = false
    @State var comment: String = ""
    @State var isCommenting: Bool = false
    @State var commentID:Int = 0
    @State var reply: String = ""
    @State var isReplying: Bool = false
    @State var replys_to:String = ""
    @FocusState var focusTextField: userInput?
    //varaible for mapkit
    @State var mapCamreaPosition: MapCameraPosition = .automatic
    @State var coordination = [MKMapItem]()
    @State var mapSelection: MKMapItem?
    @State var undefinedAddress: Bool = false
    @State var showFullScreenMap: Bool = false
    @State var displayUsername: Bool = false
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                //Images tabview
                TabView{
                    ForEach(postVM.singlePost?.image_set.urls ?? [], id: \.self){picture in
                        AsyncImage(url: URL(string:picture)) { detailedImage in
                            detailedImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
//                .frame(height:UIScreen.main.bounds.height/2)
                .frame(height:350)
                .background(Color.gray.opacity(0.1))
                //Title
                HStack{
                    Text("\(postVM.singlePost?.title ?? "")")
                        .font(.system(size:20, design: .monospaced))
                        .fontWeight(.bold)
                    
                    Spacer()
                    Text(postVM.singlePost?.owner.initials ?? "")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .foregroundStyle(Color(.white))
                        .frame(width: 30, height: 30)
                        .background(Color(.systemRed))
                        .clipShape(Circle())
                        .onTapGesture {
                            displayUsername = !displayUsername
                        }
                    if(displayUsername){
                        Text(postVM.singlePost?.owner.username ?? "")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
                //Time & lcoation
                HStack(spacing:1){
                    HStack{
                        if(postVM.singlePost?.event == true){
                            Text("     ")
                                .font(.footnote)
                            if let DateBegin = postVM.singlePost?.start_date {
                                Text("\(DateBegin)")
                                    .font(.footnote)
                            } else {
                                Text("unknown")
                                    .font(.footnote)
                            }
                            Text("-")
                                .font(.footnote)
                            if let DateEnd = postVM.singlePost?.end_date {
                                Text("\(DateEnd)")
                                    .font(.footnote)
                            } else {
                                Text("unknown")
                                    .font(.footnote)
                            }
                        }
                    }
                    HStack{
                        if let startTime = postVM.singlePost?.start_time {
                            Text("     ")
                                .font(.footnote)
                            Text("\(startTime)")
                                .font(.footnote)
                        } else {
                            Text("Time: unavailable")
                                .font(.footnote)
                        }
                        Text("-")
                            .font(.footnote)
                        if let endTime = postVM.singlePost?.end_time {
                            Text("\(endTime)")
                                .font(.footnote)
                        } else {
                            Text("unavailable")
                                .font(.footnote)
                        }
                    }
                    Spacer()
                }
                //Contents
                HStack(){
                    Text(postVM.singlePost?.contents ?? "")
                        .font(.system(size: 16))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom)
                
                //Map
                Button(action: {
                    self.showFullScreenMap = true
                }, label: {
                    Map(position: $mapCamreaPosition, selection: $mapSelection){
                        ForEach(coordination, id: \.self){ address in
                            let mark = address.placemark
                            Marker(mark.name ?? "", coordinate: mark.coordinate)
                        }
                    }
                    .frame(width: 350, height: 200)
                    .mapControls{
                        MapCompass()
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if(mapSelection != nil){
                            Button {
                                mapSelection?.openInMaps()
                            } label: {
                                Image(systemName: "map.fill")
                            }
                            .padding()
                        }
                    }
                    .overlay(alignment: .center) {
                        if(undefinedAddress ){
                            Text("Unknown Address")
                                .background(Color.mint)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                })
                .sheet(isPresented: $showFullScreenMap, content: {
                    FullScreenMapView(mapSelection: $mapSelection)
                        .environmentObject(self.postVM)
                })
                
                //address
                HStack{
                    Image(systemName: "location")
                        .imageScale(.medium)
                    Text("\(postVM.singlePost?.address ?? ""), \(postVM.singlePost?.city ?? ""), \(postVM.singlePost?.state ?? "") \(postVM.singlePost?.zipcode ?? "")")
                        .font(.footnote)
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                //posted time & Likes button
                HStack{
                    Text(" \(postVM.singlePost?.createdAt ?? "")")
                        .font(.caption2)
                        .foregroundStyle(Color.gray.opacity(0.8))
                    Spacer()
                    Button {
                        isGrouping = true
                    } label: {
                        Image(systemName: "person.2.circle")
                            .resizable()
                            .frame(width:20, height: 20)
                    }
                    Button(
                        action: {
                            Task{
                                try await postVM.addLikes(postID: postVM.singlePost?.id ?? 6, userID: loginViewModel.currentUser?.id ?? 0)
                            }
                        },
                        label: {
                            HStack(spacing:3){
                                Image(systemName: "heart.circle")
                                    .resizable()
                                    .frame(width:20, height: 20)
                                Text("\(postVM.singlePost?.post_likes?.count ?? 0)")
                                    .foregroundStyle(Color.black)
                            }
                        })
//                    Spacer()
                }
                .padding(.horizontal)
                CommentsComponent(commentsToPost: postVM.singlePost?.comments ?? [], commentID: $commentID, reply: $reply, isReplying: $isReplying, replys_to: $replys_to, isCommenting: $isCommenting)
            }
            //textfield for comment
            if(isCommenting){
                TextField("",text: $comment)
                    .disableAutocorrection(true)
                    .focused($focusTextField, equals: .commentInput)
                    .background(.gray.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                    .submitLabel(.done)
                    .onAppear{
                        focusTextField = .commentInput
                    }
                    .onSubmit {
                        Task{
                            if(!comment.isEmpty && !comment.trimmingCharacters(in: .whitespaces).isEmpty){
                                try await postVM.userInputComment(userID: loginViewModel.currentUser?.id ?? 0, postID: postVM.singlePost?.id ?? 1, userInput: comment)
                            }
                            isCommenting = false
                            comment = ""
                        }
                    }
            }
            //textfield for reply
            if(isReplying){
                TextField("",text: $reply)
                    .disableAutocorrection(true)
                    .focused($focusTextField, equals: .userReply)
                    .background(.gray.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                    .submitLabel(.done)
                    .onAppear{
                        focusTextField = .userReply
                    }
                    .onSubmit {
                        Task{
                            if(!reply.isEmpty && !reply.trimmingCharacters(in: .whitespaces).isEmpty){
                                if(replys_to.isEmpty){
                                    try await postVM.userInputReply(userID: loginViewModel.currentUser?.id ?? 0, postID: postVM.singlePost?.id ?? 0, userInput: reply, replyID: commentID)
                                }else{
                                    try await postVM.replyToResponse(userID: loginViewModel.currentUser?.id ?? 0, postID: postVM.singlePost?.id ?? 0, userInput: reply, replyID: commentID, userReplied: replys_to)
                                }
                            }
                            isReplying = false
                            reply = ""
                            replys_to = ""
                        }
                    }
            }
        }
        .task{
            Task{
                try await postVM.fetchSinglePost(postID: detailedPost.id)
                await findLocation()
            }
        }
        .sheet(isPresented: $isGrouping, content: {
            VStack(alignment: .leading){
                ScrollView(.horizontal, showsIndicators: false){
                    Spacer()
                    HStack(spacing: 0){
                        ForEach(weekdays, id: \.self) { dayOfWeek in
                            VStack{
                                Text("\(dayOfWeek)")
//                                    .frame(width: 150, height: 150)
                                Text("Number of friends available: \(postVM.friendItems.count)")
                                    .font(.caption)
                            }
                            .containerRelativeFrame(.horizontal)
                        }
                    }
                    .scrollTargetLayout()
                    Spacer()
                }
                .font(.title)
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $dayInWeek)
                .onChange(of: dayInWeek) { oldValue, newValue in
                    Task{
                        let day = String(newValue?.prefix(3) ?? "").lowercased()
                        try await postVM.avaliableFriends(userID: loginViewModel.currentUser?.id ?? 0, weekday: day)
                    }
                }
                .frame(height:200)
                Divider()
                List{
                    ForEach(postVM.friendItems) { friend in
                        HStack{
                            UserSingleCardView(initials: friend.initials, fullname: friend.fullName)
                                .frame(height:40)
                        }
                        .background(Gradient(colors: [.pink,.blue]))
                    }
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
//            .background(Gradient(colors: [.mint,.purple]))
        })
        .onAppear{
            Task{
                try await postVM.avaliableFriends(userID: loginViewModel.currentUser?.id ?? 0, weekday: "sun")
            }
        }
        
    }
    
    func findLocation() async{
        let request = MKLocalSearch.Request()
        let address = postVM.singlePost?.address ?? ""
        let city = postVM.singlePost?.city ?? ""
        let state = postVM.singlePost?.state ?? ""
        let zipcode = postVM.singlePost?.zipcode ?? ""
        let addressString = address + " " + city + " " + state + ", " + zipcode
            
        print(addressString)
        request.naturalLanguageQuery = addressString
        let results = try? await MKLocalSearch(request: request).start()
        self.coordination = results?.mapItems ?? []
        if(results?.boundingRegion == nil){
            undefinedAddress = true
        }
        self.mapCamreaPosition = .region(results?.boundingRegion ?? .defaultRegion)
    }
}

extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion{
        return .init(center: CLLocationCoordinate2D(latitude: 40.776676, longitude: -73.971321), latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}

#Preview {
    PostDetailView(
        detailedPost:
            MockData.dummyPost
    )
}
