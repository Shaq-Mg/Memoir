//
//  BookAppointmentLabel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct BookAppointmentLabel: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Book Appointment Today")
                Text("Add new booking")
                    .foregroundStyle(Color(.systemGray))
            }
            .font(.system(size: 18, weight: .bold))
            Spacer()
            
            Image(systemName: "square.and.pencil")
                .foregroundStyle(.black, Color(.darkGray))
                .shadow(radius: 2)
                .font(.system(size: 24))
        }
        .foregroundStyle(.natural)
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.5)))
        .overlay {
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)
                .fill(Color(.systemGray))
        }
    }
}

#Preview {
    BookAppointmentLabel()
}
