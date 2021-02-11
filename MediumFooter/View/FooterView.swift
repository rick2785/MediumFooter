//
//  FooterView.swift
//  MediumFooter
//
//  Created by RJ Hrabowskie on 2/11/21.
//

import SwiftUI

struct FooterView: View {
    // Dark Mode
    @State var darkMode = false
    @State var offset: CGFloat = 0
    
    var body: some View {
        // gets MaxY for Animation
        HStack {
            Button(action: {}, label: {
                Image(systemName: "hands.clap.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
            })
            .frame(maxWidth: .infinity)
            
            Group {
                Button(action: {}, label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.primary)
                })
                .frame(maxWidth: .infinity)
                // Re-due Distance while scrolling
                .offset(x: offset == 0 ? 0 : 50 * (offset / 120))
                
                Button(action: {}, label: {
                    Image(systemName: "bookmark")
                        .font(.title2)
                        .foregroundColor(.primary)
                })
                .frame(maxWidth: .infinity)
                
                Button(action: {
                    withAnimation {darkMode.toggle()}
                }, label: {
                    Image(systemName: darkMode ? "sun.min.fill" : "moon")
                        .font(.title2)
                        .foregroundColor(.primary)
                })
                .frame(maxWidth: .infinity)
            }
            .offset(x: offset)
        }
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 15)
        .padding(.top)
        .frame(height: 80)
        .background(darkMode ? Color.black : Color.white)
        .preferredColorScheme(darkMode ? .dark : .light)
        .overlay(
            // Geometry Reader for getting MaxY and animations
            GeometryReader {proxy -> Color in
                let maxY = proxy.frame(in: .global).maxY
                let maxHeight = UIScreen.main.bounds.height
                
                DispatchQueue.main.async {
                    if maxY <= maxHeight {
                        if offset < 120 {
                            // Smoothly move the offset to 120
                            let progress = (maxHeight - maxY) / 100
                            
                            self.offset = progress * 120 <= 120 ? progress * 120 : 120
                        }
                    } else {
                        if offset != 0 {
                            self.offset = 0
                        }
                    }
                }
                
                return Color.clear
            },
            alignment: .bottom
        )
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
