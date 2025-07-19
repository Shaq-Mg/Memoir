//
//  BookedView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import SwiftUI

struct BookedView: View {
    @EnvironmentObject private var vm: FormViewModel
    @Environment(\.dismiss) private var dismiss
    var date: Date
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 14) {
                    BookedRowView(title: "Name", description: vm.name)
                        .padding(.top, 32)
                    BookedRowView(title: "Service", description: vm.selectedSerivce?.title ?? "n/a")
                    BookedRowView(title: "Date", description: date.fullMonthDayYearFormat())
                    BookedRowView(title: "Time", description: vm.selectedTime?.timeForDayFormat() ?? "n/a")
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Booked")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        dismiss()
                        vm.resetFormInformation()
                    }
                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundStyle(Color(.label))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookedView(date: Date())
            .environmentObject(FormViewModel())
    }
}
