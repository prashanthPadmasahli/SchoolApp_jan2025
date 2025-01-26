//
//  OverlayAddButton.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import SwiftUI

struct OverlayAddButton: ViewModifier {
    var onTapped: () -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottomTrailing, content: {
                Button(action: {
                    onTapped()
                }, label: {
                    Image(systemName: "plus")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .clipShape(Circle())
                        .shadow(radius: 5, x: 0, y: 3)
                })
                .padding()
            })
    }
}
