//
//  CalenderButtonView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct CalenderButtonView: View {
    let imageName: String
    let action: () -> ()
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: imageName)
        }
    }
}

#Preview {
    CalenderButtonView(imageName: "chevron.left") { }
}
