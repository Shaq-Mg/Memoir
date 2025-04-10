//
//  ScheduleView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 31/01/2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @State private var showDayView = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, title: "Schedule")
            Spacer()
            VStack(spacing: 20) {
                calenderHeader
                HStack {
                    ForEach(calenderVM.days, id: \.self) { day in
                        Text(day)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 12)
                    }
                }
                scheduleDays
            }
            .padding(.horizontal)
            Spacer()
        }
        .fullScreenCover(isPresented: $showDayView) {
            DayView(showSideMenu: $showSideMenu, currentDate: apptVM.selectedDate)
                .environmentObject(apptVM)
        }
        .onChange(of: calenderVM.selectedMonth) {
            calenderVM.selectedDate = calenderVM.fetchSelectedMonth()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ScheduleView(showSideMenu: .constant(false))
            .environmentObject(ApptViewModel())
            .environmentObject(CalenderViewModel())
    }
}

extension ScheduleView {
    private var calenderHeader: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation {
                    calenderVM.selectedMonth -= 1
                }
            } label: {
                Image(systemName: "arrow.left")
                    .fontWeight(.semibold)
            }
            
            Spacer()
            Text(calenderVM.selectedDate.monthYearFormat())
                .foregroundStyle(.natural)
            Spacer()
            
            Button {
                withAnimation {
                    calenderVM.selectedMonth += 1
                }
            } label: {
                Image(systemName: "arrow.right")
                    .fontWeight(.semibold)
            }
        }
        .font(.system(size: 26, weight: .semibold))
        .foregroundStyle(Color.icon)
    }
    
    private var scheduleDays: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(calenderVM.fetchDates()) { value in
                VStack {
                    if value.day != -1 {
                        Button {
                            withAnimation(.spring()) {
                                apptVM.selectedDate = value.date
                                showDayView.toggle()
                            }
                        } label: {
                            CalenderLabel(day: value.day, date: value.date)
                        }
                    } else {
                        Text("")
                    }
                }
                .font(.system(size: 24, weight: .semibold))
                .frame(width: 44, height: 44)
            }
        }
        .containerRelativeFrame(.vertical, { length, _ in
            return length / 3
        })
    }
}
