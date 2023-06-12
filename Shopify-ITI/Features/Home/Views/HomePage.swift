//
//  HomePage.swift
//  Shopify-ITI
//
//  Created by ammar on 12/06/2023.
//

import SwiftUI

struct HomePage: View {
    let items = Array(1...2) // Sample data
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    CardView()
                        .padding()
                    Text("Brands").font(.largeTitle).fontWeight(.bold) // TODO : nameriztion
                    ZStack{
                        LazyVGrid(columns: createGridColumns(), spacing: 16) {
                            ForEach(items, id: \.self) { item in
                                CardHome(imageName: "beats.fit.pro.chargingcase", title: item.description)
                            }
                        }
                        .padding()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        
                            .foregroundColor(.black)
                            .padding()
                        
                        
                    }
                }
                
            }.navigationBarItems(
                    leading: NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }, trailing:
                        HStack {
                           
                            NavigationLink(destination: FavouriteView()) {
                                Image(systemName: "heart")
                            }
                        }
                )
            
            
        }
        
    }
    
    func createGridColumns() -> [GridItem] {
        let gridItem = GridItem(.flexible(), spacing: 16)
        return [gridItem, gridItem]
    }
    
    
}
func createGridColumns() -> [GridItem] {
    let gridItem = GridItem(.flexible(), spacing: 16)
    return [gridItem, gridItem]
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Ad")
                .padding()
            
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .frame(height: 300)
        .background(Color.gray)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
struct CardHome : View {
    let imageName: String
    let title: String
    
    var body: some View {
        NavigationLink(destination: SearchView()){
            VStack {
                Image(systemName:imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                Text("brand \(title)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                
            }.background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
        }
    }
}
