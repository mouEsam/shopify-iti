//
//  CartView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 12/06/2023.
//

import SwiftUI
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let quantity: Int
}
struct CartView: View {
    var cartItems: [Item] = [
        Item(name: "Item 1", price: 9.99, quantity: 2),
        Item(name: "Item 2", price: 14.99, quantity: 1),
        Item(name: "Item 3", price: 19.99, quantity: 3)
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(cartItems) { item in
                    CardItemView(item: item)
                }
            }
            .padding()
        }.task {
            let client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
            let localeProvider = LocaleProvider()
            let service = CartRemoteService(remoteClient: client,
                                            localeProvider: localeProvider)
            let result = await service.fetch(byId: "gid://shopify/Cart/c1-8abc7310f95b047f1dc83898369d5e18")
            print(result)
        }
    }
}
struct CardItemView: View {
    var item: Item
    
    var body: some View {
        HStack(alignment: .top) {
            Image("Test")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.headline)
                Text("Price: $\(item.price, specifier: "%.2f")")
                Spacer()

                HStack(spacing: 16) {
                    Button(action: {
                        print("plus")
                    }) {
                        Image("plus")
                            .font(.title)
                    }
                    Text("\(item.quantity)")
                        .foregroundColor(.black)
                    
                    Button(action: {
                        print("minus")

                    }) {
                        Image("minus")
                            .font(.title)
                    }
                    
                   
                }
                .foregroundColor(.blue)
            }
            Spacer()
            Button(action: {
                
            }) {
                Image( "delete")
                    .font(.title)
            }
        }
        .padding(16)
    }
}
struct AddButton: View {
    let item: Item
    let addAction: (_ item: Item) -> Void
    
    var body: some View {
        Button(action: {
            print("add")
            addAction(item)
        }) {
            Image(systemName: "plus.circle")
        }.buttonStyle(.borderless)
    }
}

struct SubtractButton: View {
    let item: Item
    let subtractAction: (_ item: Item) -> Void
    
    var body: some View {
        Button(action: {
            print("mins")

            subtractAction(item)
        }) {
            Image(systemName: "minus.circle")
        }.buttonStyle(.borderless)
    }
}

struct DeleteButton: View {
    let item: Item
    let deleteAction: (_ item: Item) -> Void
    
    var body: some View {
        Button(action: {
            print("delete")

            deleteAction(item)
        }) {
            Image(systemName: "trash.circle")
        }.buttonStyle(.borderless)
    }
}
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
