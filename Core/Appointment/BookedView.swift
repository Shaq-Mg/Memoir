//
//  BookedView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 25/01/2025.
//

import SwiftUI

struct BookedView: View {
    @EnvironmentObject private var vm: ApptViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, title: "Booked")
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 14) {
                    InputDetailView(title: "Name", description: vm.name)
                        .padding(.top, 32)
                    InputDetailView(title: "Service", description: vm.selectedSerivce?.title ?? "n/a")
                    InputDetailView(title: "Date", description: vm.selectedDate.fullMonthDayYearFormat())
                    InputDetailView(title: "Time", description: vm.selectedTime?.timeForDayFormat() ?? Date().timeForDayFormat())
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookedView(showSideMenu: .constant(false))
            .environmentObject(ApptViewModel())
    }
}
