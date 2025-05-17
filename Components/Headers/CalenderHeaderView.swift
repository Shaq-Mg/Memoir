//
//  CalenderHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct CalenderHeaderView: View {
    @EnvironmentObject private var vm: CalenderViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Text(vm.selectedDate.monthYearFormat())
                .foregroundStyle(Color(.label))
            Spacer()
            
            CalenderButtonView(imageName: "chevron.left") {
                vm.selectedMonth -= 1
            }
            .disabled(vm.isPreviousMonthDisabled())
            .opacity(vm.isPreviousMonthDisabled() ? 0.4 : 1.0)
            
            CalenderButtonView(imageName: "chevron.right") {
                vm.selectedMonth += 1
            }
        }
        .font(.system(size: 25, weight: .semibold))
        .foregroundStyle(.accent)
    }
}

#Preview {
    CalenderHeaderView()
        .environmentObject(CalenderViewModel())
}
