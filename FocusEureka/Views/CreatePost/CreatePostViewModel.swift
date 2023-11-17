//
//  CreatePostViewModel.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

@MainActor
class CreatePostViewModel: ObservableObject{
    @Published var selectedImages: [UIImage] = []
    @Published var inputImages: [PhotosPickerItem] = []{
        didSet{
            setImages(pickedImages: inputImages)
        }
    }
    @Published var ImageURL: [String] = []
    @Published var isLoading = false;
    @State var fetchedPost:Posts?
    
    let storage = Storage.storage().reference()
    func setImages(pickedImages: [PhotosPickerItem]) {
        Task{
            var images: [UIImage] = []
            for img in pickedImages{
                if let data = try? await img.loadTransferable(type: Data.self){
                    if let result = UIImage(data: data){
                        images.append(result)
                    }
                }
            }
            selectedImages = images
        }
    }
    
    func uploadImage() async throws{
//        print("Started")
        isLoading = true;
        if selectedImages.isEmpty{
            return
        }
        let storage = Storage.storage().reference()
        for img in selectedImages{
//            print("looping.....")
            let imgData = img.jpegData(compressionQuality: 0.8)
            guard imgData != nil else{
                return
            }
            let pathRef = storage.child("postImages/\(UUID().uuidString).jpg")
//            let uploadTask = try await pathRef.putData(imgData!, metadata: nil) { metadata, error in
//                if (metadata !== nil && error != nil) {
//                    print("Error occur when uploading image")
//                }
//                let downloadTask = pathRef.downloadURL { url, error in
//                    if let error = error {
//                        print(error)
//                        return
//                    } else {
//                        guard let downloadURL = url else {
//                            print("asdfsafsaf")
//                            return
//                        }
//                        self.ImageURL.append("\"\(downloadURL)\"")
//                        print(self.ImageURL.count)
//                    }
//                }
//            }
            do{
                let _ = try await pathRef.putDataAsync(imgData!,metadata: nil)
                let downloadURL = try await pathRef.downloadURL()
                self.ImageURL.append("\"\(downloadURL)\"")
                print(self.ImageURL.count)
            }catch{
                print(error)
            }
            
        }
        self.selectedImages.removeAll()
        isLoading = false;
//        print("Completed")
    }
    
    func uploadPost(title:String, contents:String, address:String, city:String, state:String,
                    zipcode:String, start_date:String, start_time:String, end_date:String,
                    end_time:String, isEvent:String) async throws{
        isLoading = true;
        if selectedImages.isEmpty{
            return
        }
        let storage = Storage.storage().reference()
        do{
            for img in selectedImages{
                let imgData = img.jpegData(compressionQuality: 0.8)
                guard imgData != nil else{
                    return
                }
                let pathRef = storage.child("postImages/\(UUID().uuidString).jpg")
                
                let _ = try await pathRef.putDataAsync(imgData!,metadata: nil)
                let downloadURL = try await pathRef.downloadURL()
                self.ImageURL.append("\"\(downloadURL)\"")
            }
            fetchedPost = try await swiftxios.post(
                "http://localhost:8080/api/posts/create",
                [
                    "title":title,
                    "contents":contents,
                    "address":address,
                    "city":city,
                    "state":state,
                    "zipcode":zipcode,
                    "start_date":start_date,
                    "start_time":start_time,
                    "end_date":end_date,
                    "end_time":end_time,
                    "ownerid":1,
                    "event":isEvent,
                    "urls":ImageURL
                ],
                [
                    "application/json" : "Content-Type"
                ]
            )
        } catch Swiftxios.FetchError.invalidURL {
            print("function signIn from class Swiftxios has URL error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidResponse {
            print("function signIn from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidData {
            print("function signIn from class Swiftxios has response Data error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidObjectConvert {
            print("function signIn from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
        } catch {
            print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
        }
        self.selectedImages.removeAll()
        isLoading = false;
    }

}

