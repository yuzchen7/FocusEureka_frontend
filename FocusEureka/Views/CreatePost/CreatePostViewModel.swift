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

}

