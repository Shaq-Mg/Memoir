//
//  CalenderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/01/2025.
//

import SwiftUI


struct CalenderView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var vm: CalenderViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, onDismiss: true, title: "Select a date")
            Spacer()
            VStack(spacing: 20) {
                calenderHeader
                HStack {
                    ForEach(vm.days, id: \.self) { day in
                        Text(day)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
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
            .environmentObject(ApptViewModel())
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
                                
                            }
                            
                        } label: {
                            Text("\(value.day)")
                                .frame(width: 46, height: 46)
                                .background(RoundedRectangle(cornerRadius: 10).fill(isPast ? Color(.systemGray4).opacity(0.5) : .icon.opacity(0.7)))
                                .foregroundStyle(isPast ? Color(.systemGray) : .dark)
                        }
                        .disabled(isPast)
                    } else {
                        Text("")
                    }
                }
                .font(.system(size: 20, weight: .semibold))
            }
        }
        .frame(height: UIScreen.main.bounds.height / 3)
    }
    
    private var calenderHeader: some View {
        HStack(spacing: 12) {
            Text(vm.selectedDate.monthYearFormat())
                .foregroundStyle(.black)
            Spacer()
            
            Button {
                withAnimation {
                    vm.selectedMonth -= 1
                }
            } label: {
                Image(systemName: "chevron.left")
            }
            .disabled(vm.isPreviousMonthDisabled())
            
            Button {
                withAnimation {
                    vm.selectedMonth += 1
                }
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .font(.system(size: 25, weight: .semibold))
        .foregroundStyle(.icon)
    }
}
