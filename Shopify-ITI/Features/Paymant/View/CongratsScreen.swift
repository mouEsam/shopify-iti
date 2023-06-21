//
//  CongratsScreen.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 21/06/2023.
//

import SwiftUI

struct CongratsScreen: View {
    @EnvironmentRouter private var router: AppRouter

    var body: some View {
        VStack{
            Spacer()
            Text("Success")
            Spacer()
            Button(action: {
                for _ in 1...(router.routesCount-1){
                    router.pop()

                }


            }) {
                Text("Go To Home")
                    .foregroundColor(.white)
                    .padding(.all)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .tint(.black)
            .padding(.all)

        }
    }
}

struct CongratsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CongratsScreen()
    }
}
