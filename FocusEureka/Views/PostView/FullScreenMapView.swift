//
//  FullScreenMapView.swift
//  FocusEureka
//
//  Created by yuz_chen on 12/5/23.
//

import SwiftUI
import MapKit

struct FullScreenMapView: View {    
    @EnvironmentObject var postVM: PostsViewModel
    @State var mapCamreaPosition: MapCameraPosition = .automatic
    @State var coordination = [MKMapItem]()
    @Binding var mapSelection: MKMapItem?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Map(position: $mapCamreaPosition, selection: $mapSelection){
                ForEach(coordination, id: \.self){ address in
                    let mark = address.placemark
                    Marker(mark.name ?? "", coordinate: mark.coordinate)
                }
            }
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
            
            VStack {
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss")
                        .font(.system(size: 25))
                        .fontWeight(.light)
                        .padding(.horizontal)
                })
                .frame(height: 35)
                .background(
                    RoundedRectangle(cornerRadius: 5) // 圆角矩形作为背景
                        .stroke(Color.pink.opacity(0.3), lineWidth: 1) // 边框样式
                        .fill(.white)
                )
                .foregroundStyle(Color.pink.opacity(0.9))
            }
        }
        .task{
            Task{
                await findLocation()
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
        self.mapCamreaPosition = .region(results!.boundingRegion)
    }
    
}

//#Preview {
//    FullScreenMapView()
//}
