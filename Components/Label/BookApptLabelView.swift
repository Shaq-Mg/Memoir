//
//  BookApptLabelView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/06/2025.
//

import SwiftUI

struct BookApptLabelView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Book Appointment Today")
                    .font(.headline)
                
                Text("Make new booking")
                    .foregroundStyle(Color(.systemGray))
                    .font(.subheadline)
            }
            Spacer()
            
            Image(systemName: "square.and.pencil")
                .font(.system(size: 22))
                .foregroundStyle(.black, Color(.darkGray))
                .shadow(radius: 2)
        }
        .foregroundStyle(Color(.label))
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("OffWhite")))
        .overlay {
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)
                .fill(Color(.systemGray))
        }
    }
}

#Preview {
    BookApptLabelView()
}
