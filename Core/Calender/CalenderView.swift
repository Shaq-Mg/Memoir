//
//  CalenderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct CalenderView: View {
    @StateObject private var vm = CalenderViewModel()
    @Environment(\.dismiss) var dismiss
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MenuHeaderView(showSideMenu: $showSideMenu, title: "Select a date")
            Spacer()
            VStack(spacing: 20) {
                CalenderHeaderView()
                    .environmentObject(vm)
                HStack {
                    ForEach(vm.days, id: \.self) { day in
                        DaysColumnView(day: day)
                    }
                }
                calenderDays
            }
            .padding(.horizontal, 2)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .padding()
            .onChange(of: vm.selectedMonth) {
                vm.selectedDate = vm.fetchSelectedMonth()
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        CalenderView(showSideMenu: .constant(false))
            .environmentObject(CalenderViewModel())
    }
}

extension CalenderView {
    private var calenderDays: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(vm.fetchDates()) { value in
                let isPast = value.date.monthDayYearFormat() < vm.currentDate?.monthDayYearFormat() ?? Date().monthDayYearFormat()
                VStack {
                    if value.day != -1 {
                        NavigationLink {
                            if !isPast {
                                FormView(showSideMenu: $showSideMenu, currentDate: value.date)
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            CalenderLabelView(isPast: isPast, calender: value)
                        }
                        .disabled(isPast)
                    } else {
                        Text("")
                    }
                }
                .font(.system(size: 24, weight: .semibold))
            }
        }
        .containerRelativeFrame(.vertical) { length, _ in
            return length / 3
        }
    }
}
