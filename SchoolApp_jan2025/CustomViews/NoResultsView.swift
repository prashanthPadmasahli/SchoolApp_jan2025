//
//  NoResultsView.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import SwiftUI

struct NoResultsView: View {
    let title: String
    var body: some View {
        Text("No \(title) found. \nPlease Add \(title)")
            .font(.footnote)
            .italic()
            .foregroundStyle(.secondary)
    }
}

#Preview {
    NoResultsView(title: "Title")
}
