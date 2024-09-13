//
//  ContentView.swift
//  Persona-IM-Swift
//  
//  Created by shsw228 on 2024/09/13
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Adjust for Android Layout
        ZStack(alignment: .topLeading){
            // Background
            Image(ImageResource.Res.bgSplatterBackground)
                .resizable()
                .frame(maxWidth: .infinity)

            Image(ImageResource.Res.logoIm)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .safeAreaPadding(.top)
                .offset(x: 8,y: -4)
                // dp can't convert to pt. But ignore for ease.
        }.background(.red)
    }
}

#Preview {
    ContentView()
    
}
