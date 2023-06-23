//
//  ContactUsView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 18/06/2023.
//

import SwiftUI

struct ContactUsView: View {
    var email = "support@example.com"
    var phone = "+1 (123) 456-7890"
    var address = "123 Main St, City, Country"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Contact Information")
                .font(.title)
                .bold()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                    Text("Email")
                        .font(.headline)
                    Spacer()
                }
                Text(email)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.green)
                    Text("Phone")
                        .font(.headline)
                    Spacer()
                }
                Text(phone)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                    Text("Address")
                        .font(.headline)
                    Spacer()
                }
                Text(address)
            }
            
            Spacer()
            
            Button(action: {
               
            }) {
                Text("Contact Us")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Contact Us")
    }
}


struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
