//
//  ChatView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct ChartView: View {
    @EnvironmentObject private var apptViewModel: ApptViewModel
    @EnvironmentObject private var viewModel: CalenderViewModel
    @EnvironmentObject private var vm: ChartViewModel
    @State private var currentDate = Date()
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $isMenuShowing, title: "Home")
            VStack(spacing: 14) {
                ChartStateView()
                    .padding(.vertical, 16)
                
                NavigationLink {
                    FormView(showSideMenu: $isMenuShowing, currentDate: currentDate)
                        .environmentObject(apptViewModel)
                        .navigationBarBackButtonHidden()
                } label: {
                    BookAppointmentLabel()
                }
                .padding(.bottom, 16)
                
                upcomingApptHeader
                
                BookingScrollView(currentDate: $currentDate)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    NavigationStack {
        ChartView(isMenuShowing: .constant(false))
            .environmentObject(ApptViewModel())
            .environmentObject(CalenderViewModel())
            .environmentObject(ChartViewModel())
    }
}

private extension ChartView {
    private var upcomingApptHeader: some View {
        HStack {
            HStack {
                Text("Activity")
                    .fontWeight(.light)
                    .foregroundStyle(Color(.darkGray))
                Text("Today?")
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 10).fill(.tone.gradient))
            Spacer()
            
            NavigationLink {
                DayView(showSideMenu: $isMenuShowing, currentDate: currentDate)
                    .environmentObject(apptViewModel)
                    .navigationBarBackButtonHidden()
            } label: {
                Text("See all")
                    .font(.title3)
                    .foregroundStyle(Color(.systemBlue))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.tone.gradient))
            }
        }
        .font(.title2).fontWeight(.semibold)
    }
}
